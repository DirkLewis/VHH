//
//  VHHPhotoAlbumLayout.m
//  WAHS
//
//  Created by Dirk Lewis on 6/28/13.
//  Copyright (c) 2013 VHH. All rights reserved.
//

#import "VHHPhotoAlbumLayout.h"
#import "VHHEmblemView.h"

static NSString * const VHHPhotoAlbumCellKind = @"photocell";
static NSUInteger const RotationCount = 32;
static NSUInteger const RotationStride = 3;
static NSUInteger const PhotoCellBaseZIndex = 100;

NSString * const VHHPhotoAlbumLayoutAlbumTitleKind = @"albumtitle";
static NSString * const VHHPhotoEmblemKind = @"emblem";

@interface VHHPhotoAlbumLayout()
@property (nonatomic,strong)NSDictionary *layoutInfo;
@property (nonatomic,strong)NSArray *rotations;

@end

@implementation VHHPhotoAlbumLayout
- (id)initWithCoder:(NSCoder *)coder
{
    self = [super initWithCoder:coder];
    if (self) {
        [self setup];
    }
    return self;
}

- (id)init
{
    self = [super init];
    if (self) {
        [self setup];
    }
    return self;
}

- (void)setup{

    self.itemInsets = UIEdgeInsetsMake(22.0f, 22.0f, 13.0f, 22.0f);
    self.itemSize = CGSizeMake(125.0f, 125.0f);
    self.interItemSpacingY = 12.0f;
    self.numberOfColumns = 2;
    self.titleHeight = 26.0f;
    
    
    NSMutableArray *rotations = [NSMutableArray arrayWithCapacity:RotationCount];
    CGFloat percentage = 0.0f;
    
    for (NSInteger i = 0 ; i<RotationCount; i++) {
        CGFloat newPercentage = 0.0f;
        do {
            newPercentage = ((CGFloat)(arc4random()%220)-110) * 0.0001f;
            
        } while (fabsf(percentage - newPercentage)< 0.006);
        percentage = newPercentage;
        CGFloat angle = 2 * M_PI * (1.0f + percentage);
        CATransform3D transform = CATransform3DMakeRotation(angle, 0.0f, 0.0f, 1.0f);
        [rotations addObject:[NSValue valueWithCATransform3D:transform]];
    }
    
    self.rotations = rotations;
    [self registerClass:[VHHEmblemView class] forDecorationViewOfKind:VHHPhotoEmblemKind];
}

#pragma mark - transforms

- (CATransform3D)transformForAlbumPhotoAtIndexPath:(NSIndexPath*)indexPath{

    NSInteger offset = (indexPath.section * RotationStride + indexPath.item);
    return [self.rotations[offset % RotationCount]CATransform3DValue];
    
}

#pragma mark - setters

- (void)setItemInsets:(UIEdgeInsets)itemInsets{

    if (UIEdgeInsetsEqualToEdgeInsets(_itemInsets, itemInsets)) return;
    _itemInsets = itemInsets;
    [self invalidateLayout];
}

- (void)setItemSize:(CGSize)itemSize{

    if (CGSizeEqualToSize(_itemSize, itemSize)) return;
    
    _itemSize = itemSize;
    [self invalidateLayout];
    
}

- (void)setInterItemSpacingY:(CGFloat)interItemSpacingY{

    if (_interItemSpacingY == interItemSpacingY) return;
    
    _interItemSpacingY = interItemSpacingY;
    [self invalidateLayout];
}

- (void)setNumberOfColumns:(NSInteger)numberOfColumns{

    if (_numberOfColumns == numberOfColumns) return;
    _numberOfColumns = numberOfColumns;
    [self invalidateLayout];
}

- (void)setTitleHeight:(CGFloat)titleHeight{

    if (_titleHeight == titleHeight) return;
    
    _titleHeight = titleHeight;
    [self invalidateLayout];
}

#pragma mark - Private

- (CGRect)frameForEmblem{

    CGSize size = [VHHEmblemView defaultSize];
    CGFloat originX = floorf((self.collectionView.bounds.size.width - size.width) * 0.5f);
    CGFloat originY = -size.height - 30.0f;
    
    return CGRectMake(originX, originY, size.width, size.height);
}

- (CGRect)frameForAlbumPhotoAtIndexPath:(NSIndexPath*)indexPath{

    NSInteger row = indexPath.section / self.numberOfColumns;
    NSInteger column = indexPath.section % self.numberOfColumns;
    
    CGFloat spacingX = self.collectionView.bounds.size.width - self.itemInsets.left - self.itemInsets.right - (self.numberOfColumns * self.itemSize.width);
    
    if (self.numberOfColumns > 1) spacingX = spacingX / (self.numberOfColumns -1);
    CGFloat originX = floorf(self.itemInsets.left + (self.itemSize.width + spacingX)* column);
    CGFloat originY = floor(self.itemInsets.top + (self.itemSize.height + self.titleHeight + self.interItemSpacingY)*row);
    return CGRectMake(originX, originY, self.itemSize.width, self.itemSize.height);
    
}

