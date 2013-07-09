//
//  GeneralStyleSheet.h
//  FlexibleTables
//
//  Created by Dirk Lewis on 7/25/12.
//  Copyright (c) 2012 Optima HCS. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "GraphicHelper.h"
#import <QuartzCore/QuartzCore.h>

@class FlexibleUIButton;
@class SSBadgeView;

@interface GeneralStyleSheet : NSObject

+ (UIColor*)defaultBackgroundTexture;
+ (UIColor*)defaultTextColor;
+ (UIColor*)defaultLabelTextColor;
+ (UIColor*)lightBackgroundTexture;
+ (UIColor*)darkBackgroundTexture;
+ (UIColor*)defaultBackgroundColorForErrorCondition;
+ (UIColor*)defaultBackgroundColorForWarningCondition;
+ (UIColor*)defaultBackgroundColorForInformationCondition;
+ (UIColor*)defaultBackgroundColorForVerboseCondition;
+ (UIColor*)defaultBackgroundColorForPerformanceEntry;
/** Colors for disabled things */
+ (UIColor*)disabledBackgroundColor;
+ (UIColor*)disabledTextColor;


+ (void)applyGrayGradientAppearanceToButton:(UIButton *)button;
+ (void)styleTableForContentList:(UITableView *)tableView;
+ (void)styleTableForMenuList:(UITableView *)tableView;
+ (void)applyClearBackgroundToBasicCell:(UITableViewCell*)cell;




#pragma mark - SSBadge
+ (SSBadgeView*)basicBadgeView;

#pragma mark - flexible buttons

+ (FlexibleUIButton*)styleFlexibleButtonLoginConnected:(FlexibleUIButton*)button;
+ (FlexibleUIButton*)styleFlexibleButtonLoginDisconnectedAuthenticated:(FlexibleUIButton*)button;
+ (FlexibleUIButton*)styleFlexibleButtonLoginDisconnectedNotAuthenticated:(FlexibleUIButton*)button;
+ (FlexibleUIButton*)styleFlexibleButtonDefault:(FlexibleUIButton*)button;


#pragma mark - Alert Styles
+ (void)styleImageViewForAlert:(UIImageView*)imageView color:(UIColor*)color;

@end
