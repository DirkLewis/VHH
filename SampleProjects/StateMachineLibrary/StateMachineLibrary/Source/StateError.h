//
//  StateError.h
//  StateMachineLibrary
//
//  Created by Dirk Lewis on 8/10/12.
//  Copyright (c) 2012 VHH. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface StateError : NSObject
@property (copy,nonatomic) NSString *stateName;
@property (copy,nonatomic) NSError *stateError;

- (id)initWithStateName:(NSString*)stateName andError:(NSError*)error;
@end
