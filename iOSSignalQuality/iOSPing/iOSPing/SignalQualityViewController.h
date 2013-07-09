//
//  SignalQualityViewController.h
//  Rehab Optima Mobile
//
//  Created by Dirk Lewis on 6/8/12.
//  Copyright (c) 2012 GiftRAP Corp. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "PingDataAggregator.h"
@class GradientButton;
@interface SignalQualityViewController : UIViewController <PingDataAggregatorDelegate, UIAlertViewDelegate>

@property ( nonatomic) IBOutlet UIView *networkGraphView;
@property ( nonatomic) IBOutlet GradientButton *runTestButton;
@property ( nonatomic) IBOutlet UILabel *averagePingLabel;
@property ( nonatomic) IBOutlet UILabel *minimumPingLabel;
@property ( nonatomic) IBOutlet UILabel *maximumPingLabel;
@property ( nonatomic) IBOutlet UILabel *signalQualityTitleLabel;
@property ( nonatomic) IBOutlet UISlider *graphScaleAdjustmentSlider;
@property ( nonatomic) IBOutlet UILabel *graphScaleLabel;
@property ( nonatomic) IBOutlet UIImageView *signalQualityBackgroundImageView;
@property ( nonatomic) IBOutlet GradientButton *hostSelectionButton;
@property (assign, nonatomic) BOOL includeNetworkTesting;
@property ( nonatomic) IBOutlet UILabel *pingVarianceLabel;
@property ( nonatomic) IBOutlet UILabel *pingThresholdLabel;
@property ( nonatomic) IBOutlet UIStepper *pingVarianceStepper;
@property ( nonatomic) IBOutlet UIStepper *pingThresholdStepper;

- (IBAction)touchRunTestButton:(id)sender;
- (IBAction)slideGraphScaleAdjustment:(id)sender;
- (IBAction)touchSelectHost:(id)sender;
- (IBAction)touchPVStepper:(id)sender;
- (IBAction)touchPTStepper:(id)sender;

@end
