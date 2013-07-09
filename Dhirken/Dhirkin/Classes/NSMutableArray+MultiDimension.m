//
//  NSMutableArray+MultiDimension.m
//  Dhirkin
//
//  Created by Dirk Lewis on 11/29/11.
//  Copyright (c) 2011 Optima HCS. All rights reserved.
//

#import "NSMutableArray+MultiDimension.h"

@implementation NSMutableArray (MultiDimension)


- initWithColumns:(NSUInteger)intColumns:(NSUInteger)intRow{
    NSUInteger c;
    NSUInteger r;
    
    if ((self = [self init])) {
        self = [[NSMutableArray alloc] initWithCapacity:intColumns];
        for (c=0; c < intColumns; c++) {
            NSMutableArray *a = [NSMutableArray arrayWithCapacity:intRow];
            for (r=0; r < intRow; r++) {
                [a insertObject:[NSNull null] atIndex:r];
            }
            [self addObject:a];
        }
    }
    return self;
}

+ mutableArrayWithColumns:(NSUInteger)intColumns:(NSUInteger)intRows{
    return [[self alloc] initWithColumns:intColumns:intRows] ;
}

- objectInMutableTable:(NSUInteger)intColumns:(NSUInteger)intRow{
    return [[self objectAtIndex:intColumns] objectAtIndex:intRow];
}

- (void)setObject:(NSString *)object:(NSUInteger)intColumns:(NSUInteger)intRow{
    [[self objectAtIndex:intColumns] replaceObjectAtIndex:intRow withObject:object];
}

- (NSUInteger)columnCount{
    
    NSUInteger count = [self count];

    return count;
}

- (NSUInteger)rowCount{

    NSUInteger count = [[self objectAtIndex:0]count];
    return count;
}

@end
