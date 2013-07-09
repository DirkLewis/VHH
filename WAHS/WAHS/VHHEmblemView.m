//
//  VHHEmblemView.m
//  WAHS
//
//  Created by Dirk Lewis on 7/1/13.
//  Copyright (c) 2013 VHH. All rights reserved.
//

#import "VHHEmblemView.h"

static NSString * const VHHEmblemViewImageName = @"emblem";


@implementation VHHEmblemView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        UIImage *image = [UIImage imageNamed:VHHEmblemViewImageName];
        UIImageView *imageView = [[UIImageView alloc]initWithImage:image];
        imageView.frame = self.bounds;
        [self addSubview:imageView];
        
    }
    return self;
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
}
*/

+(CGSize)defaultSize{

    return [UIImage imageNamed:VHHEmblemViewImageName].size;
}

@end
