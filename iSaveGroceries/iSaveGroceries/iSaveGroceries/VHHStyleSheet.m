//
//  ROStyleSheet.h
//  RehabOptimaMobile
//
//  Created by Alondo Brewington on 8/1/11.
//  Copyright 2011 GiftRAP Corporation. All rights reserved.
//

#import "VHHStyleSheet.h"
#import <QuartzCore/QuartzCore.h>
//#import "RGB2HSV.h"

@implementation VHHStyleSheet

+ (UIColor *)defaultBackgroundTexture{
    return [UIColor colorWithPatternImage:[UIImage imageNamed:@"linenTileLight.png"]];
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
    return [UIColor colorWithRed:245/255.0 green:228/255.0 blue:152/255.0 alpha:0.4];

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

+ (UIColor *)textColorForDocumentStatus:(NSString *)documentStatusCode {
    // assume default color black
    return [UIColor blackColor];
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


+ (void)styleTableForContentList:(UITableView *)tableView
{
    [tableView setSeparatorStyle:UITableViewCellSeparatorStyleNone];
    [tableView setBackgroundColor:[self defaultBackgroundTexture]];
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
    [[tableView backgroundView] setBackgroundColor:[VHHStyleSheet defaultBackgroundTexture]];
	
	[tableView setSeparatorColor:[UIColor darkGrayColor]];
	UIImageView *shadow = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"5px-BottomShadow.png"]];
	[shadow setContentMode:UIViewContentModeScaleToFill];
	[shadow setFrame:CGRectMake(0, 0, [tableView frame].size.width, 5)];
	[shadow setAlpha:0.3];
	[tableView setTableFooterView:shadow];
}


+ (void)applyClearBackgroundToBasicCell:(UITableViewCell*)cell{

    cell.textLabel.backgroundColor = [UIColor clearColor];
    cell.detailTextLabel.backgroundColor = [UIColor clearColor];
    cell.detailTextLabel.textColor = [UIColor blackColor];

}
@end