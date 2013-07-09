//
//  GeneralStyleSheet.m
//  FlexibleTables
//
//  Created by Dirk Lewis on 7/25/12.
//  Copyright (c) 2012 Optima HCS. All rights reserved.
//

#import "GeneralStyleSheet.h"
#import "NSDate+ROAdditions.h"
#import <QuartzCore/QuartzCore.h>
#import "UIColor+ROAdditions.h"
#import <FlexibleTableLibrary/FlexibleTableViewCell.h>
#import "SSBadgeView.h"
#import "FlexibleUIButton.h"
#import "UIImage+Tint.h"
#import "UIImage+RoundedCorners.h"
#import "UIImage+Alpha.h"
@implementation GeneralStyleSheet

+ (UIColor *)defaultBackgroundTexture{
    return [UIColor colorWithPatternImage:[UIImage imageNamed:@"linenTileLight.png"]];
}

+ (UIColor*)darkBackgroundTexture{
    return [UIColor colorWithPatternImage:[UIImage imageNamed:@"linenTileMedium.png"]];
}

+ (UIColor *)defaultTextColor{
    return [UIColor darkGrayColor];
}

+ (UIColor *)defaultLabelTextColor{
    return [UIColor lightGrayColor];
}

+ (UIColor *)disabledBackgroundColor{
    return [UIColor lightGrayColor];
}

+ (UIColor *)disabledTextColor{
    return [UIColor grayColor];
}

+ (UIColor *)lightBackgroundTexture{
    return [UIColor colorWithPatternImage:[UIImage imageNamed:@"linenTileLight.png"]];
}

+ (UIColor*)defaultBackgroundColorForErrorCondition{
    return [UIColor colorWithRed:178/255.0 green:34/255.0 blue:34/255.0 alpha:0.4];
}

+ (UIColor*)defaultBackgroundColorForWarningCondition{
    return [UIColor colorWithRed:205/255.0 green:173/255.0 blue:0/255.0 alpha:0.4];
}

+ (UIColor*)defaultBackgroundColorForInformationCondition{
    return [UIColor colorWithRed:100/255.0 green:149/255.0 blue:237/255.0 alpha:0.4];
}

+ (UIColor*)defaultBackgroundColorForVerboseCondition{
    return [UIColor colorWithRed:106/255.0 green:90/255.0 blue:205/255.0 alpha:0.4];
}

+ (UIColor*)defaultBackgroundColorForPerformanceEntry{
    return [UIColor colorWithRed:60/255.0 green:179/255.0 blue:113/255.0 alpha:0.4];
}


+ (void)styleTableForContentList:(UITableView *)tableView
{
    [tableView setSeparatorStyle:UITableViewCellSeparatorStyleNone];
    [tableView setBackgroundColor:[GeneralStyleSheet defaultBackgroundTexture]];
    UIImageView *shadow = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"5px-BottomShadow.png"]];
    [shadow setContentMode:UIViewContentModeScaleToFill];
    [shadow setFrame:CGRectMake(0, 0, [tableView frame].size.width, 5)];
    [shadow setAlpha:0.3];
    [tableView setTableFooterView:shadow];
}

+ (void)styleTableForMenuList:(UITableView *)tableView
{
	// Setting the background color of the UITableView directly caused some
	// issues with it leaking through the contained cells. Adding a background
	// view and setting the color there instead mitigates this problem.
	UIView *tableBackgroundView = [[UIView alloc] initWithFrame:tableView.frame];
	[tableView setBackgroundView:tableBackgroundView];
    [[tableView backgroundView] setBackgroundColor:[GeneralStyleSheet defaultBackgroundTexture]];
	
	[tableView setSeparatorColor:[UIColor darkGrayColor]];
	UIImageView *shadow = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"5px-BottomShadow.png"]];
	[shadow setContentMode:UIViewContentModeScaleToFill];
	[shadow setFrame:CGRectMake(0, 0, [tableView frame].size.width, 5)];
	[shadow setAlpha:0.3];
	[tableView setTableFooterView:shadow];
}

+ (void)styleCellForSystemLoggingEntry:(FlexibleTableViewCell*)cell{
    
}


