//
//  DynamicsViewController.h
//  WAHS
//
//  Created by Dirk Lewis on 7/1/13.
//  Copyright (c) 2013 VHH. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface DynamicsViewController : UIViewController <UIDynamicAnimatorDelegate, UICollisionBehaviorDelegate>
@property (strong, nonatomic) IBOutlet UIImageView *dynamicImageView;
@property (strong, nonatomic) IBOutlet UIView *dynamicView;
- (IBAction)touchButton:(UIButton *)sender;
- (IBAction)handlePan:(UIPanGestureRecognizer *)sender;

@end
