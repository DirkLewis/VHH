//
//  MessageViewController.h
//  WAHS
//
//  Created by Dirk Lewis on 6/27/13.
//  Copyright (c) 2013 VHH. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SessionManager.h"

@interface MessageViewController : UIViewController <UITableViewDataSource, UITableViewDelegate, SessionManagerDelegate, UITextFieldDelegate>
@property (strong, nonatomic) IBOutlet UITextField *messageTextField;
- (IBAction)touchSendButton:(id)sender;
@property (strong, nonatomic) IBOutlet UITableView *messageTableView;

@end

