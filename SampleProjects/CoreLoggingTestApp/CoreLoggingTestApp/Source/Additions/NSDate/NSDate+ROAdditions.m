//
//  NSDate+ROAdditions.m
//  RehabOptimaMobile
//
//  Created by Dirk Lewis on 11/16/11.
//  Copyright 2011 Optima HCS  All rights reserved.
//

#import "NSDate+ROAdditions.h"
#import "DateRange.h"

@implementation NSDate (ROAdditions)

- (NSDate*)dateWithSecondsStrippedFromTime:(NSDate*)date{
    
    NSCalendar *currentCalendar = [NSDate gregorianCalendarForCurrentThread];
    NSDateComponents *dateComponents = [currentCalendar components:NSDayCalendarUnit|NSMonthCalendarUnit|NSYearCalendarUnit|NSHourCalendarUnit|NSMinuteCalendarUnit fromDate:self];   
    NSDate *newDate = [currentCalendar dateFromComponents:dateComponents];    
    return newDate;
}

+ (NSDateFormatter *)dateFormatterForCurrentThread
{
	static NSString *ThreadDictionaryDateFormatterKey = @"RODateFormatterKey";
    NSMutableDictionary *threadDictionary = [[NSThread currentThread] threadDictionary];
    NSDateFormatter *dateFormatter = [threadDictionary objectForKey:ThreadDictionaryDateFormatterKey];
    if (dateFormatter == nil)
    {
        dateFormatter = [[NSDateFormatter alloc] init];
        [threadDictionary setObject: dateFormatter forKey:ThreadDictionaryDateFormatterKey];
    }
    return dateFormatter;
}

+ (NSCalendar *)gregorianCalendarForCurrentThread
{
	static NSString *ThreadDictionaryGregorianCalendarKey = @"ROGregorianCalendarKey";
    NSMutableDictionary *threadDictionary = [[NSThread currentThread] threadDictionary];
    NSCalendar *calendar = [threadDictionary objectForKey:ThreadDictionaryGregorianCalendarKey];
    if (calendar == nil)
    {
        calendar = [[NSCalendar alloc] initWithCalendarIdentifier:NSGregorianCalendar];
        [threadDictionary setObject:calendar forKey:ThreadDictionaryGregorianCalendarKey];
    }
    return calendar;
}

+(NSDate *)dateFromString:(NSString*)datestring withFormat:(NSString*)formatstring{
    
    NSDateFormatter *df = [[NSDateFormatter alloc]init];
    [df setDateFormat:formatstring];
    return [df dateFromString:datestring];      
}

+(NSDate*)dateFromString:(NSString*)datestring{
    NSDateFormatter *df = [[NSDateFormatter alloc]init];
    
    NSPredicate *sqlDateTimeFormatWithOffsetPredicate = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", @"\\d{4}-\\d{2}-\\d{2}T\\d{2}:\\d{2}:\\d{2}\\s\\+\\d{4}"];
    NSPredicate *sqlDateTimeFormatWithoutOffsetPredicate = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", @"\\d{4}-\\d{2}-\\d{2}T\\d{2}:\\d{2}:\\d{2}"];
    NSPredicate *dateTimeFormatSimpleWackedPredicate = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", @"\\d{1,2}/\\d{1,2}/\\d{4}"];
    NSPredicate *dateTimeFormatSimpleDashedPredicate = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", @"\\d{1,2}-\\d{1,2}-\\d{4}"];
    NSPredicate *dateTimeFormatWithOffsetPredicate = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", @"\\d{4}-\\d{2}-\\d{2} \\d{2}:\\d{2}:\\d{2}\\s\\+\\d{4}"];

    NSString *dateFormatSimpleWacked = @"MM/dd/yyyy";
    NSString *dateFormatSimpleDashed = @"MM-dd-yyyy";

    NSString *sqlDateFormatWithoutOffset = @"yyyy-MM-dd'T'HH:mm:ss";
    NSString *sqlDateFormatWithOffset = @"yyyy-MM-dd'T'HH:mm:ss Z";
    NSString *dateTimeFormatWithOffset = @"yyyy-MM-dd HH:mm:ss Z";
    
    if ([sqlDateTimeFormatWithOffsetPredicate evaluateWithObject:datestring]) {
        [df setDateFormat:sqlDateFormatWithOffset];
        return [df dateFromString:datestring];  
    }
    
    if ([sqlDateTimeFormatWithoutOffsetPredicate evaluateWithObject:datestring]) {
        [df setDateFormat:sqlDateFormatWithoutOffset];
        return [df dateFromString:datestring];  
    }
 
    if ([dateTimeFormatSimpleWackedPredicate evaluateWithObject:datestring]) {
        [df setDateFormat:dateFormatSimpleWacked];
        return [df dateFromString:datestring];  
    }

    if ([dateTimeFormatSimpleDashedPredicate evaluateWithObject:datestring]) {
        [df setDateFormat:dateFormatSimpleDashed];
        return [df dateFromString:datestring];  
    }
    if ([dateTimeFormatWithOffsetPredicate evaluateWithObject:datestring]) {
        [df setDateFormat:dateTimeFormatWithOffset];
        return [df dateFromString:datestring];  
    }   
    return nil;
}

