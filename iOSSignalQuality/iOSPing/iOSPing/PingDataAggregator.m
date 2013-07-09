//
//  pingDataAggregator.m
//  iOSPing
//
//  Created by Dirk Lewis on 5/22/12.
//  Copyright (c) 2012 Optima HCS. All rights reserved.
//

#import "PingDataAggregator.h"
#import <SystemConfiguration/CaptiveNetwork.h>
#import "NSString+ShortError.h"
#import "NSMutableData+RandomDataGeneration.h"
#import "SignalQualityConstants.h"

#include <netdb.h>
#include <sys/socket.h>

@interface PingDataAggregator ()

@property (copy,nonatomic)NSString *hostName;
@property (copy,nonatomic)NSString *ipAddress;
@property (nonatomic)SimplePing *pinger;
@property (nonatomic)NSMutableArray *pingTimeData;
@property (nonatomic)NSMutableDictionary *sentPingRequests;
@property (assign,nonatomic)NSInteger pingVarianceMilliseconds;
@property (assign,nonatomic)NSInteger pingVarianceAlertThreshold;
@property (assign,nonatomic)NSInteger numberOfPings;

@property (nonatomic)NSMutableArray *varianceData;
@property (nonatomic)NSTimer *timer;
@property (nonatomic)NSData *dataPacket;

- (void)sendPing;
- (void)sendPingFinished;
- (void)reset;
- (void)doesPingVarianceCountExceedThreshold;
- (BOOL)doesPingExceedVariance:(NSNumber*)pingResponceTime;
@end

@implementation PingDataAggregator{

    NSInteger _pingCounter;
}

@synthesize pinger = _pinger;
@synthesize pingVarianceMilliseconds = _pingVarianceMilliseconds;
@synthesize pingVarianceAlertThreshold = _pingVarianceAlertThreshold;
@synthesize sentPingRequests = _sentPingRequests;
@synthesize pingTimeData = _pingTimeData;
@synthesize hostName = _hostName;
@synthesize ipAddress = _ipAddress;
@synthesize pingSendInterval = _pingSendInterval;
@synthesize delegate = _delegate;
@synthesize isRunning = _isRunning;
@synthesize varianceData = _varianceData;
@synthesize timer = _timer;
@synthesize numberOfPings = _numberOfPings;
@synthesize dataPacket = _dataPacket;


- (id)init
{
    self = [super init];
    if (self) {
        _pingTimeData = [[NSMutableArray alloc]init];
        _sentPingRequests = [[NSMutableDictionary alloc]init];
        _hostName = @"google.com";
        _numberOfPings = 0;
        _dataPacket = nil;
        _pingVarianceMilliseconds = 5;
        _pingVarianceAlertThreshold = 5;

        _pingSendInterval = 1.0;
        _varianceData = [[NSMutableArray alloc]init];
        _pinger   = nil;
    }
    return self;
}

- (id)initWithHostName:(NSString*)hostName numberOfPings:(NSInteger)numberOfPings packetSizeBytes:(NSInteger)packetSize pingVarianceMilliseconds:(NSInteger)varianceMS pingVarianceThreshold:(NSInteger)varianceThreshold{
    
    self = [self init];
    if (self) {
        _hostName = hostName;
        _numberOfPings = numberOfPings;

        if (packetSize > 0) {
            _dataPacket = [NSMutableData randomDataWithLength:packetSize];
        }
        _pingVarianceMilliseconds = varianceMS;
        _pingVarianceAlertThreshold = varianceThreshold;

    }
    return self;
}

#pragma Public methods

- (void)start{
    [self reset];
    self.pinger = [SimplePing simplePingWithHostName:self.hostName];
    [self.pinger setDelegate:self];
    [self.pinger start];
    self.timer = nil;
    if (self.numberOfPings == 0) {
        self.timer = [NSTimer scheduledTimerWithTimeInterval:self.pingSendInterval target:self selector:@selector(pingTimerContinuous:) userInfo:nil repeats:YES];
    }
    else {
        self.timer = [NSTimer scheduledTimerWithTimeInterval:self.pingSendInterval target:self selector:@selector(pingTimer:) userInfo:nil repeats:YES];
    }
}

