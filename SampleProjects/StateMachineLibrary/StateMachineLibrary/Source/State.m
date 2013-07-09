//
//  State.m
//  DynamicStateMachine
//
//  Created by Dirk Lewis on 4/9/12.
//  Copyright (c) 2012 Optima HCS. All rights reserved.
//

#import "StateMachineHeaders.h"

@interface State()

@property (assign,nonatomic)StateBlock enterStateBlock;
@end

@implementation State{
}

@synthesize delay = _delay;
@synthesize stateName = _stateName;
@synthesize stateType = _stateType;
@synthesize stateDrainType = _stateDrainType;
@synthesize tag = _tag;
@synthesize stateData = _stateData;
@synthesize owningMachineName = _owningMachineName;
@synthesize enterStateBlock = _enterStateBlock;
@synthesize delegate = _delegate;

#pragma mark - Initalization

- (id)initWithStateName:(NSString*)stateName stateType:(StateTypeEnum)stateType afterDelay:(NSTimeInterval)delay stateDrainType:(StateDrainTypeEnum)stateDrainType enterStateBlock:(StateBlock)enterStateBlock{    
    self = [super init];
    if (self) {
        
        _stateName = stateName;
        _enterStateBlock = enterStateBlock;
        _stateDrainType = stateDrainType;
        if (delay < 0) {
            delay = 0;
        }
        _delay = delay;
        _stateType = stateType;
    }
    return self;
}

- (void)logStateError:(StateError *)stateError{
    [_delegate logStateError:stateError];
}
- (void)nextStateByName:(NSString*)stateName stateData:(id)stateData{
    [_delegate nextStateByName:stateName stateData:stateData];
}
- (void)enterState:(id)stateData{
    
    self.stateData = stateData;
    _enterStateBlock(self,stateData);
}

- (NSString*)description{

    return [NSString stringWithFormat:@"\n Statename:%@ \n Statetype:%i \n StateTag:%i \n StateDelegate: %@",_stateName,_stateType,self.tag,_delegate];
}

@end
