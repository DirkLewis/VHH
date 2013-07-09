//
//  ViewController.m
//  StateMachineTestApp
//
//  Created by Dirk Lewis on 7/21/12.
//  Copyright (c) 2012 VideoHooHaa. All rights reserved.
//

#import "StateMachineTestAppVC.h"
#import "SimpleStateMachine.h"
#import "ReachabilityStateMachine.h"
@interface StateMachineTestAppVC ()

@end

@implementation StateMachineTestAppVC

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
}

- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    if ([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPhone) {
        return (interfaceOrientation != UIInterfaceOrientationPortraitUpsideDown);
    } else {
        return YES;
    }
}
- (IBAction)touchSimpleSM:(id)sender{

    SimpleStateMachine *simpleSM = [[SimpleStateMachine alloc]initMachineByName:@"SimpleStateMachine" withStates:[SimpleStateMachine createStates] stateMachineFlags:StateMachineFlagsRaiseEndStateEvent stateTransitionBlock:^(State *enteringState) {
        
        DLog(@"transition block");
        
    } finalStateReachedBlock:^(State *finalState, NSArray *errorsArray) {
        DLog(@"final block");
    }];
    
    [simpleSM start];

}

- (IBAction)touchSimpleDelayedSM:(id)sender {
    
    SimpleStateMachine *simpleSM = [[SimpleStateMachine alloc]initMachineByName:@"SimpleStateMachine" withStates:[SimpleStateMachine createStatesWithDelay:2] stateMachineFlags:StateMachineFlagsRaiseEndStateEvent stateTransitionBlock:^(State *enteringState) {
        
        DLog(@"transition block");
        
    } finalStateReachedBlock:^(State *finalState, NSArray *errorsArray) {
        DLog(@"final block");
    }];
    
    [simpleSM start];
    
}

- (IBAction)touchReachSM:(id)sender {
    [self showHUDWithText:@"Starting..."];
    ReachabilityStateMachine *sm = [[ReachabilityStateMachine alloc]initMachineByName:@"ReachStateMachine" withStates:[ReachabilityStateMachine createReachabilityStates] stateMachineFlags:StateMachineFlagsRaiseEndStateEvent stateTransitionBlock:^(State *enteringState) {
        DLog(@"Entered: %@ with %@",enteringState.stateName, enteringState.stateData);
        NSString *hudText = @"";
        switch (enteringState.tag) {
            case kReachabilityIdleStateTag :
                hudText = @"Idle";
                break;
                
            case kReachabilityChangedStateTag:
                hudText = @"R-Changed";
                break;
                
            case kReachabilityFastCheckingConnectionStateTag:
                hudText = @"Fast CHK";
                break;
                
            case kReachabilityMonitorServiceForChangeStateTag:
                hudText = @"Monitoring";
                break;
                
            case kReachabilityReachDisconnectedStateTag:
                hudText = @"Reach Dis..";
                break;
                
            case kReachabilityServiceConnectedStateTag:
                hudText = @"SVC Con..";
                break;
                
            case kReachabilityServiceDisconnectedStateTag:
                hudText = @"SVC Dis..";
                break;
            default:
                break;
        }
        [self updateHUDWithText:hudText];

    } finalStateReachedBlock:^(State *finalState, NSArray *errorsArray) {
        DLog(@"final block");
        [self hideHUDWithText:@"Done"];
    }];
    
    [sm start];
}

@end
