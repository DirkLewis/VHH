//
//  NSDictionary+DateRange.h
//  ROMobileUniversal
//
//  Created by Dirk Lewis on 1/4/12.
//  Copyright (c) 2012 Optima HCS. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSDictionary (DateRange)

- (BOOL)isDateWithinRange:(NSDate*)date;
- (BOOL)isEndDateOPEN;
@end
