//
//  DateRange.h
//  ROMobileUniversal
//
//  Created by Dirk Lewis on 1/11/12.
//  Copyright (c) 2012 Optima HCS. All rights reserved.
//

#import <Foundation/Foundation.h>
@interface DateRange : NSObject <NSCoding>

@property (nonatomic, strong) NSDate *startDate;
@property (nonatomic, strong) NSDate *endDate;
@property (nonatomic, strong) NSNumber *isOpenEnded;
- (BOOL)isDateWithinRange:(NSDate*)date;
+ (DateRange*)dateRangeFromStartDate:(NSDate*)startDate AndEndDate:(NSDate*)endDate;
+ (DateRange*)dateRangeFromDictionary:(NSDictionary*)dictionary;

@end
