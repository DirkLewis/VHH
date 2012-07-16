//
//  VHHViewController.m
//  VHHUIAlertView
//
//  Created by Dirk Lewis on 5/3/12.
//  Copyright (c) 2012 Optima HCS. All rights reserved.
//

#import "VHHViewController.h"
#import "BackgroundOverlay.h"
#import "constants.h"
@interface VHHViewController ()
@property (strong,nonatomic)UIView *testview;
@end

@implementation VHHViewController

static UIImage *backgroundImage = nil;
static UIFont *titleFont = nil;
static UIFont *messageFont = nil;
static UIFont *buttonFont = nil;

@synthesize  testview = _testview;

+ (void)initialize
{
//    if (self == [BlockAlertView class])
//    {
    backgroundImage = [UIImage imageNamed:kAlertViewBackground];
    backgroundImage = [backgroundImage stretchableImageWithLeftCapWidth:0 topCapHeight:kAlertViewBackgroundCapHeight];
    //backgroundImage = [backgroundImage resizableImageWithCapInsets:UIEdgeInsetsMake(kAlertViewBackgroundCapHeight, 0, kAlertViewBackgroundCapHeight, 0)];
    titleFont = kAlertViewTitleFont;
    messageFont = kAlertViewMessageFont;
    buttonFont = kAlertViewButtonFont;
//    }
}

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

- (IBAction)touchAlertButton:(id)sender {
    
    UIWindow *parentWindow = [BackgroundOverlay sharedBackgroundOverlay];
    CGRect frame = parentWindow.bounds;
    frame.origin.x = floorf((frame.size.width - backgroundImage.size.width) * 0.5);
    frame.size.width = backgroundImage.size.width;
    
    self.testview = [[UIView alloc] initWithFrame:frame];
    [[BackgroundOverlay sharedBackgroundOverlay] addViewToMainWindow:self.testview];
    self.view = self.testview;
    

    [self performSelector:@selector(touchSheetButton:) withObject:nil afterDelay:2.0];
}

- (IBAction)touchSheetButton:(id)sender {
    [[BackgroundOverlay sharedBackgroundOverlay] removeViewFromMainWindow:self.testview];

    
}
@end
