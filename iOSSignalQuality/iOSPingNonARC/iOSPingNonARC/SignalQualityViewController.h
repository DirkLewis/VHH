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

@property (retain, nonatomic) IBOutlet UIView *networkGraphView;
@property (retain, nonatomic) IBOutlet GradientButton *runTestButton;
@property (retain, nonatomic) IBOutlet UILabel *averagePingLabel;
@property (retain, nonatomic) IBOutlet UILabel *minimumPingLabel;
@property (retain, nonatomic) IBOutlet UILabel *maximumPingLabel;
@property (retain, nonatomic) IBOutlet UILabel *signalQualityTitleLabel;
@property (retain, nonatomic) IBOutlet UISlider *graphScaleAdjustmentSlider;
@property (retain, nonatomic) IBOutlet UILabel *graphScaleLabel;
@property (retain, nonatomic) IBOutlet UIImageView *signalQualityBackgroundImageView;
@property (retain, nonatomic) IBOutlet GradientButton *hostSelectionButton;
@property (assign, nonatomic) BOOL includeNetworkTesting;
@property (retain, nonatomic) IBOutlet UILabel *pingVarianceLabel;
@property (retain, nonatomic) IBOutlet UILabel *pingThresholdLabel;
@property (retain, nonatomic) IBOutlet UIStepper *pingVarianceStepper;
@property (retain, nonatomic) IBOutlet UIStepper *pingThresholdStepper;

- (IBAction)touchRunTestButton:(id)sender;
- (IBAction)touchSelectHost:(id)sender;
- (IBAction)touchPVStepper:(id)sender;
- (IBAction)touchPTStepper:(id)sender;

@end