- (NSDate *)midnight
{
	NSInteger componentFlags = NSDayCalendarUnit | NSMonthCalendarUnit | NSYearCalendarUnit;
	NSCalendar *calendar = [NSDate gregorianCalendarForCurrentThread];
	NSDateComponents *dateComponents = [calendar components:componentFlags fromDate:self];
	return [calendar dateFromComponents:dateComponents];
}

- (NSDate *)tomorrow
{
	NSDateComponents *plusOneDay = [[NSDateComponents alloc] init];
	[plusOneDay setDay:1];
	
	NSCalendar *calendar = [NSDate gregorianCalendarForCurrentThread];
	NSDate *tomorrow = [calendar dateByAddingComponents:plusOneDay toDate:self options:NSWrapCalendarComponents];
	
	return [tomorrow midnight];
}

- (NSDate *)yesterday
{
	NSDateComponents *minusOneDay = [[NSDateComponents alloc] init];
	[minusOneDay setDay:-1];
	
	NSCalendar *calendar = [NSDate gregorianCalendarForCurrentThread];
	NSDate *yesterday = [calendar dateByAddingComponents:minusOneDay toDate:self options:NSWrapCalendarComponents];
	
	return [yesterday midnight];
}


- (NSDate *)dateForDaysInFuture:(NSInteger)daysInFuture
{
    int numOfSeconds = daysInFuture * 3600 * 24;
    NSDate *futureDate = [[NSDate alloc] initWithTimeIntervalSinceNow:numOfSeconds];

    return [futureDate midnight];
}

- (NSDate *)dateForDaysInPast:(NSInteger)daysInPast
{
    int numOfSeconds = -daysInPast * 3600 * 24;
    NSDate *pastDate = [[NSDate alloc] initWithTimeIntervalSinceNow:numOfSeconds];
    
    return [pastDate midnight];
}

- (BOOL)isBetweenDate:(NSDate*)startDate andDate:(NSDate*)endDate
{
    return (([self compare:startDate] != NSOrderedAscending) && ([self compare:endDate] != NSOrderedDescending));
}

- (BOOL)isBetweenDateRange:(DateRange*)dateRange{
    
    if (dateRange.isOpenEnded ) {
        return [self compare:dateRange.startDate] != NSOrderedAscending;
    }

    NSDate *endDate = [dateRange valueForKey:@"endDate"];
    return [self isBetweenDate:dateRange.startDate andDate:endDate];
}

- (NSDate*)dateForHoursInFuture:(NSInteger)hoursInFuture{

    int numberOfSeconds = hoursInFuture * 3600;
    NSDate *futureDate = [[NSDate alloc]initWithTimeIntervalSinceNow:numberOfSeconds];
    return futureDate;
}

- (NSDate*)dateForHoursInPast:(NSInteger)hoursInPast{

    int numberOfSeconds = -hoursInPast * 3600;
    NSDate *pastDate = [[NSDate alloc]initWithTimeIntervalSinceNow:numberOfSeconds];
    return pastDate;
}

- (NSDate*)dateForMinutesInFuture:(NSInteger)minutesInFuture{
    
    int numberOfSeconds = minutesInFuture * 60;
    NSDate *futureDate = [[NSDate alloc]initWithTimeIntervalSinceNow:numberOfSeconds];
    return futureDate;
}

- (NSDate*)dateForMinutesInPast:(NSInteger)minutesInPast{
    
    int numberOfSeconds = -minutesInPast * 60;
    NSDate *pastDate = [[NSDate alloc]initWithTimeIntervalSinceNow:numberOfSeconds];
    return pastDate;
}

- (NSDate *) dateByStrippingTimeFromDate
{
    NSCalendar *currentCalendar = [NSCalendar currentCalendar];
    NSDateComponents *dateComponents = [currentCalendar components:NSDayCalendarUnit|NSMonthCalendarUnit|NSYearCalendarUnit 
                                                          fromDate:self];
    
    NSDate *strippedDate = [currentCalendar dateFromComponents:dateComponents];
    
    return strippedDate;
}

- (BOOL)isInFuture{
    
    return [self compare:[NSDate date]] != NSOrderedAscending;;
}

@end
