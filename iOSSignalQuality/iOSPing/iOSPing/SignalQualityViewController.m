//
//  SignalQualityViewController.m
//  Rehab Optima Mobile
//
//  Created by Dirk Lewis on 6/8/12.
//  Copyright (c) 2012 GiftRAP Corp. All rights reserved.
//

#import "SignalQualityViewController.h"
#import "PingDataAggregator.h"
#import "GradientButton.h"
#import "SignalQualityConstants.h"

#define kAlertViewBlueBackgroundTag 100
#define kAlertViewRedBackgroundTag 200
#define kAlertViewHostSelectTag 300

//Strings
#define kHUDConnectingString @"Connecting"
#define kRunTestButtonRunningString @"RUNNING TEST"
#define KRunTestButtonWaitingString @"RUN TEST"

@interface SignalQualityViewController ()

@property (assign, nonatomic) NSInteger numberOfTestPings;
@property ( nonatomic) PingDataAggregator *pingDataAggregator;
@property ( nonatomic) NSMutableArray *dataPoints;
@property (assign, nonatomic) float graphCurrentX;
@property (assign, nonatomic) BOOL thresholdBroken;

- (void) resetForNewTest;

@end

@implementation SignalQualityViewController
@synthesize networkGraphView;
@synthesize runTestButton;
@synthesize averagePingLabel;
@synthesize minimumPingLabel;
@synthesize maximumPingLabel;
@synthesize signalQualityTitleLabel;
@synthesize graphScaleAdjustmentSlider;
@synthesize graphScaleLabel;
@synthesize signalQualityBackgroundImageView;
@synthesize hostSelectionButton;
@synthesize numberOfTestPings = _numberOfTestPings;
@synthesize pingDataAggregator = _pingDataAggregator;
@synthesize dataPoints = _dataPoints;
@synthesize graphCurrentX = _graphCurrentX;
@synthesize thresholdBroken = _thresholdBroken;
@synthesize includeNetworkTesting = _includeNetworkTesting;
@synthesize pingVarianceLabel;
@synthesize pingThresholdLabel;
@synthesize pingVarianceStepper;
@synthesize pingThresholdStepper;

#pragma mark - Initialization

- (void)awakeFromNib{
    
    _includeNetworkTesting = YES;
    
}

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.dataPoints = [NSMutableArray array];
    [self.runTestButton useBlackStyle];
    [self.hostSelectionButton useBlackStyle];
}

- (void)viewDidAppear:(BOOL)animated{
    
    [super viewDidAppear:animated];
    [self setupAggregator];
    [self setupUI];
    
    if (_includeNetworkTesting) {
        [self performSelector:@selector(testNetworkConnection) withObject:nil afterDelay:1];
    }
        
}


- (void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    
    [self.pingDataAggregator abort];
    
    if (self.pingDataAggregator) {
        //[self.pingDataAggregator release];
        [self setPingDataAggregator:nil];
    }
    [self resetForNewTest];
    [[NSUserDefaults standardUserDefaults] setValue:[NSNumber numberWithFloat:self.graphScaleAdjustmentSlider.value] forKey:kUserDefaultGraphScaleAdjustmentValueKey];
    [[NSUserDefaults standardUserDefaults] synchronize];
    
    [[NSNotificationCenter defaultCenter]removeObserver:self];
}
- (void)viewDidUnload
{
    [self setNetworkGraphView:nil];
    [self setRunTestButton:nil];
    [self setAveragePingLabel:nil];
    [self setMinimumPingLabel:nil];
    [self setMaximumPingLabel:nil];
    [self setDataPoints:nil];
    [self setPingDataAggregator:nil];
    [self setSignalQualityTitleLabel:nil];
    [self setGraphScaleAdjustmentSlider:nil];
    [self setGraphScaleLabel:nil];
    [self setSignalQualityBackgroundImageView:nil];
    [self setHostSelectionButton:nil];
    [self setPingVarianceLabel:nil];
    [self setPingThresholdLabel:nil];
    [self setPingVarianceStepper:nil];
    [self setPingThresholdStepper:nil];
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}


