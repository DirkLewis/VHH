//
//  pingDataAggregator.h
//  iOSPing
//
//  Created by Dirk Lewis on 5/22/12.
//  Copyright (c) 2012 Optima HCS. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "SimplePing.h"

@protocol PingDataAggregatorDelegate <NSObject>


- (void)pingDataAggregatorDidExceedVarianceThreshold;
- (void)pingDataAggregatorDidReceiveResponse:(NSDictionary*)pingData;
- (void)pingDataAggregatorDidFinish:(NSDictionary*)signalResults;
- (void)pingDataAggregatorDidStart:(NSString*)message;
- (void)pingDataAggregatorDidReceiveErrorMessage:(NSString*)errorMessage;

@end

@interface PingDataAggregator : NSObject <SimplePingDelegate>

@property (assign,nonatomic)BOOL isRunning;
@property (unsafe_unretained,nonatomic) id<PingDataAggregatorDelegate> delegate;
@property (assign,nonatomic)float pingSendInterval;

//- (id)init;
- (id)initWithHostName:(NSString*)hostName numberOfPings:(NSInteger)numberOfPings packetSizeBytes:(NSInteger)packetSize pingVarianceMilliseconds:(NSInteger)varianceMS pingVarianceThreshold:(NSInteger)varianceThreshold;
- (void)start;
- (void)stop;
- (void)resetHostName:(NSString*)hostName;
- (void)abort;

- (NSNumber*)pingMinimum;
- (NSNumber*)pingMaximum;
- (NSNumber*)pingAverage;
- (NSNumber*)totalPingRequests;
- (NSNumber*)pingThresholdExceededCount;
- (NSDictionary*)networkIdentifiersDictionary;
- (NSString*)hostName;
@end

