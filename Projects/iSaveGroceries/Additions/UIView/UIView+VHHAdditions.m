//
//  UIView+VHHAdditions.m
//  ROMobileUniversal
//
//  Created by Dirk Lewis 11/16/2011
//  Copyright 2011 Optima  All rights reserved.
//

#import "UIView+VHHAdditions.h"

@implementation UIView (UIView_VHHAdditions)

+ (UIView *)viewWithNibNamed:(NSString *)aNibName{
      
    // Create a temporary UIViewController to instantiate the custom view
    UIViewController *temporaryController = [[UIViewController alloc] initWithNibName:aNibName bundle:nil];
        
    UIView *view = [temporaryController view];
    
    return view;
    
}

#pragma mark - Touch Methods

- (void) touchesBegan:(NSSet *)touches withEvent:(UIEvent *) event{
    [super touchesBegan:touches withEvent:event];
    [[NSNotificationCenter defaultCenter] postNotificationName:@"BackgroundOperationTouchEventNotification" object:nil];
}

@end