#pragma mark - Ping Aggregator delgate
- (void)pingDataAggregatorDidStart:(NSString *)message{
    [self.runTestButton setTitle:kRunTestButtonRunningString forState:UIControlStateNormal];
    [self.runTestButton setTag:1];
}

- (void)pingDataAggregatorDidFinish:(NSDictionary*)signalResults{
    [self.runTestButton setTitle:KRunTestButtonWaitingString forState:UIControlStateNormal];
    [self.runTestButton setTag:0];
    

        if ([[self.pingDataAggregator totalPingRequests]intValue] < _numberOfTestPings) {
            [self presentAlertViewWithTitle:@"Incomplete Test" message:@"The test has not finished any results may not be accurate." alertTag:kAlertViewBlueBackgroundTag];
        }
        else {
            if ([[signalResults valueForKey:kSignalQualityPerscentKey]floatValue] > 70) {
                [self presentAlertViewWithTitle:[NSString stringWithFormat:@"Good Signal Quality - %i%%",[[signalResults valueForKey:kSignalQualityPerscentKey]intValue]] message:@"The device has determined that you have good signal quality." alertTag:kAlertViewBlueBackgroundTag];
            }
            else if ([[signalResults valueForKey:kSignalQualityPerscentKey]floatValue] > 40){
                [self presentAlertViewWithTitle:[NSString stringWithFormat:@"Fair Signal Quality - %i%%",[[signalResults valueForKey:kSignalQualityPerscentKey]intValue]] message:@"The device has determined that you have Fair signal quality." alertTag:kAlertViewBlueBackgroundTag];
            }
            else if ([[signalResults valueForKey:kSignalQualityPerscentKey]floatValue] > 10){
                [self presentAlertViewWithTitle:[NSString stringWithFormat:@"Marginal Signal Quality - %i%%",[[signalResults valueForKey:kSignalQualityPerscentKey]intValue]] message:@"The device has determined that you have Marginal signal quality." alertTag:kAlertViewBlueBackgroundTag];
            }
            else {
                [self reportBrokenThreshold];
                [self.pingDataAggregator stop];
                [self presentAlertViewWithTitle:@"Poor Signal Quality" message:@"Current signal quality is poor. Please move your mobile device to a location with better signal quality to ensure successful transmission of data." alertTag:kAlertViewRedBackgroundTag];
                
            }
        }
    
}

- (void)pingDataAggregatorDidReceiveResponse:(NSDictionary*)pingData{
    
    self.averagePingLabel.text = [NSString stringWithFormat:@"AVG: %.2f", [[self.pingDataAggregator pingAverage]floatValue]];
    self.minimumPingLabel.text = [NSString stringWithFormat:@"MIN: %.2f", [[self.pingDataAggregator pingMinimum]floatValue]];
    self.maximumPingLabel.text = [NSString stringWithFormat:@"MAX: %.2f", [[self.pingDataAggregator pingMaximum]floatValue]];
    
    [self.dataPoints addObject:pingData];
    
    __unsafe_unretained id weakself = self;
    dispatch_async(dispatch_get_main_queue(), ^{
        
        [weakself graphData:pingData];
    });
}

- (void)pingDataAggregatorDidExceedVarianceThreshold{
    [self reportBrokenThreshold];
    [self.pingDataAggregator stop];
    
}

- (void)pingDataAggregatorDidReceiveErrorMessage:(NSString*)errorMessage{
    [self.pingDataAggregator abort];
    [self presentAlertViewWithTitle:@"Ping Error" message:errorMessage alertTag:kAlertViewRedBackgroundTag];
    
}

#pragma mark - Private methods

