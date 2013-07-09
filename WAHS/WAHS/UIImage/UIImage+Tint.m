//
//  UIImage+Tint.m
//  ROMobileUniversal
//
//  Created by Dirk Lewis on 3/28/12.
//  Copyright (c) 2012 Optima HCS. All rights reserved.
//

#import "UIImage+Tint.h"

@implementation UIImage (Tint)

+ (UIImage *)imageWithColor:(UIColor *)color andImage:(UIImage *)image{
    
    // create Image from Color
    CGRect rect = CGRectMake(0, 0, image.size.width, image.size.height);
    UIGraphicsBeginImageContext(rect.size);
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSetFillColorWithColor(context,[color CGColor]);
    CGContextFillRect(context, rect);
    UIImage *img = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    // mask color
    CGImageRef actualMask = CGImageMaskCreate(CGImageGetWidth(image.CGImage),
                                              CGImageGetHeight(image.CGImage),
                                              CGImageGetBitsPerComponent(image.CGImage),
                                              CGImageGetBitsPerPixel(image.CGImage),
                                              CGImageGetBytesPerRow(image.CGImage),
                                              CGImageGetDataProvider(image.CGImage), NULL, false);
    
    
    CGImageRef masked = CGImageCreateWithMask([img CGImage], actualMask);
    CGImageRelease(actualMask);
    UIImage * retImage = [UIImage imageWithCGImage:masked];
    CGImageRelease(masked);
    return retImage;
}

+ (UIImage *)imageWithColor:(UIColor *)color {
    CGRect rect = CGRectMake(0, 0, 1, 1);
    // Create a 1 by 1 pixel context
    UIGraphicsBeginImageContextWithOptions(rect.size, NO, 0);
    [color setFill];
    UIRectFill(rect);   // Fill it with your color
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    return image;
}

@end