- (CGRect)frameForAlbumTitleAtIndexPath:(NSIndexPath*)indexPath{
    
    CGRect frame = [self frameForAlbumPhotoAtIndexPath:indexPath];
    frame.origin.y += frame.size.height;
    frame.size.height = self.titleHeight;
    return frame;
}

#pragma mark - Layout

- (UICollectionViewLayoutAttributes*)layoutAttributesForDecorationViewOfKind:(NSString *)decorationViewKind atIndexPath:(NSIndexPath *)indexPath{

    return self.layoutInfo[VHHPhotoEmblemKind][indexPath];
}

- (UICollectionViewLayoutAttributes*)layoutAttributesForSupplementaryViewOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath{

    return self.layoutInfo[VHHPhotoAlbumLayoutAlbumTitleKind][indexPath];
}

- (NSArray*)layoutAttributesForElementsInRect:(CGRect)rect{

    NSMutableArray *allAttributes = [NSMutableArray arrayWithCapacity:self.layoutInfo.count];
    [self.layoutInfo enumerateKeysAndObjectsUsingBlock:^(NSString *key, NSDictionary *obj, BOOL *stop) {
        
        [obj enumerateKeysAndObjectsUsingBlock:^(NSIndexPath *key, UICollectionViewLayoutAttributes *attributes, BOOL *stop) {
            if (CGRectIntersectsRect(rect, attributes.frame)) {
                [allAttributes addObject:attributes];
            }
        }];
    }];
    
    return allAttributes;
}

- (UICollectionViewLayoutAttributes*)layoutAttributesForItemAtIndexPath:(NSIndexPath *)indexPath{

    return self.layoutInfo[VHHPhotoAlbumCellKind][indexPath];
}

- (CGSize)collectionViewContentSize{

    NSInteger rowCount = [self.collectionView numberOfSections]/self.numberOfColumns;
    if ([self.collectionView numberOfSections] % self.numberOfColumns) rowCount ++;
    
    CGFloat height = self.itemInsets.top + rowCount * self.itemSize.height + (rowCount - 1) * self.interItemSpacingY + rowCount * self.titleHeight +self.itemInsets.bottom;
    
    return CGSizeMake(self.collectionView.bounds.size.width, height);
}

- (void)prepareLayout{

    NSMutableDictionary *newLayoutInfo = [NSMutableDictionary dictionary];
    NSMutableDictionary *cellLayoutInfo = [NSMutableDictionary dictionary];
    NSMutableDictionary *titleLayoutInfo = [NSMutableDictionary dictionary];
    
    NSInteger sectionCount = [self.collectionView numberOfSections];
    NSIndexPath *indexPath = [NSIndexPath indexPathForItem:0 inSection:0];
    
    UICollectionViewLayoutAttributes *emblemAttributes = [UICollectionViewLayoutAttributes layoutAttributesForDecorationViewOfKind:VHHPhotoEmblemKind withIndexPath:indexPath];
    emblemAttributes.frame = [self frameForEmblem];
    newLayoutInfo[VHHPhotoEmblemKind] = @{indexPath:emblemAttributes};
    
    for (NSInteger section = 0; section < sectionCount; section++) {
        NSInteger itemCount = [self.collectionView numberOfItemsInSection:0];
        for (NSInteger item = 0; item < itemCount; item++) {
            indexPath = [NSIndexPath indexPathForItem:item inSection:section];
            UICollectionViewLayoutAttributes *itemAttributes = [UICollectionViewLayoutAttributes layoutAttributesForCellWithIndexPath:indexPath];
            itemAttributes.frame = [self frameForAlbumPhotoAtIndexPath:indexPath];
            itemAttributes.transform3D = [self transformForAlbumPhotoAtIndexPath:indexPath];
            itemAttributes.zIndex = PhotoCellBaseZIndex + itemCount - item;
            cellLayoutInfo[indexPath]=itemAttributes;
            
            if (indexPath.item == 0) {
                UICollectionViewLayoutAttributes *titleAttributes = [UICollectionViewLayoutAttributes layoutAttributesForSupplementaryViewOfKind:VHHPhotoAlbumLayoutAlbumTitleKind withIndexPath:indexPath];
                titleAttributes.frame = [self frameForAlbumTitleAtIndexPath:indexPath];
                titleLayoutInfo[indexPath] = titleAttributes;
            }
        }
    }
    newLayoutInfo[VHHPhotoAlbumCellKind] = cellLayoutInfo;
    newLayoutInfo[VHHPhotoAlbumLayoutAlbumTitleKind] = titleLayoutInfo;
    
    self.layoutInfo = newLayoutInfo;
}
@end