- (void)reachabilityChanged:(NSNotification*)notification{
    
    if ([[self networkIdentifier] isEqualToString:@"NA"]) {
        [self presentAlertViewWithTitle:@"Network Changed" message:@"You are no longer connected to a network" alertTag:kAlertViewRedBackgroundTag];
        self.signalQualityTitleLabel.text = [NSString stringWithFormat:@"Your network is: %@",[self networkIdentifier]];
        
    }
    else {
        [self presentAlertViewWithTitle:@"Network Changed" message:[NSString stringWithFormat:@"Your network has changed to %@",[self networkIdentifier]] alertTag:kAlertViewBlueBackgroundTag];
        self.signalQualityTitleLabel.text = [NSString stringWithFormat:@"Your network is: %@",[self networkIdentifier]];
    }
}


- (void)reportBrokenThreshold{
    self.thresholdBroken = YES;

}

- (NSString*)networkIdentifier{
    return [[self.pingDataAggregator networkIdentifiersDictionary]valueForKey:kNetworkIdentifierSSIDKey] ? [[self.pingDataAggregator networkIdentifiersDictionary]valueForKey:kNetworkIdentifierSSIDKey] : @"NA";
}

- (void)setupUI{
    self.signalQualityTitleLabel.text = [NSString stringWithFormat:@"Your network is: %@",[self networkIdentifier]];
    
    self.networkGraphView.layer.masksToBounds = YES;
    [self.networkGraphView.layer setBorderColor:[[UIColor darkGrayColor]CGColor]];
    [self.networkGraphView.layer setBorderWidth:2.0];
    [self.networkGraphView.layer setCornerRadius:10.0];
    
    self.signalQualityBackgroundImageView.layer.masksToBounds= YES;
    [self.signalQualityBackgroundImageView.layer setBorderColor:[[UIColor darkGrayColor]CGColor]];
    [self.signalQualityBackgroundImageView.layer setBorderWidth:2.0];
    [self.signalQualityBackgroundImageView.layer setCornerRadius:10.0];
    
    
    if (![[NSUserDefaults standardUserDefaults]valueForKey:kUserDefaultGraphScaleAdjustmentValueKey]) {
        self.graphScaleAdjustmentSlider.value = 50.0;
        [[NSUserDefaults standardUserDefaults] setValue:[NSNumber numberWithFloat:self.graphScaleAdjustmentSlider.value] forKey:kUserDefaultGraphScaleAdjustmentValueKey];
        [[NSUserDefaults standardUserDefaults] synchronize];
    }
    else {
        self.graphScaleAdjustmentSlider.value = [[NSUserDefaults standardUserDefaults]floatForKey:kUserDefaultGraphScaleAdjustmentValueKey];
    }
    self.graphScaleLabel.text = [NSString stringWithFormat:@"Scale: x%.0f",self.graphScaleAdjustmentSlider.value];
    
}

