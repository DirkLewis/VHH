//
//  ROStyleSheet.h
//  RehabOptimaMobile
//
//  Created by Alondo Brewington on 8/1/11.
//  Copyright 2011 GiftRAP Corporation. All rights reserved.
//

#import "StyleSheet.h"
#import "NSDate+ROAdditions.h"
#import <QuartzCore/QuartzCore.h>
#import "UIColor+ROAdditions.h"
#import <FlexibleTableLibrary/FlexibleTableViewCell.h>
#import "SSBadgeView.h"
#import "FlexibleUIButton.h"
#import "UIImage+Tint.h"
#import "UIImage+RoundedCorners.h"
#import "UIImage+Alpha.h"
#import "GeneralStyleSheet.h"
//#import "RGB2HSV.h"

@implementation StyleSheet



+ (UIColor *)defaultTextColorForSTTrack{
    return [UIColor colorWithRed:105/255.0 green:74/255.0 blue:168/255.0 alpha:1.0];    
}

+ (UIColor *)defaultTextColorForOTTrack{
    return [UIColor colorWithRed:74/255.0 green:137/255.0 blue:168/255.0 alpha:1.0];
}

+ (UIColor *)defaultTextColorForPTTrack{
    return [UIColor colorWithRed:74/255.0 green:168/255.0 blue:79/255.0 alpha:1.0];
}

+ (UIColor *)defaultTextColorForClosedTrack{
    return [UIColor grayColor];
}

+ (UIColor *)defaultBackgroundColorForSTTrack{
    return [UIColor colorWithRed:234/255.0 green:225/255.0 blue:247/255.0 alpha:1.0];
}

+ (UIColor *)defaultBackgroundColorForOTTrack{
    return [UIColor colorWithRed:225/255.0 green:240/255.0 blue:247/255.0 alpha:1.0];
}

+ (UIColor *)defaultBackgroundColorForPTTrack{
    return [UIColor colorWithRed:227/255.0 green:247/255.00 blue:225/255.0 alpha:1.0];
}

+ (UIColor *)defaultBackgroundColorForClosedTrack{
    return [UIColor grayColor];
}

+ (UIColor *)lightBackgroundColorForPTTrack{
    return [UIColor colorWithRed:227/255.0 green:247/255.0 blue:225/255.0 alpha:1.0];
    
}

+ (UIColor *)lightBackgroundColorForOTTrack{
    return [UIColor colorWithRed:225/255.0 green:240/255.0 blue:247/255.0 alpha:1.0];
}

+ (UIColor *)lightBackgroundColorForSTTrack{
    return [UIColor colorWithRed:234/255.0 green:225/255.0 blue:247/255.0 alpha:1.0];
}

+ (UIColor *)lightBackgroundColorForClosedTrack{
    return [UIColor grayColor];
}

+ (UIColor *)darkBackgroundColorForPTTrack{
    return [UIColor colorWithRed:139/255.0 green:232/255.0 blue:131/255.0 alpha:1.0];
}

+ (UIColor *)darkBackgroundColorForOTTrack{
    return [UIColor colorWithRed:114/255.0 green:191/255.0 blue:229/255.0 alpha:1.0];
}

+ (UIColor *)darkBackgroundColorForSTTrack{
    return [UIColor colorWithRed:164/255.0 green:119/255.0 blue:230/255.0 alpha:1.0];
}

