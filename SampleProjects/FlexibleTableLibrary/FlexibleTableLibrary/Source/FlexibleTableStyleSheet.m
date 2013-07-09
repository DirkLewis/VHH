//
//  FlexibleTableStyleSheet.m
//  FlexibleTables
//
//  Created by Dirk Lewis on 7/25/12.
//  Copyright (c) 2012 Optima HCS. All rights reserved.
//

#import "FlexibleTableStyleSheet.h"
#import <QuartzCore/QuartzCore.h>
#import "UIColor+ROAdditions.h"
#import "FlexibleTableViewCell.h"
#import "UIImage+Tint.h"
#import "UIImage+RoundedCorners.h"
#import "UIImage+Alpha.h"
@implementation FlexibleTableStyleSheet

#pragma mark - Flexible Table view styles

+ (void)styleFlexibleHeaderView:(UIView*)view{
    view.autoresizingMask = UIViewAutoresizingFlexibleWidth;
    view.backgroundColor = [UIColor colorWithRed:226.0/255.0 green:231.0/255.0 blue:237.0/255.0 alpha:1.0];
    
}

+ (void)styleFlexibleHeaderLastUpdatedLabel:(UILabel*)label{
    label.autoresizingMask = UIViewAutoresizingFlexibleWidth;
    label.font = [UIFont systemFontOfSize:12.0f];
    label.textColor = TEXT_COLOR;
    label.shadowColor = [UIColor colorWithWhite:0.9f alpha:1.0f];
    label.shadowOffset = CGSizeMake(0.0f, 1.0f);
    label.backgroundColor = [UIColor clearColor];
    label.textAlignment = UITextAlignmentCenter;
}


+ (void)styleFlexibleHeaderStatusLabel:(UILabel*)label{
    label.autoresizingMask = UIViewAutoresizingFlexibleWidth;
    label.font = [UIFont systemFontOfSize:12.0f];
    label.textColor = TEXT_COLOR;
    label.shadowColor = [UIColor colorWithWhite:0.9f alpha:1.0f];
    label.shadowOffset = CGSizeMake(0.0f, 1.0f);
    label.backgroundColor = [UIColor clearColor];
    label.textAlignment = UITextAlignmentCenter;
}

+ (void)styleFlexibleHeaderImageLayer:(CALayer*)layer frame:(CGRect)frame{
    
    layer.frame = CGRectMake(25.0f, frame.size.height - 65.0f, 30.0f, 55.0f);
    layer.contentsGravity = kCAGravityResizeAspect;
    layer.contents = (id)[UIImage imageNamed:@"blueArrow.png"].CGImage;
    
}

@end