- (void)setupAggregator{
    
    self.numberOfTestPings = [[NSUserDefaults standardUserDefaults] integerForKey:kUserDefaultPingCountKey];
    NSInteger pingVariance = [[NSUserDefaults standardUserDefaults] integerForKey:kUserDefaultPingVarianceKey];
    
    if (pingVariance == 0) {
        pingVariance = 25;
        [[NSUserDefaults standardUserDefaults]setValue:[NSNumber numberWithInt:25] forKey:kUserDefaultPingVarianceKey];
        [[NSUserDefaults standardUserDefaults]synchronize];

    }
    self.pingVarianceLabel.text = [NSString stringWithFormat:@"PV: %d",pingVariance];

    self.pingVarianceStepper.value = pingVariance;

    NSInteger pingThreshold = [[NSUserDefaults standardUserDefaults] integerForKey:kUserDefaultPingThresholdKey];
    if (pingThreshold == 0) {
        pingThreshold = 10;
        [[NSUserDefaults standardUserDefaults]setValue:[NSNumber numberWithInt:10] forKey:kUserDefaultPingThresholdKey];
        [[NSUserDefaults standardUserDefaults]synchronize];

    }
    self.pingThresholdLabel.text = [NSString stringWithFormat:@"PT: %d",pingThreshold];

    self.pingThresholdStepper.value = pingThreshold;

    NSString *host = [[NSUserDefaults standardUserDefaults] stringForKey:kUserDefaultRootServerKey];
    if ([host length] == 0) {
        host = @"google.com";
        [[NSUserDefaults standardUserDefaults]setValue:host forKey:kUserDefaultRootServerKey];
        [[NSUserDefaults standardUserDefaults]synchronize];
    }
    
    NSNumber *pingInterval = [[NSUserDefaults standardUserDefaults]valueForKey:kUserDefaultPingIntervalKey];
    if (!pingInterval) {
        pingInterval = [NSNumber numberWithFloat:0.250];
        [[NSUserDefaults standardUserDefaults]setValue:pingInterval forKey:kUserDefaultPingIntervalKey];
        [[NSUserDefaults standardUserDefaults]synchronize];

    }
    
    if (self.numberOfTestPings == 0) {
        self.numberOfTestPings = 50;
    }
    
    
    self.pingDataAggregator = [[PingDataAggregator alloc]initWithHostName:host numberOfPings:self.numberOfTestPings packetSizeBytes:0 pingVarianceMilliseconds:pingVariance pingVarianceThreshold:pingThreshold];
    [self.pingDataAggregator setDelegate:self];
    [self.pingDataAggregator setPingSendInterval:[[NSUserDefaults standardUserDefaults]floatForKey:kUserDefaultPingIntervalKey]];
    
    
}

- (BOOL)testNetworkConnection{
    return YES;
}

- (void) resetForNewTest{
    self.thresholdBroken = NO;
    [[self.networkGraphView subviews] makeObjectsPerformSelector:@selector(removeFromSuperview)];
    _graphCurrentX = 0;
    self.averagePingLabel.text = [NSString stringWithFormat:@"AVG: %.2f", 0.00];
    self.minimumPingLabel.text = [NSString stringWithFormat:@"MIN: %.2f", 0.00];
    self.maximumPingLabel.text = [NSString stringWithFormat:@"MAX: %.2f", 0.00];
    self.runTestButton.tag = 0;
}

- (void)beginNetworkTest{
    
    if ([self testNetworkConnection]) {
        [self.pingDataAggregator start];
    }
}

#pragma mark - Action Methods
- (IBAction)touchRunTestButton:(id)sender {
    
    if ([self.runTestButton tag] == 0) {
        [self resetForNewTest];
        [self.pingDataAggregator start];
    }
    
    if ([self.runTestButton tag] == 1) {
        [self.pingDataAggregator stop];
    }
}

- (IBAction)slideGraphScaleAdjustment:(id)sender {
    
    self.graphScaleLabel.text = [NSString stringWithFormat:@"Scale: x%.0f",self.graphScaleAdjustmentSlider.value];
}

- (IBAction)touchSelectHost:(id)sender {
    NSString *message = [NSString stringWithFormat:@"Enter host address to test. Currently: %@",[self.pingDataAggregator hostName]];
    UIAlertView *selectHostAlert = [[UIAlertView alloc]initWithTitle:@"Select Host" message:message delegate:self cancelButtonTitle:@"Cancel" otherButtonTitles:@"OK",nil];
    selectHostAlert.alertViewStyle = UIAlertViewStylePlainTextInput;
    selectHostAlert.tag = kAlertViewHostSelectTag;
    [selectHostAlert show];
}