- (void)stop{
    
    [self.pinger stop];
    [self setPinger:nil];
    [self setIsRunning:NO];
    [self sendPingFinished];
    [[self timer]invalidate];
}

- (void)abort{
    [self.pinger stop];
    [self setPinger:nil];
    [self setIsRunning:NO];
    [[self timer]invalidate];
}

- (void)resetHostName:(NSString*)hostName{
    
    [self abort];
    [self reset];
    self.hostName = hostName;    
}

- (NSString*)hostName{

    return _hostName;
}

#pragma mark - Private Methods
- (void)clearUnresolvedPings{

    NSDate *end = [NSDate date];
    
    if ([self.sentPingRequests count] > 0) {
        
        for (NSDate *date in [self.sentPingRequests allValues]) {
            
            NSString *key = [[self.sentPingRequests allKeysForObject:date]objectAtIndex:0];
            NSTimeInterval unresolvedDateInterval = [end timeIntervalSinceDate:date];
            NSNumber *unresolvedMiliseconds = [NSNumber numberWithFloat:(unresolvedDateInterval *1000)];
                        
            if ([self doesPingExceedVariance:unresolvedMiliseconds]) {
                NSMutableDictionary *unresolvedPingData = [NSMutableDictionary dictionary];
                [unresolvedPingData setObject:key forKey:kPingkeyKey];
                [unresolvedPingData setObject:unresolvedMiliseconds forKey:kPingResponseTimeKey];
                [unresolvedPingData setObject:[self pingAverage] forKey:kPingAverageKey];
                [unresolvedPingData setObject:[NSNumber numberWithBool:YES] forKey:kPingExceededThresholdKey];
                [unresolvedPingData setObject:[NSNumber numberWithBool:YES] forKey:kUnresolvedPingKey];

                [self doesPingVarianceCountExceedThreshold];
                [self.delegate pingDataAggregatorDidReceiveResponse:unresolvedPingData];
                [self.pingTimeData addObject:unresolvedMiliseconds];
                [self.sentPingRequests removeObjectForKey:key];
                [self.pingTimeData addObject:unresolvedMiliseconds];
            }
        }
    }    
}

- (void)reset{
    
    [_pingTimeData removeAllObjects];
    [_sentPingRequests removeAllObjects];
    [_varianceData removeAllObjects];
    _pingCounter = 0;
    
}

- (NSDictionary*)networkIdentifiersDictionary{

    CFArrayRef array = CNCopySupportedInterfaces();
    NSDictionary *dictionary = (__bridge NSDictionary*)CNCopyCurrentNetworkInfo(CFArrayGetValueAtIndex(array, 0));
    CFRelease(array);
    
    NSDictionary *temp = [[NSDictionary alloc] initWithDictionary:dictionary];
    dictionary = nil;
    return temp;
}

- (void)sendPingFinished{
    
    NSMutableDictionary *results = [NSMutableDictionary dictionary];
    
    if (self.varianceData) {
        [results setObject:self.varianceData forKey:kPingVarianceDataKey];
    }
    
    float quality = 0;
    float adjPingThreshold = _pingVarianceAlertThreshold + 1;//we are triggering on breaking threshold not hitting it.
    
    quality = 100 - (([self.pingThresholdExceededCount intValue] * 100) / adjPingThreshold);
    [results setObject:[NSNumber numberWithFloat:quality] forKey:kSignalQualityPerscentKey];
    [self.delegate pingDataAggregatorDidFinish:results];
}

- (void)sendPing{
    [self.pinger sendPingWithData:self.dataPacket];
}

