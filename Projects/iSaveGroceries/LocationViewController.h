//
//  SecondViewController.h
//  iSaveGroceries
//
//  Created by Dirk on 2/11/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface LocationViewController : FlexibleViewControllerForTables <UIAlertViewDelegate,FlexibleTableViewProtocol,CLLocationManagerDelegate>

- (IBAction)touchLocateMe:(id)sender;

- (IBAction)touchAddMyZip:(id)sender;
- (IBAction)touchResetData:(id)sender;

@end