- (IBAction)touchPVStepper:(id)sender {
    
    UIStepper *stepper = (UIStepper*)sender;
    
    
    self.pingVarianceLabel.text = [NSString stringWithFormat:@"PV: %.0f",stepper.value];
    [[NSUserDefaults standardUserDefaults]setValue:[NSNumber numberWithDouble:stepper.value] forKey:kUserDefaultPingVarianceKey];
    [[NSUserDefaults standardUserDefaults]synchronize];
    [self setupAggregator];
    
}

- (IBAction)touchPTStepper:(id)sender {
    
    UIStepper *stepper = (UIStepper*)sender;
    self.pingThresholdLabel.text = [NSString stringWithFormat:@"PT: %.0f",stepper.value];
    [[NSUserDefaults standardUserDefaults]setValue:[NSNumber numberWithDouble:stepper.value] forKey:kUserDefaultPingThresholdKey];
    [[NSUserDefaults standardUserDefaults]synchronize];
    [self setupAggregator];

}


#pragma mark - Graphing

- (void)graphData:(NSDictionary*)dataPoint{
    
    float responseTime = [[dataPoint objectForKey:kPingResponseTimeKey] floatValue];
    float viewHeight = 0.0;
    
    viewHeight = responseTime * self.graphScaleAdjustmentSlider.value;
    
    UIView *graphView = [[UIView alloc]initWithFrame:CGRectMake(_graphCurrentX, 149.0f, 4.5f, -viewHeight)];
    
    if (!self.thresholdBroken) {
        if ([[dataPoint objectForKey:kPingExceededThresholdKey]boolValue] && [[dataPoint objectForKey:kUnresolvedPingKey]boolValue]) {
            [graphView setBackgroundColor:[UIColor purpleColor]];
        }
        else if([[dataPoint objectForKey:kPingExceededThresholdKey]boolValue]){
            [graphView setBackgroundColor:[UIColor yellowColor]];
        }
        else {
            [graphView setBackgroundColor:[UIColor greenColor]];
        }
    }
    else {
        [graphView setBackgroundColor:[UIColor redColor]];
    }
    
    [self.networkGraphView addSubview:graphView];
    _graphCurrentX = (1 + 4.5f)+_graphCurrentX;
}

#pragma mark - AlertView Methods

- (void)presentAlertViewWithTitle:(NSString*)title message:(NSString*)message alertTag:(NSInteger)tag{
    
    UIAlertView *alert = [[UIAlertView alloc]initWithTitle:title message:message delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
    alert.tag = tag;
    [alert show];
}

#pragma mark - AlertViewDelegate
- (void)willPresentAlertView:(UIAlertView *)alertView{
    
    if (alertView.tag == kAlertViewRedBackgroundTag) {
        
        for (UIView *view in alertView.subviews) {
            // change the background image
            if ([view isKindOfClass:[UIImageView class]]) {
                CGRect rect = CGRectMake(0, 0, 1, 1);
                UIGraphicsBeginImageContext(rect.size);
                CGContextRef context = UIGraphicsGetCurrentContext();
                CGContextSetFillColorWithColor(context, [[UIColor colorWithRed:171./255 green:5./255 blue: 15./255 alpha:0.85f] CGColor]);
                
                CGContextFillRect(context, rect);
                UIImage *img = UIGraphicsGetImageFromCurrentImageContext();
                UIGraphicsEndImageContext();
                UIImageView *imageView = (UIImageView*)view;
                imageView.image = img;
                imageView.layer.masksToBounds = YES;
                [imageView.layer setBorderColor:[[UIColor whiteColor]CGColor]];
                [imageView.layer setBorderWidth:3.0];
                [imageView.layer setCornerRadius:20.0];
            }
        }
    }
}

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex{
    
    if (alertView.tag == kAlertViewHostSelectTag) {
        switch (buttonIndex) {
            case 1:{
                
                NSString *host = [alertView textFieldAtIndex:0].text;
                if ([host length]>0) {
                    [self.pingDataAggregator resetHostName:host];
                }
                break;
            }
            default:
                break;
        }
    }
    
}

@end
