//
//  ROCellDescription.h
//  ROMobileUniversal
//
//  Created by Dirk Lewis on 2/3/12.
//  Copyright (c) 2012 Optima HCS. All rights reserved.
//

#import <Foundation/Foundation.h>

@class CustomCellBackground;

@interface FlexibleCellDescription : NSObject

@property (nonatomic, assign) Class cellClass;
@property (nonatomic, strong) id cellData;
@property (nonatomic, strong) Class backgroundViewClass;
@property (nonatomic, strong) Class selectedBackgroundViewClass;

- (id)initWithCellClass:(Class)cellClass AndData:(id)cellData backgroundViewClass:(Class)backgroundViewClass selectedBackgroundViewClass:(Class)selectedBackgroundViewClass;

@end
