//
//  ViewController.h
//  StateMachineTestApp
//
//  Created by Dirk Lewis on 7/21/12.
//  Copyright (c) 2012 VideoHooHaa. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BaseViewController.h"

@interface StateMachineTestAppVC : BaseViewController
- (IBAction)touchSimpleSM:(id)sender;
- (IBAction)touchSimpleDelayedSM:(id)sender;
- (IBAction)touchReachSM:(id)sender;

@end
