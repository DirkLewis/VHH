//
//  SigQualFactory.h
//  iOSPingNonARC
//
//  Created by Dirk Lewis on 5/25/12.
//  Copyright (c) 2012 Optima HCS. All rights reserved.
//

#import <UIKit/UIKit.h>
@class PingDataAggregator;
@protocol PingDataAggregatorDelegate;


@interface SigQualFactory : NSObject
+ (PingDataAggregator*)pingTestOfHost:(NSString*)hostName delegate:(id<PingDataAggregatorDelegate>)delegate;
+ (PingDataAggregator*)continuousPingOfHost:(NSString*)hostName delegate:(id<PingDataAggregatorDelegate>)delegate;
@end
