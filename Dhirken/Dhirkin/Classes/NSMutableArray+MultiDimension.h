//
//  NSMutableArray+MultiDimension.h
//  Dhirkin
//
//  Created by Dirk Lewis on 11/29/11.
//  Copyright (c) 2011 Optima HCS. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSMutableArray (MultiDimension)

- initWithColumns:(NSUInteger)intColumns:(NSUInteger)intRow;
+ mutableArrayWithColumns:(NSUInteger)intColumns:(NSUInteger)intRows;
- objectInMutableTable:(NSUInteger)intColumns:(NSUInteger)intRow;
- (void)setObject:(NSString *)object:(NSUInteger)intColumns:(NSUInteger)intRow;
- (NSUInteger)columnCount;
- (NSUInteger)rowCount;

@end