+ (void)applyGrayGradientAppearanceToButton:(UIButton *)button
{
	UIImage *normalImage = [[UIImage imageNamed:@"button-gradient-gray.png"] stretchableImageWithLeftCapWidth:10
																								 topCapHeight:0];
	UIImage *highlightImage = [[UIImage imageNamed:@"button-gradient-gray-highlight.png"] stretchableImageWithLeftCapWidth:10
                                                                                                              topCapHeight:0];
    
	[button setBackgroundImage:normalImage forState:UIControlStateNormal];
	[button setBackgroundImage:highlightImage forState:UIControlStateHighlighted];
	
	[button setTitleColor:[UIColor darkGrayColor] forState:UIControlStateNormal];
	[button setTitleColor:[UIColor darkGrayColor] forState:UIControlStateHighlighted];
	[button setTitleShadowColor:[UIColor whiteColor] forState:UIControlStateNormal];
	[button setTitleShadowColor:[UIColor whiteColor] forState:UIControlStateHighlighted];
    
	[button.titleLabel setFont:[UIFont systemFontOfSize:14.0]];
	[button.titleLabel setShadowOffset:CGSizeMake(0, 1)];
}

+ (void)applyClearBackgroundToBasicCell:(UITableViewCell*)cell{
    
    cell.textLabel.backgroundColor = [UIColor clearColor];
    cell.detailTextLabel.backgroundColor = [UIColor clearColor];
    cell.detailTextLabel.textColor = [UIColor blackColor];
    
}

#pragma mark - SSBadge

+ (SSBadgeView*)basicBadgeView{
    
    SSBadgeView *badge = [[SSBadgeView alloc] initWithFrame:CGRectMake(0, 0, 40, 20)];
    badge.badgeColor = [GeneralStyleSheet defaultBackgroundColorForInformationCondition];
    badge.backgroundColor = [UIColor clearColor];
    return badge;
    
}

#pragma mark - flexible buttons

+ (FlexibleUIButton*)styleFlexibleButtonLoginConnected:(FlexibleUIButton*)button{
    
    button.hue = .565;
    button.saturation = 1.0;
    button.brightness = 1.0;
    button.enabled = YES;
    [button setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    //[button setTitle:[NSString stringWithFormat:@"Sign Into Org %@",[[ROSession sharedROSession]organizationCode]] forState:UIControlStateNormal];
    return button;
}

+ (FlexibleUIButton*)styleFlexibleButtonLoginDisconnectedNotAuthenticated:(FlexibleUIButton*)button{
    
    button.hue = .565;
    button.saturation = 0.22;
    button.brightness = 1.0;
    button.enabled = NO;
    [button setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    //[button setTitle:[NSString stringWithFormat:@"Sign Into Org %@",[[ROSession sharedROSession]organizationCode]] forState:UIControlStateNormal];
    return button;
}

+ (FlexibleUIButton*)styleFlexibleButtonLoginDisconnectedAuthenticated:(FlexibleUIButton*)button{
    
    button.hue = .0785;
    button.saturation = 1.0;
    button.brightness = 1.0;
    button.enabled = YES;
    [button setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    //[button setTitle:@"Disconnected" forState:UIControlStateNormal];
    return button;
}

+ (FlexibleUIButton*)styleFlexibleButtonDefault:(FlexibleUIButton*)button{
    
    button.hue = .565;
    button.saturation = 1.0;
    button.brightness = 1.0;
    button.enabled = YES;
    [button setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    return button;
}


#pragma mark - Alert Styles

+ (void)styleImageViewForAlert:(UIImageView*)imageView color:(UIColor*)color{
    
    CGRect rect = CGRectMake(0, 0, 1, 1);
    UIGraphicsBeginImageContext(rect.size);
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSetFillColorWithColor(context, [color CGColor]);
    
    CGContextFillRect(context, rect);
    UIImage *img = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    imageView.image = img;
    imageView.layer.masksToBounds = YES;
    [imageView.layer setBorderColor:[[UIColor whiteColor]CGColor]];
    [imageView.layer setBorderWidth:3.0];
    [imageView.layer setCornerRadius:20.0];
}


@end
