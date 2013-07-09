//
//  SimpleStateMachine.m
//  StateMachineTestApp
//
//  Created by Dirk Lewis on 7/21/12.
//  Copyright (c) 2012 VideoHooHaa. All rights reserved.
//

#import "SimpleStateMachine.h"
#import <StateMachineLibrary/State.h>
#import <StateMachineLibrary/StateMachine.h>

#define kSimpleStateMachineStartingState 0
#define kSimpleStateMachineWorkerState 1
#define kSimpleStateMachineFinalState 2

@interface SimpleStateMachine()

@end

@implementation SimpleStateMachine{

}

- (id)init
{
    self = [super init];
    if (self) {
        
    }
    return self;
}
+ (NSArray*)createStates{
    return [self createStatesWithDelay:0];
}
+ (NSArray*)createStatesWithDelay:(NSTimeInterval)delay{
    
    NSMutableArray *states = [NSMutableArray array];
    
    State *initialState = nil;
    State *workerState = nil;
    State *finalState = nil;
    
    initialState = [[State alloc]initWithStateName:@"SimpleStateMachine.initial" stateType:StateMachineInitialStateType afterDelay:0 stateDrainType:StateDrainTypeClose | StateDrainTypeMustNotDrain enterStateBlock:^(State *state, id stateData){
        DLog(@"initial state");
        [state nextStateByName:@"SimpleStateMachine.worker" stateData:[NSNumber numberWithInt:20]];
    }];
    
    workerState = [[State alloc]initWithStateName:@"SimpleStateMachine.worker" stateType:StateMachineOperationalStateType afterDelay:delay stateDrainType:StateDrainTypeClose | StateDrainTypeMustNotDrain enterStateBlock:^(State *state, id stateData){
        DLog(@"worker state");
        for (int i = 0; i < [(NSNumber*)stateData intValue]; i++) {
            DLog(@"The number is %i",i);
        }
        [state nextStateByName:@"SimpleStateMachine.final" stateData:nil];

    }];
    
    finalState = [[State alloc]initWithStateName:@"SimpleStateMachine.final" stateType:StateMachineFinalStateType afterDelay:0 stateDrainType:StateDrainTypeClose | StateDrainTypeMustNotDrain enterStateBlock:^(State *state, id stateData){
        DLog(@"final state");

    }];
    
    initialState.tag = kSimpleStateMachineStartingState;
    workerState.tag = kSimpleStateMachineWorkerState;
    finalState.tag = kSimpleStateMachineFinalState;
    
    [states addObject:initialState];
    [states addObject:workerState];
    [states addObject:finalState];
    
    return states;
}

- (void)stateMachineStateTransition:(State*)enteringState{
    
    [super stateMachineStateTransition:enteringState];
    DLog(@"Entering State: %@",enteringState.stateName);
    
}

- (void)stateMachineEndStateReached:(StateMachine*)machine{

    [super stateMachineEndStateReached:machine]; 
    DLog(@"End State Reached for machine: %@",machine.machineName);

}

@end
