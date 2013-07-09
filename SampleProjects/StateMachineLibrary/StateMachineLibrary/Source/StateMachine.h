//
//  StateMachine.h
//  DynamicStateMachine
//
//  Created by Dirk Lewis on 4/9/12.
//  Copyright (c) 2012 Optima HCS. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <dispatch/dispatch.h>
#import "StateMachineHeaders.h"
@class State;

typedef void (^StateMachineBlock)(id blockObject);
typedef void (^StateMachineTransitionBlock)(State *enteringState);
typedef void (^StateMachineFinalStateReachedBlock)(State *finalState, NSArray *errorsArray);

typedef enum{

    StateMachineFlagsNone = 0,
    StateMachineFlagsForceEndStateOnAbort = 1,
    StateMachineFlagsRaiseEndStateEvent = 2
    
}StateMachineFlags;

@interface StateMachine : NSObject <StateMachineDelegate>

@property (strong,nonatomic)State *currentState;
@property (assign,nonatomic,readonly)BOOL isRunning;
@property (strong,nonatomic)NSDictionary *userInfo;
@property (copy,nonatomic)NSString *machineName;
@property (strong,nonatomic)NSMutableArray *stateErrors;
@property (assign,nonatomic)dispatch_queue_t backgroundQueue;
- (id)initMachineByName:(NSString*)machineName withStates:(NSArray*)stat stateMachineFlags:(StateMachineFlags)flags stateTransitionBlock:(StateMachineTransitionBlock)transitionBlock finalStateReachedBlock:(StateMachineFinalStateReachedBlock)finalStateBlock;
- (void)abort;
- (void)start;
- (void)startWithInitialStateData:(id)initialStateData;
- (void)stop;
@end
