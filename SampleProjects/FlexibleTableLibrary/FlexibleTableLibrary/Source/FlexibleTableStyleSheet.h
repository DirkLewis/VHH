//
//  FlexibleTableStyleSheet.h
//  FlexibleTables
//
//  Created by Dirk Lewis on 7/25/12.
//  Copyright (c) 2012 Optima HCS. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface FlexibleTableStyleSheet : NSObject
#pragma mark - Flexible Table view styles
+ (void)styleFlexibleHeaderView:(UIView*)view;
+ (void)styleFlexibleHeaderLastUpdatedLabel:(UILabel*)label;
+ (void)styleFlexibleHeaderStatusLabel:(UILabel*)label;
+ (void)styleFlexibleHeaderImageLayer:(CALayer*)layer frame:(CGRect)frame;
@end
