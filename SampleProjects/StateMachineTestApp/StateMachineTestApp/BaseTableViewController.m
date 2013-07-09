//
//  BaseTableViewController.m
//  StateMachineTestApp
//
//  Created by Dirk Lewis on 7/22/12.
//  Copyright (c) 2012 VideoHooHaa. All rights reserved.
//

#import "BaseTableViewController.h"
#import "SSHUDView.h"
#import "SSHUDWindow.h"

@interface BaseTableViewController ()
@property (strong,nonatomic) SSHUDView *hud;

@end

@implementation BaseTableViewController

@synthesize hud = _hud;

#pragma mark - Progress Indicator Protocol
- (void)showHUDWithText:(NSString *)text afterDelay:(NSTimeInterval)delay{
    [self performSelector:@selector(showHUDWithText:) withObject:text afterDelay:delay];
}

- (void)showHUDWithText:(NSString*)text{
    self.hud = [[SSHUDView alloc]initWithTitle:text];
    self.hud.hudSize = CGSizeMake(120.0f, 120.0f);
	self.hud.textLabelHidden = NO;
	self.hud.hidesVignette = NO;
    [self.hud show];
}

- (void)hideHUDWithText:(NSString*)text{
    [self.hud completeWithTitle:text];
    [self.hud dismissAnimated:YES];        
}

- (void)updateHUDWithText:(NSString*)text{
    self.hud.textLabel.text = text;
}

@end
