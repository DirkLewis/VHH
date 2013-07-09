//
//  VHHPhotoAlbumLayout.h
//  WAHS
//
//  Created by Dirk Lewis on 6/28/13.
//  Copyright (c) 2013 VHH. All rights reserved.
//

#import <Foundation/Foundation.h>
UIKIT_EXTERN NSString * const VHHPhotoAlbumLayoutAlbumTitleKind;

@interface VHHPhotoAlbumLayout : UICollectionViewLayout

@property (nonatomic)UIEdgeInsets itemInsets;
@property (nonatomic)CGSize itemSize;
@property (nonatomic)CGFloat interItemSpacingY;
@property (nonatomic)NSInteger numberOfColumns;
@property (nonatomic)CGFloat titleHeight;


@end
