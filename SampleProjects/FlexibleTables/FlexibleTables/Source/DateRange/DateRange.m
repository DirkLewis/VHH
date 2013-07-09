//
//  DateRange.m
//  ROMobileUniversal
//
//  Created by Dirk Lewis on 1/11/12.
//  Copyright (c) 2012 Optima HCS. All rights reserved.
//

#import "NSDate+ROAdditions.h"
#import "DateRange.h"

@implementation DateRange

@synthesize startDate = _startDate, endDate = _endDate, isOpenEnded = _isOpenEnded;

- (BOOL)isDateWithinRange:(NSDate*)date{
    
    //NSDate *startDate = [NSDate dateFromString:[self valueForKey:@"startDate"] withFormat:@"MM/dd/yyyy"];
    //NSDate *endDate = [NSDate dateFromString:[self valueForKey:@"endDate"] withFormat:@"MM/dd/yyyy"];
    
    if (!self.endDate) {
        BOOL result = [date compare:self.startDate] != NSOrderedAscending;
        return result;
    }
    
    BOOL result = [date isBetweenDate:self.startDate andDate:self.endDate];
    
    return result;
    
}

+ (DateRange*)dateRangeFromStartDate:(NSDate*)startDate AndEndDate:(NSDate*)endDate{
    
    DateRange *dateRange = [[DateRange alloc]init];
    
    if (!endDate) {
        dateRange.startDate = startDate;
        dateRange.endDate = nil;
        dateRange.isOpenEnded = [NSNumber numberWithBool:YES];
        return dateRange;
    }
    
    dateRange.startDate = startDate;
    dateRange.endDate = endDate;
    dateRange.isOpenEnded = [NSNumber numberWithBool:NO];
    
    return dateRange;
}

+ (DateRange*)dateRangeFromDictionary:(NSDictionary*)dictionary{

    DateRange *dateRange = [[DateRange alloc]init];
    
    dateRange.startDate = [NSDate dateFromString:[dictionary valueForKey:@"startDate"]];
    dateRange.endDate = [NSDate dateFromString:[dictionary valueForKey:@"endDate"]];
    if (!dateRange.endDate) {
        dateRange.isOpenEnded = [NSNumber numberWithBool:YES];
    }
    else{
        dateRange.isOpenEnded = [NSNumber numberWithBool:NO];

    }

    return dateRange;
}


#pragma  mark - Encoding
- (void)encodeWithCoder:(NSCoder *)coder {
    
    [coder encodeObject:self.startDate forKey:@"startDate"];
    [coder encodeObject:self.endDate forKey:@"endDate"];
    [coder encodeObject:self.isOpenEnded forKey:@"isOpenEnded"];
    
}

- (id)initWithCoder:(NSCoder *)decoder {
    
    if (self = [super init]) {
        
        _startDate = [decoder decodeObjectForKey:@"startDate"];
        _endDate = [decoder decodeObjectForKey:@"endDate"];
        _isOpenEnded = [decoder decodeObjectForKey:@"isOpenEnded"];
    }
    
    return self;
}
@end
