//
//  SwipeUpViewController.h
//  WAHS
//
//  Created by Dirk Lewis on 6/28/13.
//  Copyright (c) 2013 VHH. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SwipeUpViewController : UIViewController

- (IBAction)handelPan:(UIPanGestureRecognizer*)recognizer;
- (IBAction)handlePinch:(UIPinchGestureRecognizer*)recognizer;
- (IBAction)handleRotate:(UIRotationGestureRecognizer*)recognizer;
- (IBAction)handleViewPan:(UIPanGestureRecognizer *)sender;


@end
