//
//  FirstViewController.h
//  iSaveGroceries
//
//  Created by Dirk on 2/11/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
@interface SetupViewController : VHHUIViewController <CLLocationManagerDelegate>

@property (weak, nonatomic) IBOutlet UITextField *zipCodeTextField;
@property (weak, nonatomic) IBOutlet UILabel *cityNameLabel;
@property (weak, nonatomic) IBOutlet UILabel *communityIDLabel;
@property (weak, nonatomic) IBOutlet UILabel *communityNameLabel;
@property (weak, nonatomic) IBOutlet UILabel *countyIDLabel;
@property (weak, nonatomic) IBOutlet UILabel *countyNameLabel;
@property (weak, nonatomic) IBOutlet UILabel *stateIDLabel;
@property (weak, nonatomic) IBOutlet UILabel *stateNameLabel;
@property (weak, nonatomic) IBOutlet UILabel *countryLabel;


- (IBAction)findLocaton:(id)sender;
- (IBAction)submitZip:(id)sender;
- (IBAction)clearCookies:(id)sender;

@end
