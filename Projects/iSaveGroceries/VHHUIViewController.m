//
//  ROUIViewController.m
//  ROMobileUniversal
//
//  Created by Dirk Lewis on 1/23/12.
//  Copyright (c) 2012 Optima HCS. All rights reserved.
//
#import <UIKit/UIKit.h>
#import "SSHUDView.h"
#import "SSHUDWindow.h"
#import "VHHUIViewController.h"

@interface VHHUIViewController ()

- (void)PINViewNotification:(NSNotification*)notification;

@end

@implementation VHHUIViewController{

    SSHUDView *_hud;
    BOOL _hudIsVisible;


}

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        
    }
    return self;
}


#pragma mark - HUD Methods

- (void)showHUDWithText:(NSString*)text{
    if (_hudIsVisible) {
        return;
    }
    _hudIsVisible = YES;
    _hud = [[SSHUDView alloc]initWithTitle:text];
    _hud.hudSize = CGSizeMake(120.0f, 120.0f);
	_hud.textLabelHidden = NO;
	_hud.hidesVignette = NO;
    [_hud show];
}

- (void)hideHUDWithText:(NSString*)text{
    _hudIsVisible = NO;
    [_hud completeWithTitle:text];
    [_hud dismissAnimated:YES];
}

#pragma mark - Notifications
- (void)startObservingNotifications{
    
    [[NSNotificationCenter defaultCenter]removeObserver:self];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(PINViewNotification:) name:@"PINViewRequiredNotification" object:nil];    

}

- (void)stopObservingNotifications{
    [[NSNotificationCenter defaultCenter]removeObserver:self];
}

- (void)PINViewNotification:(NSNotification*)notification{
    

}

@end
