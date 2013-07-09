//
//  SimpleStateMachine.h
//  StateMachineTestApp
//
//  Created by Dirk Lewis on 7/21/12.
//  Copyright (c) 2012 VideoHooHaa. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <StateMachineLibrary/StateMachine.h>
@interface SimpleStateMachine : StateMachine
+ (NSArray*)createStates;
+ (NSArray*)createStatesWithDelay:(NSTimeInterval)delay;
@end
