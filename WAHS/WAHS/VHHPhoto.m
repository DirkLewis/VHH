//
//  BHPhoto.m
//  CollectionViewTutorial
//
//  Created by Bryan Hansen on 11/3/12.
//  Copyright (c) 2012 Bryan Hansen. All rights reserved.
//

#import "VHHPhoto.h"
#import "UIImage+Alpha.h"
#import "UIImage+Resize.h"
#import "UIImage+RoundedCorners.h"
#import "UIImage+Tint.h"
@interface VHHPhoto ()

@property (nonatomic, strong, readwrite) NSURL *imageURL;
@property (nonatomic, strong, readwrite) UIImage *image;

@end

@implementation VHHPhoto

#pragma mark - Properties

- (UIImage *)image
{
    if (!_image && self.imageURL) {
        NSData *imageData = [NSData dataWithContentsOfURL:self.imageURL];
        UIImage *image = [UIImage imageWithData:imageData scale:[UIScreen mainScreen].scale];
        
        UIImage *small = [image resizedImage:CGSizeMake(image.size.width / 2, image.size.height / 2) interpolationQuality:kCGInterpolationHigh];
        
        NSData *temp = UIImageJPEGRepresentation(small, 1.0f);
        
        _image = image;
    }
    
    return _image;
}

#pragma mark - Lifecycle

+ (VHHPhoto *)photoWithImageURL:(NSURL *)imageURL
{
    return [[self alloc] initWithImageURL:imageURL];
}

- (id)initWithImageURL:(NSURL *)imageURL
{
    self = [super init];
    if (self) {
        self.imageURL = imageURL;
    }
    return self;
}

@end
