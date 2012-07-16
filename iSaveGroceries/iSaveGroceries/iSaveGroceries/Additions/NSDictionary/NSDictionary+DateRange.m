//
//  NSDictionary+DateRange.m
//  ROMobileUniversal
//
//  Created by Dirk Lewis on 1/4/12.
//  Copyright (c) 2012 Optima HCS. All rights reserved.
//

#import "NSDictionary+DateRange.h"
#import "NSDate+VHHAdditions.h"
@implementation NSDictionary (DateRange)

- (BOOL)isDateWithinRange:(NSDate*)date{
    
    NSDate *startDate = [NSDate dateFromString:[self valueForKey:@"startDate"] withFormat:@"MM/dd/yyyy"];
    NSDate *endDate = [NSDate dateFromString:[self valueForKey:@"endDate"] withFormat:@"MM/dd/yyyy"];
    
    if (!endDate) {
        BOOL result = [date compare:startDate] != NSOrderedAscending;
        return result;
    }
    
    BOOL result = [date isBetweenDate:startDate andDate:endDate];

    return result;

}

- (BOOL)isEndDateOPEN{

    id openValue = [self valueForKey:@"endDate"];
    if ([openValue isKindOfClass:[NSString class]]) {
        return YES;
    }
    
    return NO;
}

@end
