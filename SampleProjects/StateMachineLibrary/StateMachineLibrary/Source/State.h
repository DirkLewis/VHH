//
//  State.h
//  DynamicStateMachine
//
//  Created by Dirk Lewis on 4/9/12.
//  Copyright (c) 2012 Optima HCS. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "StateMachineHeaders.h"

@class StateMachine;
@class State;

typedef enum{
    
    StateMachineInitialStateType = 1,
    StateMachineOperationalStateType = 2,
    StateMachineFinalStateType = 4
    
}StateTypeEnum;

typedef enum{
    
    StateDrainTypeOpen = 1,
    StateDrainTypeClose = 2,
    StateDrainTypeMustDrain = 4,
    StateDrainTypeMustNotDrain = 8
    
}StateDrainTypeEnum;

typedef void (^StateBlock)(State *state, id stateData);
typedef void (^MessageReceivedBlock)(State *state, id message);

@interface State : NSObject 


@property (assign,readonly)StateTypeEnum stateType;
@property (assign,readonly)NSTimeInterval delay;
@property (strong,nonatomic,readonly)NSString *stateName;
@property (strong,nonatomic) id<StateMachineDelegate> delegate;
@property (assign,readonly)StateDrainTypeEnum stateDrainType;
@property (assign,nonatomic) NSInteger tag;
@property (strong,nonatomic) id stateData;
@property (copy,nonatomic)NSString *owningMachineName;

- (void)logStateError:(StateError *)stateError;
- (id)initWithStateName:(NSString*)stateName stateType:(StateTypeEnum)stateType afterDelay:(NSTimeInterval)delay stateDrainType:(StateDrainTypeEnum)stateDrainType enterStateBlock:(StateBlock)enterStateBlock; 
- (void)enterState:(id)stateData;
- (void)nextStateByName:(NSString*)stateName stateData:(id)stateData;

@end