+ (UIColor *)darkBackgroundColorForClosedTrack{
    return [UIColor grayColor];
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

+ (NSString *)documentIconNameForDocumentStatus: (NSString *)documentStatusCode{
    if([documentStatusCode isEqualToString:kDocumentStatusInComplete]) {
		return  @"document_status_icon_incomplete.png";
	} else if([documentStatusCode isEqualToString:kDocumentStatusSigned]) {
		return @"document_status_icon_signed.png";
	} else if([documentStatusCode isEqualToString:kDocumentStatusCoSign]) {
		return @"document_status_icon_cosigned.png";
	}
    
    // assume default type kDocumentStatusComplete 
    return @"document_status_icon_complete.png";
}


+ (NSString *)payerTypeIconNameFor:(NSString *)payerType{
    
	if([payerType isEqualToString:kPayerTypeA]) {
		return  @"payer_type_icon_a.png";
	} else if([payerType isEqualToString:kPayerTypeB]) {
		return @"payer_type_icon_b.png";
	}
    
    // assume default type MCO
    return @"payer_type_icon_o.png";
}

+ (UIColor *)backgroundColorForDisciplineCode:(NSString *)disciplineCode{
    if  ([disciplineCode compare:kRODisciplineCodePhysicalTherapy] == NSOrderedSame){
        return [StyleSheet defaultBackgroundColorForPTTrack];
    }else if ([disciplineCode compare:kRODisciplineCodeOccupationalTherapy] == NSOrderedSame){
        return [StyleSheet defaultBackgroundColorForOTTrack];
    }else { // assume Speech
        return [StyleSheet defaultBackgroundColorForSTTrack];
    }
}

+ (UIColor *)lightBackgroundColorForDisciplineCode:(NSString *)disciplineCode{
    if  ([disciplineCode compare:kRODisciplineCodePhysicalTherapy] == NSOrderedSame){
        return [StyleSheet lightBackgroundColorForPTTrack];
    }else if ([disciplineCode compare:kRODisciplineCodeOccupationalTherapy] == NSOrderedSame){
        return [StyleSheet lightBackgroundColorForOTTrack];
    }else { // assume Speech
        return [StyleSheet lightBackgroundColorForSTTrack];
    }
}

+ (UIColor *)darkBackgroundColorForDisciplineCode:(NSString *)disciplineCode{
    if  ([disciplineCode compare:kRODisciplineCodePhysicalTherapy] == NSOrderedSame){
        return [StyleSheet darkBackgroundColorForPTTrack];
    }else if ([disciplineCode compare:kRODisciplineCodeOccupationalTherapy] == NSOrderedSame){
        return [StyleSheet darkBackgroundColorForOTTrack];
    }else { // assume Speech
        return [StyleSheet darkBackgroundColorForSTTrack];
    }
}

+ (UIColor *)labelColorForDisciplineCode:(NSString *)disciplineCode{
    if  ([disciplineCode compare:kRODisciplineCodePhysicalTherapy] == NSOrderedSame){
        return [StyleSheet defaultTextColorForPTTrack];
    }else if ([disciplineCode compare:kRODisciplineCodeOccupationalTherapy] == NSOrderedSame){
        return [StyleSheet defaultTextColorForOTTrack];
    }else { // assume Speech
        return [StyleSheet defaultTextColorForSTTrack];
    }
}


+ (NSDateFormatter *)dateFormatter{
    NSDateFormatter* dateFormatter = [NSDate dateFormatterForCurrentThread];
    [dateFormatter setDateFormat:@"MM/dd/yyyy"];
    return dateFormatter;
}

+ (CAGradientLayer *)gradientLayerForDisciplineWithStartColor:(UIColor *)startColor endColor:(UIColor *)endColor frame:(CGRect)frame
{
    CAGradientLayer *gradient = [CAGradientLayer layer];
    gradient.frame = frame;
    gradient.startPoint = CGPointMake(0, 0.5);
    gradient.endPoint = CGPointMake(1.0, 0.5);
    gradient.colors = [NSArray arrayWithObjects:(id)[startColor CGColor], (id)[endColor CGColor], nil];
    return gradient;

}

+ (CAGradientLayer *)gradientLayerForDisciplineCode:(NSString *)disciplineCode withFrame:(CGRect)frame
{
    UIColor *startColor = [StyleSheet darkBackgroundColorForDisciplineCode:disciplineCode];
    UIColor *endColor = [StyleSheet lightBackgroundColorForDisciplineCode:disciplineCode];
    return [StyleSheet gradientLayerForDisciplineWithStartColor:startColor endColor:endColor frame:frame];
}

+ (CAGradientLayer *)gradientHighlightLayerForDisciplineCode:(NSString *)disciplineCode withFrame:(CGRect)frame
{
    UIColor *startColor = [[StyleSheet darkBackgroundColorForDisciplineCode:disciplineCode] roSubtleHighlight];
    UIColor *endColor = [[StyleSheet lightBackgroundColorForDisciplineCode:disciplineCode] roSubtleHighlight];;
    return [StyleSheet gradientLayerForDisciplineWithStartColor:startColor endColor:endColor frame:frame];
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

+ (void)applyDisciplineBackgroundGradientToView:(UIView *)view forDisciplineCode:(NSString *)disciplineCode{
    CGFloat frameWidth = view.frame.size.width;
    CGFloat frameHeight = view.frame.size.height;
    UIColor *bgColor = [StyleSheet backgroundColorForDisciplineCode:disciplineCode];
    UIColor *highlightColor = [bgColor roSubtleHighlight];
    UIColor *shadowColor = [bgColor shadow];
    
    [view setBackgroundColor:bgColor];
    CAGradientLayer *gradient = [StyleSheet gradientLayerForDisciplineCode:disciplineCode withFrame:CGRectMake(0, 0, 29, frameHeight)];
    
    CALayer *shadowLayer = [CALayer layer];
    [shadowLayer setFrame:CGRectMake(0, 0, frameWidth, 1)];
    [shadowLayer setBackgroundColor:[shadowColor CGColor]];
    [shadowLayer setOpacity:0.4];

    CALayer *highlightLayer = [CALayer layer];
    [highlightLayer setFrame:CGRectMake(0, frameHeight - 2, frameWidth, 1)];
    [highlightLayer setBackgroundColor:[highlightColor CGColor]];

            
    [gradient addSublayer:shadowLayer];
    [gradient addSublayer:highlightLayer];
    [view.layer insertSublayer:gradient atIndex:0];
    


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