//
//  SigQualFactory.m
//  iOSPingNonARC
//
//  Created by Dirk Lewis on 5/25/12.
//  Copyright (c) 2012 Optima HCS. All rights reserved.
//

#import "SigQualFactory.h"
#import "PingDataAggregator.h"

@implementation SigQualFactory

+ (PingDataAggregator*)pingTestOfHost:(NSString*)hostName delegate:(id<PingDataAggregatorDelegate>)delegate{
    PingDataAggregator *pa = [[PingDataAggregator alloc]initWithHostName:hostName numberOfPings:50 packetSizeBytes:0 pingVarianceMilliseconds:5 pingVarianceThreshold:2];
    [pa setPingSendInterval:0.25f];
    [pa setDelegate:delegate];
    return pa;
}

+ (PingDataAggregator*)continuousPingOfHost:(NSString*)hostName delegate:(id<PingDataAggregatorDelegate>)delegate{
    
    PingDataAggregator *pa = [[PingDataAggregator alloc]initWithHostName:hostName numberOfPings:50 packetSizeBytes:0 pingVarianceMilliseconds:10 pingVarianceThreshold:5];
    [pa setPingSendInterval:1.00f];
    [pa setDelegate:delegate];
    return pa;
    
}

@end
