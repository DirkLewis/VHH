//
//  ViewController.h
//  CoreRepositoryTestAppVC
//
//  Created by Dirk Lewis on 7/19/12.
//  Copyright (c) 2012 Optima HCS. All rights reserved.
//

#import <UIKit/UIKit.h>
@interface CoreRepositoryTestAppVC : UIViewController
@property (weak, nonatomic) IBOutlet UITextField *passwordTextField;
@property (weak, nonatomic) IBOutlet UITextField *updatedPasswordTextField;

- (IBAction)touchRestButton:(id)sender;
- (IBAction)touchRunStuff:(id)sender;
- (IBAction)touchCreateSystemRepo:(id)sender;

@end
