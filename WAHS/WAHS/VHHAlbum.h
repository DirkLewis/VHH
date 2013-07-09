//
//  BHAlbum.h
//  CollectionViewTutorial
//
//  Created by Bryan Hansen on 11/3/12.
//  Copyright (c) 2012 Bryan Hansen. All rights reserved.
//

#import <Foundation/Foundation.h>

@class VHHPhoto;

@interface VHHAlbum : NSObject

@property (nonatomic, strong) NSString *name;
@property (nonatomic, strong, readonly) NSArray *photos;

- (void)addPhoto:(VHHPhoto *)photo;
- (BOOL)removePhoto:(VHHPhoto *)photo;

@end