static NSString * DisplayAddressForAddress(NSData * address){
    
    int         err;
    NSString *  result;
    char        hostStr[NI_MAXHOST];
    
    result = nil;

    if (address != nil) {
        err = getnameinfo([address bytes], (socklen_t) [address length], hostStr, sizeof(hostStr), NULL, 0, NI_NUMERICHOST);
        if (err == 0) {
            result = [NSString stringWithCString:hostStr encoding:NSASCIIStringEncoding];
            assert(result != nil);
        }
    }
    
    return result;
}

#pragma mark - Aggregates
- (NSNumber*)pingMinimum{
    
    if (![self.pingTimeData valueForKeyPath:@"@min.floatValue"]) {
        return [NSNumber numberWithFloat:0.0f];
    }
    return [self.pingTimeData valueForKeyPath:@"@min.floatValue"];
}

- (NSNumber*)pingMaximum{
    
    if (![self.pingTimeData valueForKeyPath:@"@max.floatValue"]) {
        return [NSNumber numberWithFloat:0.0f];
    }
    return [self.pingTimeData valueForKeyPath:@"@max.floatValue"];
}

- (NSNumber*)pingAverage{
    
    if (![self.pingTimeData valueForKeyPath:@"@avg.floatValue"]) {
        return [NSNumber numberWithFloat:0.0f];
    }
    return [self.pingTimeData valueForKeyPath:@"@avg.floatValue"];
}

- (NSNumber*)totalPingRequests{
    int total = ([self.sentPingRequests count] + [self.pingTimeData count]);
    return [NSNumber numberWithInt:total];
}

- (NSNumber*)pingThresholdExceededCount{
    return [NSNumber numberWithInt:[self.varianceData count]];
}

#pragma mark - Ping Timers
- (void)pingTimerContinuous:(NSTimer*)timer{

    [self sendPing];
}

- (void)pingTimer:(NSTimer*)timer{
    
    if (_pingCounter <= self.numberOfPings) {
        [self sendPing];
        _pingCounter ++;
    }
    else {
        [_timer invalidate];
        _pingCounter = 0;
        [self stop];
    }
}

#pragma mark - Variance calculations

- (BOOL)doesPingExceedVariance:(NSNumber*)pingResponceTime{
    float averageTime = [[self pingAverage]floatValue];

    if (averageTime == 0) {
        return NO;
    }
    
    float responseTime = [pingResponceTime floatValue];
    float varianceAdjustment = self.pingVarianceMilliseconds;
    float diffTime = responseTime - averageTime;

    if (diffTime > varianceAdjustment) {
        NSMutableDictionary *pingData = [NSMutableDictionary dictionary];
        [pingData setObject:pingResponceTime forKey:@"PingResponseTime"];
        [pingData setObject:[self pingAverage] forKey:@"PingAverage"];
        [pingData setObject:[NSNumber numberWithFloat:diffTime] forKey:@"PingDifference"];
        [self.varianceData addObject:pingData];
        return YES;
    }
    
    return NO;
}

- (void)doesPingVarianceCountExceedThreshold{

    if ([self.varianceData count] > self.pingVarianceAlertThreshold) {
        [self.delegate pingDataAggregatorDidExceedVarianceThreshold];
    }
}

#pragma mark - Ping delegate

- (void)simplePing:(SimplePing *)pinger didStartWithAddress:(NSData *)address{
    // Send the first ping straight away.
    self.ipAddress = DisplayAddressForAddress(address);
    [self.delegate pingDataAggregatorDidStart:[NSString stringWithFormat:@"Host: %@ \nAddress: %@ \n",self.hostName, self.ipAddress]];
    [self setIsRunning:YES];
}

