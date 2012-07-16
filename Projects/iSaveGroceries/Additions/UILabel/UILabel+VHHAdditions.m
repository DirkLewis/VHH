//
//  UILabel+VHHAdditions.m
//  ROMobileUniversal
//
//  Created by Dirk Lewis 11/16/2011
//  Copyright 2011 Optima  All rights reserved.
//

#import "UILabel+VHHAdditions.h"

@implementation UILabel (VHHAdditions)

-(void) alignTextTop
{
    CGSize textSize = [self.text sizeWithFont:self.font constrainedToSize:self.bounds.size];
    
    CGRect newRect = self.frame;
    newRect.size.height = textSize.height;
    self.frame = newRect;
}

-(void) alignTextBottom
{
    CGSize textSize = [self.text sizeWithFont:self.font constrainedToSize:self.bounds.size];
    
    CGRect newRect = self.frame;
    newRect.origin.y += (newRect.size.height - textSize.height);
    newRect.size.height = textSize.height;
    self.frame = newRect;
}

@end
