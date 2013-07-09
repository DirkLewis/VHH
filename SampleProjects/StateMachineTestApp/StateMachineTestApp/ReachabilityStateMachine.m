//
//  ReachabilityStateMachine.m
//  StateMachineTestApp
//
//  Created by Dirk Lewis on 7/22/12.
//  Copyright (c) 2012 VideoHooHaa. All rights reserved.
//

#import "ReachabilityStateMachine.h"
#import <StateMachineLibrary/StateMachineHeaders.h>
#import "Reachability.h"

@interface ReachabilityStateMachine()
@property (strong,nonatomic)Reachability* reachability;

@end

@implementation ReachabilityStateMachine{

}
@synthesize reachability = _reachability;

- (void)start{
    [super start];
    self.reachability = [Reachability reachabilityWithHostName:@"Google.com"];
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(reachHasChanged:) name:kReachabilityChangedNotification object:nil];
    [self.reachability startNotifier];
}

#pragma mark - Reachability call back

- (void)reachHasChanged:(NSNotification*)notification{
    Reachability *reach = [notification object];
    [self nextStateByName:@"NetworkMonitor.Reach.Changed" stateData:reach];
}

#pragma mark - state creation
+ (NSArray*)createReachabilityStates{

    NSMutableArray *states = [NSMutableArray array];
    
    State *idleState;
    State *reachChangedState;
    State *fastCheckingConnectionState;
    State *monitorServiceForChangeState;
    State *reachDisconnectedState;
    State *serviceDisconnectedState;
    State *serviceConnectedState;
    State *finalState;
    
    idleState = [[State alloc]initWithStateName:@"NetworkMonitor.IdleState" stateType:StateMachineInitialStateType afterDelay:0 stateDrainType:StateDrainTypeClose | StateDrainTypeMustNotDrain enterStateBlock:^(State *state, id stateData) {
        //empty initial state
        
    }];
    
    reachChangedState = [[State alloc]initWithStateName:@"NetworkMonitor.Reach.Changed" stateType:StateMachineOperationalStateType afterDelay:0 stateDrainType:StateDrainTypeClose | StateDrainTypeMustNotDrain enterStateBlock:^(State *state, id stateData) {
        
        DLog(@"REACH HAS CHANGED!! :: %@",state.stateName);
        
        Reachability *reach = (Reachability*)stateData;
        
        if ([reach isKindOfClass:[Reachability class]] == YES) {
            
            NetworkStatus status = [reach currentReachabilityStatus];
            
            switch (status) {
                case NotReachable:
                    [state nextStateByName:@"NetworkMonitor.Reach.Disconnected" stateData:reach];
                    break;
                case ReachableViaWiFi:
                case ReachableViaWWAN:
                    [state nextStateByName:@"NetworkMonitor.fastCheckingConnection" stateData:reach];
                    break;
                default:
                    break;
            }
        }
    }];
    
    fastCheckingConnectionState = [[State alloc]initWithStateName:@"NetworkMonitor.fastCheckingConnection" stateType:StateMachineOperationalStateType afterDelay:0 stateDrainType:StateDrainTypeMustDrain enterStateBlock:^(State *state, id stateData) {
        
        NSString *address = [NSString stringWithFormat:@"http://google.com"];
        
        NSURL *url = [NSURL URLWithString:address];
        NSURLRequest *request = [NSURLRequest requestWithURL:url cachePolicy:NSURLRequestUseProtocolCachePolicy timeoutInterval:10];
        NSURLResponse *response;
        NSError *error;
        [NSURLConnection sendSynchronousRequest:request returningResponse:&response error:&error];
        
        if (response && !error) {
            [state nextStateByName:@"NetworkMonitor.Service.Connected" stateData:stateData];
        }
        else {
            [state nextStateByName:@"NetworkMonitor.Service.Disconnected" stateData:stateData];
            
        }
        
    }];
    
    monitorServiceForChangeState = [[State alloc]initWithStateName:@"NetworkMonitor.MonitorService" stateType:StateMachineOperationalStateType afterDelay:8 stateDrainType:StateDrainTypeMustDrain enterStateBlock:^(State *state, id stateData) {
        static NSInteger i;
        NSURL *url;
        if (fmod(i, 2)) {
            url = [NSURL URLWithString:@"http://www.svxts.com/"];
        }
        else {
            NSString *address = [NSString stringWithFormat:@"http://google.com"];
            url = [NSURL URLWithString:address];
        }
        
        NSURLRequest *request = [NSURLRequest requestWithURL:url cachePolicy:NSURLRequestUseProtocolCachePolicy timeoutInterval:10];
        NSURLResponse *response;
        NSError *error;
        [NSURLConnection sendSynchronousRequest:request returningResponse:&response error:&error];
        
        if (response && !error) {
            [state nextStateByName:@"NetworkMonitor.Service.Connected" stateData:stateData];
        }
        else {
            [state nextStateByName:@"NetworkMonitor.Service.Disconnected" stateData:stateData];
        }
        i++;
    }];
    
    serviceDisconnectedState = [[State alloc]initWithStateName:@"NetworkMonitor.Service.Disconnected" stateType:StateMachineOperationalStateType afterDelay:0 stateDrainType:StateDrainTypeMustDrain enterStateBlock:^(State *state, id stateData) {
        [state nextStateByName:@"NetworkMonitor.MonitorService" stateData:stateData];
    }];
    
    reachDisconnectedState = [[State alloc]initWithStateName:@"NetworkMonitor.Reach.Disconnected" stateType:StateMachineOperationalStateType afterDelay:0 stateDrainType:StateDrainTypeOpen | StateDrainTypeMustDrain enterStateBlock:^(State *state, id stateData) {       
        [state nextStateByName:@"NetworkMonitor.IdleState" stateData:nil];
    }];
    
    serviceConnectedState = [[State alloc]initWithStateName:@"NetworkMonitor.Service.Connected" stateType:StateMachineOperationalStateType afterDelay:0 stateDrainType:StateDrainTypeMustDrain enterStateBlock:^(State *state, id stateData) {
        [state nextStateByName:@"NetworkMonitor.MonitorService" stateData:stateData];
    }];
    
    finalState = [[State alloc]initWithStateName:@"NetworkMonitor.FinalState" stateType:StateMachineFinalStateType afterDelay:0 stateDrainType:StateDrainTypeMustNotDrain enterStateBlock:^(State *state, id stateData) {
        //empty final state
        DLog(@"Network Manager Final");
    }];
    
    idleState.tag =                     kReachabilityIdleStateTag;
    reachChangedState.tag =             kReachabilityChangedStateTag;
    fastCheckingConnectionState.tag =   kReachabilityFastCheckingConnectionStateTag;
    monitorServiceForChangeState.tag =  kReachabilityMonitorServiceForChangeStateTag;
    serviceConnectedState.tag =         kReachabilityServiceConnectedStateTag;
    serviceDisconnectedState.tag =      kReachabilityServiceDisconnectedStateTag;
    reachDisconnectedState.tag =        kReachabilityReachDisconnectedStateTag;
    finalState.tag =                    kReachabilityFinalStateTag;
    
    [states addObject:idleState];
    [states addObject:reachChangedState];
    [states addObject:fastCheckingConnectionState];
    [states addObject:monitorServiceForChangeState];
    [states addObject:serviceConnectedState];
    [states addObject:serviceDisconnectedState];
    [states addObject:reachDisconnectedState];
    [states addObject:finalState];
    
    return states;


}

