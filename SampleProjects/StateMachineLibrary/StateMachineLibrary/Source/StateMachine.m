//
//  StateMachine.m
//  DynamicStateMachine
//
//  Created by Dirk Lewis on 4/9/12.
//  Copyright (c) 2012 Optima HCS. All rights reserved.
//

#import "StateMachineHeaders.h"

@interface StateMachine ()

@property (assign, nonatomic,readwrite) BOOL isRunning;

- (void)pushNextState:(State*)state stateData:(id)stateData;
- (State*)getStateByName:(NSString*)stateName;
- (void)faucetWithState:(State*)state;
- (State*)getFinalState;
- (State*)getInitialState;
@end

@implementation StateMachine{

    BOOL _isInEndState;
    BOOL _isStopping;
    BOOL _isDrainingStates;
    
    NSArray* _machineStates;
    StateMachineFlags _initializationFlags;
    BOOL _isAborting;
    StateMachineTransitionBlock _stateTranstion;
    StateMachineFinalStateReachedBlock _finalStateReached;
}

@synthesize currentState = _currentState;
@synthesize isRunning = _isRunning;
@synthesize machineName = _machineName;
@synthesize userInfo = _userInfo;

#pragma mark Initialize
- (id)init
{
    self = [super init];
    if (self) {
        [NSException raise:@"Use machine initializers" format:nil];
    }
    return self;
}
- (id)initMachineByName:(NSString*)machineName withStates:(NSArray*)states stateMachineFlags:(StateMachineFlags)flags stateTransitionBlock:(StateMachineTransitionBlock)transitionBlock finalStateReachedBlock:(StateMachineFinalStateReachedBlock)finalStateBlock{
    self = [super init];
    if (self) {
        _initializationFlags = flags;
        _machineStates = states;
        _machineName = machineName;
        _stateTranstion = transitionBlock;
        _finalStateReached = finalStateBlock;
    }
    return self;
}

#pragma mark - State Machine

- (void)stop{
    
    DLog(@"Stopping state machine: %@",_machineName);
    
    if (!_isRunning) {
        DLog(@"State machine is not running.");
        return;
    }
    [self pushNextState:[self getFinalState] stateData:nil];
    dispatch_suspend(self.backgroundQueue);
    _isStopping = YES;
}

- (void)abort{
    
    DLog(@"Aborting state machine: %@",_machineName);
    
    if (_initializationFlags == (_initializationFlags | StateMachineFlagsForceEndStateOnAbort)) {
        [self pushNextState:[self getFinalState] stateData:nil];
    }
    
    if (!_isRunning) {
        return;
    }
    
    dispatch_release(self.backgroundQueue);
    self.backgroundQueue = nil;
    
    _isAborting = YES;
    _isRunning = NO;
    _isStopping = NO;
}

- (void)start{
    [self startWithInitialStateData:nil];
}

- (void)startWithInitialStateData:(id)initialStateData{
    if (_isRunning) {
        DLog(@"Machine is currently running.");
        return;
    }
    
    _isAborting = NO;
    _isStopping = NO;
    _isDrainingStates = NO;
    
    if (self.backgroundQueue) {
        self.backgroundQueue = nil;
    }
    
    NSString *queueName = [NSString stringWithFormat:@"statemachine.queue.%@",_machineName];
    const char *queue = [queueName UTF8String];
    self.backgroundQueue = dispatch_queue_create(queue, DISPATCH_QUEUE_SERIAL);
    
    
    for (State *state in _machineStates) {
        state.delegate = nil;
        state.delegate = self;
        state.owningMachineName = _machineName;
    }
    
    _isRunning = YES;
    [self pushNextState:[self getInitialState] stateData:initialStateData];
}

- (BOOL)stateContainsDrainFlag:(State*)state stateDrainType:(StateDrainTypeEnum)stateDrainType{

    if ((state.stateDrainType & stateDrainType) == stateDrainType) {
        return YES;
    }

    return NO;
}

- (void)faucetWithState:(State*)state{
    
    if ([self stateContainsDrainFlag:state stateDrainType:StateDrainTypeOpen]) {
        //DLog(@"Opening drain.")
        _isDrainingStates = YES;
    }
    
    if ([self stateContainsDrainFlag:state stateDrainType:StateDrainTypeClose]) {
        //DLog(@"Closing drain.");
        _isDrainingStates = NO;
    }
}


- (void)pushNextState:(State*)state stateData:(id)stateData{
    
    if (!_isRunning || _isStopping) {
        return;
    }
    
    _currentState = state;
    dispatch_async(dispatch_get_main_queue(), ^{[self stateMachineStateTransition:state];});
    [self faucetWithState:state];
    
    if (_isDrainingStates && [self stateContainsDrainFlag:state stateDrainType:StateDrainTypeMustDrain]) {
        return;
    }
    
    if (state.stateType == StateMachineFinalStateType) {
        
        [state enterState:stateData];

        if (_initializationFlags == (_initializationFlags | StateMachineFlagsRaiseEndStateEvent)) {
            [self stateMachineEndStateReached:self];
        }
        
    }
    else {

        if (state.delay == 0) {
            dispatch_async(self.backgroundQueue, ^{
                [state enterState:stateData];
            });
        }
        else {
            
            double delayInSeconds = state.delay;
            dispatch_time_t popTime = dispatch_time(DISPATCH_TIME_NOW, delayInSeconds * NSEC_PER_SEC);
            dispatch_after(popTime, self.backgroundQueue, ^(void){
                [state enterState:stateData];
            });
        }
    }

}

- (State*)getStateByName:(NSString*)stateName{
    
    for (State *state in _machineStates) {
        if ([state.stateName isEqualToString:stateName]) {
            return state;
        }
    }

    return nil;
}

- (State*)getInitialState{

        
    for (State *state in _machineStates) {
        if (state.stateType == StateMachineInitialStateType) {
            return state;
        }
    }
    return nil;
}

- (State*)getFinalState{
    
    for (State *state in _machineStates) {
        if (state.stateType == StateMachineFinalStateType) {
            return state;
        }
    }
    
    return nil;
}

#pragma mark - StateMachine delegate

- (void)logStateError:(StateError *)stateError{

    if (!self.stateErrors) {
        self.stateErrors = [NSMutableArray array];
    }
    [self.stateErrors addObject:stateError];
}

- (void)nextStateByName:(NSString*)stateName stateData:(id)stateData{
    
    if (_isStopping || !_isRunning) {
        return;
    }
    
    [self pushNextState:[self getStateByName:stateName] stateData:stateData];
}

- (void)stateMachineStateTransition:(State*)enteringState{
    
    if (_stateTranstion) {
        _stateTranstion(enteringState);
        dispatch_async(dispatch_get_main_queue(), ^{_stateTranstion(self.currentState);});

        return;
    }
}

- (void)stateMachineEndStateReached:(StateMachine*)machine{
    _isRunning = NO;
    [self stop];
    if (_finalStateReached) {
        dispatch_async(dispatch_get_main_queue(), ^{_finalStateReached(machine.currentState,machine.stateErrors);});
        return;
    }

}

@end
