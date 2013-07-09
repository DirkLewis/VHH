//
//  ProgressIndicatorProtocol.h
//  StateMachineTestApp
//
//  Created by Dirk Lewis on 7/22/12.
//  Copyright (c) 2012 VideoHooHaa. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol ProgressIndicatorProtocol <NSObject>

@required
- (void)showHUDWithText:(NSString *)text afterDelay:(NSTimeInterval)delay;
- (void)showHUDWithText:(NSString*)text;
- (void)hideHUDWithText:(NSString*)text;
- (void)updateHUDWithText:(NSString*)text;
@optional

@end