+ (NSArray*)createAuthenticationStates{
    NSMutableArray *states = [NSMutableArray array];
    
    State *startingState;
    State *connectedAuthenticatedState;
    State *connectedNotAuthenticatedState;
    State *disconnectedAuthenticatedState;
    State *disconnectedNotAuthenticatedState;
    State *finalState;
    
    startingState = [[State alloc]initWithStateName:@"Authentication.StartingState" stateType:StateMachineInitialStateType afterDelay:0 stateDrainType:StateDrainTypeClose | StateDrainTypeMustNotDrain enterStateBlock:^(State *state, id stateData) {
        
        NSDictionary *statusData = [(NSDictionary*)stateData valueForKey:@"ConnectionStatus"];
        NetworkStatus networkStatus = [[statusData valueForKey:@"RONetworkStatus"]intValue];
        DLog(@"StartingState");
        
        if (!statusData) {
            [state nextStateByName:@"Authentication.ConnectedNotAuthenticatedState" stateData:nil];
            return;
        }
        
        //connected authenticated
        if (networkStatus == DeviceConnectionTypeConnected) {
            [state nextStateByName:@"Authentication.ConnectedAuthenticatedState" stateData:nil];
            return ;
        }
        
        //connected not authenticated
        if (networkStatus == DeviceConnectionTypeConnected) {
            [state nextStateByName:@"Authentication.ConnectedNotAuthenticatedState" stateData:nil];
            return;
        }
        
        //disconnected authenticated
        if (networkStatus == DeviceConnectionTypeDisconnected) {
            [state nextStateByName:@"Authentication.DisconnectedAuthenticatedState" stateData:nil];
            return;
        }
        
        //disconnected not authenticated
        if (networkStatus == DeviceConnectionTypeDisconnected) {
            [state nextStateByName:@"Authentication.DisconnectedNotAuthenticatedState" stateData:nil];
            return;
        }
        
    }];
    
    connectedAuthenticatedState = [[State alloc]initWithStateName:@"Authentication.ConnectedAuthenticatedState" stateType:StateMachineOperationalStateType afterDelay:0 stateDrainType:StateDrainTypeMustNotDrain enterStateBlock:^(State *state, id stateData) {
        DLog(@"AuthenticationManager Connected Auth");
    }];
    
    
    connectedNotAuthenticatedState = [[State alloc]initWithStateName:@"Authentication.ConnectedNotAuthenticatedState" stateType:StateMachineOperationalStateType afterDelay:0 stateDrainType:StateDrainTypeMustNotDrain enterStateBlock:^(State *state, id stateData) {
        DLog(@"AuthenticationManager Connected Not Auth");
    }];
    
    disconnectedAuthenticatedState = [[State alloc]initWithStateName:@"Authentication.DisconnectedAuthenticatedState" stateType:StateMachineOperationalStateType afterDelay:0 stateDrainType:StateDrainTypeMustNotDrain enterStateBlock:^(State *state, id stateData) {
        DLog(@"AuthenticationManager Disconnected Auth");
    }];
    
    disconnectedNotAuthenticatedState = [[State alloc]initWithStateName:@"Authentication.DisconnectedNotAuthenticatedState" stateType:StateMachineOperationalStateType afterDelay:0 stateDrainType:StateDrainTypeMustNotDrain enterStateBlock:^(State *state, id stateData) {
        DLog(@"AuthenticationManager Disconnected Not Auth");
        
    }];
    
    finalState = [[State alloc]initWithStateName:@"Authentication.FinalState" stateType:StateMachineFinalStateType afterDelay:0 stateDrainType:StateDrainTypeClose | StateDrainTypeMustNotDrain enterStateBlock:^(State *state, id stateData) {
        DLog(@"AuthenticationManager FinalState");
        
    }];
    
    startingState.tag = kAuthManagerStartingState;
    connectedNotAuthenticatedState.tag = kAuthManagerConnectedNotAuthenticatedState;
    connectedAuthenticatedState.tag = kAuthManagerConnectedAuthenticatedState;
    disconnectedAuthenticatedState.tag = kAuthManagerDisconnectedAuthenticatedState;
    disconnectedNotAuthenticatedState.tag = kAuthManagerDisconnectedNotAuthenticatedState;
    finalState.tag = kAuthManagerFinalState;
    
    [states addObject:startingState];
    [states addObject:connectedAuthenticatedState];
    [states addObject:connectedNotAuthenticatedState];
    [states addObject:disconnectedAuthenticatedState];
    [states addObject:disconnectedNotAuthenticatedState];
    [states addObject:finalState];
    
    return states;
}

@end