- (void)simplePing:(SimplePing *)pinger didSendPacket:(NSData *)packet{
    [self clearUnresolvedPings];
    NSString *key = [NSString stringWithFormat:@"#%u - #%u",(unsigned int) OSSwapBigToHostInt16(((const ICMPHeader *) [packet bytes])->sequenceNumber),(unsigned int) OSSwapBigToHostInt16(((const ICMPHeader *) [packet bytes])->identifier)];   
    [_sentPingRequests setObject:[NSDate date] forKey:key];
}

- (void)simplePing:(SimplePing *)pinger didReceivePingResponsePacket:(NSData *)packet{
    NSDate *end = [NSDate date];
    NSString *key = [NSString stringWithFormat:@"#%u - #%u",(unsigned int) OSSwapBigToHostInt16([SimplePing icmpInPacket:packet]->sequenceNumber),(unsigned int) OSSwapBigToHostInt16([SimplePing icmpInPacket:packet]->identifier)];
    NSDate *start = [self.sentPingRequests valueForKey:key];
    
    if (start) {
        
        NSTimeInterval diff = [end timeIntervalSinceDate:start];
        NSNumber *milliseconds = [NSNumber numberWithFloat:(diff * 1000)];
        NSMutableDictionary *pingData = [NSMutableDictionary dictionary];
        [pingData setObject:key forKey:kPingkeyKey];
        [pingData setObject:milliseconds forKey:kPingResponseTimeKey];
        [pingData setObject:[self pingAverage] forKey:kPingAverageKey];
        [pingData setObject:[NSNumber numberWithBool:NO] forKey:kPingExceededThresholdKey];
        [pingData setObject:[NSNumber numberWithBool:NO] forKey:kUnresolvedPingKey];

        if ([self doesPingExceedVariance:milliseconds]) {
            [pingData setObject:[NSNumber numberWithBool:YES] forKey:kPingExceededThresholdKey];
            [self doesPingVarianceCountExceedThreshold];
        }
        
        [self.sentPingRequests removeObjectForKey:key];
        [self.delegate pingDataAggregatorDidReceiveResponse:pingData];
        [self.pingTimeData addObject:milliseconds];
    }
}

- (void)simplePing:(SimplePing *)pinger didReceiveUnexpectedPacket:(NSData *)packet{
    const ICMPHeader *  icmpPtr;
    
    icmpPtr = [SimplePing icmpInPacket:packet];
    if (icmpPtr != NULL) {
        [self.delegate pingDataAggregatorDidReceiveErrorMessage:[NSString stringWithFormat:@"#%u unexpected ICMP type=%u, code=%u, identifier=%u", (unsigned int) OSSwapBigToHostInt16(icmpPtr->sequenceNumber), (unsigned int) icmpPtr->type, (unsigned int) icmpPtr->code, (unsigned int) OSSwapBigToHostInt16(icmpPtr->identifier)]];
    } else {
        [self.delegate pingDataAggregatorDidReceiveErrorMessage:[NSString stringWithFormat:@"unexpected packet size=%zu", (size_t) [packet length]]];
    }
}

- (void)simplePing:(SimplePing *)pinger didFailWithError:(NSError *)error{
    [self.delegate pingDataAggregatorDidReceiveErrorMessage:[NSString stringWithFormat:@"Ping failed with error: %@", [NSString shortErrorFromError:error]]];   
}

- (void)simplePing:(SimplePing *)pinger didFailToSendPacket:(NSData *)packet error:(NSError *)error{
    [self.delegate pingDataAggregatorDidReceiveErrorMessage:[NSString stringWithFormat:@"Ping failed with error: %@", [NSString shortErrorFromError:error]]];   
}

#pragma mark - Description

- (NSString*)description{
    NSString *description = [NSString stringWithFormat:@"\nHost Name:%@\nNumber of Pings:%i\nInterval:%f\nPing Variance:%i\nPing Theshold:%i",_hostName,_numberOfPings,_pingSendInterval,_pingVarianceMilliseconds,_pingVarianceAlertThreshold];
    return description;
}
@end
