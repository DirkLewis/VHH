//
//  StateError.m
//  StateMachineLibrary
//
//  Created by Dirk Lewis on 8/10/12.
//  Copyright (c) 2012 VHH. All rights reserved.
//

#import "StateError.h"

@implementation StateError
- (id)init
{
    self = [super init];
    if (self) {
        [NSException raise:@"Use default initializer" format:nil];
    }
    return self;
}

- (id)initWithStateName:(NSString*)stateName andError:(NSError*)error{
    self = [super init];
    if (self) {
        _stateName = stateName;
        _stateError = error;
    }
    return self;
}

- (NSString*)description{

    return [NSString stringWithFormat:@"%@\r%@",self.stateName, self.stateError];

}
@end
