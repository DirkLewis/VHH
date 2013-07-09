//
//  CoolButton.h
//  coolbutton
//
//  Created by Dirk Lewis on 4/17/12.
//  Copyright (c) 2012 Optima HCS. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface FlexibleUIButton : UIButton

@property (nonatomic, assign) CGFloat hue;
@property (nonatomic, assign) CGFloat saturation;
@property (nonatomic, assign) CGFloat brightness;
@property (nonatomic, weak) id buttonTarget;

@end
