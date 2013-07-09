//
//  ReachabilityStateMachine.h
//  StateMachineTestApp
//
//  Created by Dirk Lewis on 7/22/12.
//  Copyright (c) 2012 VideoHooHaa. All rights reserved.
//

#import <StateMachineLibrary/StateMachine.h>

#define kAuthManagerConnectedNotAuthenticatedState     0
#define kAuthManagerConnectedAuthenticatedState        1
#define kAuthManagerDisconnectedAuthenticatedState     2
#define kAuthManagerDisconnectedNotAuthenticatedState  3
#define kAuthManagerStartingState                      4
#define kAuthManagerFinalState                         5

#define kReachabilityIdleStateTag                       0
#define kReachabilityChangedStateTag                    1
#define kReachabilityFastCheckingConnectionStateTag     2
#define kReachabilityMonitorServiceForChangeStateTag    3
#define kReachabilityServiceConnectedStateTag           4
#define kReachabilityServiceDisconnectedStateTag        5
#define kReachabilityReachDisconnectedStateTag          6
#define kReachabilityFinalStateTag                      7

typedef enum {
	DeviceConnectionTypeDisconnected = 0,
	DeviceConnectionTypeConnected,
	DeviceConnectionTypeUnknownState
} DeviceConnectionType;

@interface ReachabilityStateMachine : StateMachine
+ (NSArray*)createReachabilityStates;
@end
