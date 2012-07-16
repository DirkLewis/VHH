//
//  UIAlertView+factory.m
//  iSaveGroceries
//
//  Created by Dirk on 4/1/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "UIAlertView+factory.h"


@implementation UIAlertView (factory)


+ (UIAlertView*)createZipCodeAlertView:(id)delegate{
    
    UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"Your Zip Code..." message:@"Please enter you zip code." delegate:delegate cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
    alertView.alertViewStyle = UIAlertViewStylePlainTextInput;
    alertView.tag = kZipCodeAlertView;
    return alertView;
}

@end
