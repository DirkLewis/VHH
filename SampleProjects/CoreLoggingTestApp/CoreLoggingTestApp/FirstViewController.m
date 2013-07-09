//
//  FirstViewController.m
//  CoreLoggingTestApp
//
//  Created by Dirk Lewis on 7/26/12.
//  Copyright (c) 2012 Optima HCS. All rights reserved.
//

#import "FirstViewController.h"
#import "LoggingController.h"


@interface FirstViewController ()

@end

@implementation FirstViewController

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
	// Do any additional setup after loading the view.
    
    [LoggingController initializeLogger];
    
}

- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

- (IBAction)touchLogStuff:(id)sender {
    [LoggingController logAccessError:@"Access Error"];

}
@end
