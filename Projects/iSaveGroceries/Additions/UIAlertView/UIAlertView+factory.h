//
//  UIAlertView+factory.h
//  iSaveGroceries
//
//  Created by Dirk on 4/1/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#define kZipCodeAlertView 100

@interface UIAlertView (factory)
+ (UIAlertView*)createZipCodeAlertView:(id)delegate;
@end
