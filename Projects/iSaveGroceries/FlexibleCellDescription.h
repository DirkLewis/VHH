//
//  ROCellDescription.h
//  ROMobileUniversal
//
//  Created by Dirk Lewis on 2/3/12.
//  Copyright (c) 2012 Optima HCS. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface FlexibleCellDescription : NSObject

@property (nonatomic, assign) Class cellClass;
@property (nonatomic, strong) id cellData;


- (id)initWithCellClass:(Class)cellClass AndData:(id)cellData;
@end
