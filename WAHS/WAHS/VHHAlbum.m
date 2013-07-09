//
//  BHAlbum.m
//  CollectionViewTutorial
//
//  Created by Bryan Hansen on 11/3/12.
//  Copyright (c) 2012 Bryan Hansen. All rights reserved.
//

#import "VHHAlbum.h"
#import "VHHPhoto.h"

@interface VHHAlbum ()

@property (nonatomic, strong) NSMutableArray *mutablePhotos;

@end

@implementation VHHAlbum

#pragma mark - Properties

- (NSArray *)photos
{
    return [self.mutablePhotos copy];
}


#pragma mark - Lifecycle

- (id)init
{
    self = [super init];
    if (self) {
        _mutablePhotos = [NSMutableArray array];
    }
    return self;
}

#pragma mark - Photos

- (void)addPhoto:(VHHPhoto *)photo
{
    [self.mutablePhotos addObject:photo];
}

- (BOOL)removePhoto:(VHHPhoto *)photo
{
    if ([self.mutablePhotos indexOfObject:photo] == NSNotFound) {
        return NO;
    }
    
    [self.mutablePhotos removeObject:photo];
    
    return YES;
}



@end
