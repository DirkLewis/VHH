//
//  NSDate+ROAdditions.h
//  RehabOptimaMobile
//
//  Created by Dirk Lewis on 11/16/11.
//  Copyright 2011 Optima HCS  All rights reserved.
//

#import <Foundation/Foundation.h>
@class DateRange;
@interface NSDate (ROAdditions)

/** Thread-safe instance of NSDateFormatter. Must be configured for each use. */
+ (NSDateFormatter *)dateFormatterForCurrentThread;

/** Thread-safe instance of NSCalendar representing the current Gregorian calendar. */
+ (NSCalendar *)gregorianCalendarForCurrentThread;

/** The value of this date at previous or current midnight. */
- (NSDate *)midnight;

/** The date at tomorrow midnight, relative to this date. */
- (NSDate *)tomorrow;

/** Yesterday at midnight, relative to this date. */
- (NSDate *)yesterday; 

/** The value of the date x days in future */
- (NSDate *)dateForDaysInFuture:(NSInteger)daysInFuture;

/** The value of the date x days in past */
- (NSDate *)dateForDaysInPast:(NSInteger)daysInPast;

/** determines if date is between dates x and y */
- (BOOL)isBetweenDate:(NSDate*)startDate andDate:(NSDate*)endDate;
- (BOOL)isBetweenDateRange:(DateRange*)dateRange;

- (NSDate*)dateForHoursInFuture:(NSInteger)hoursInFuture;

- (NSDate*)dateForHoursInPast:(NSInteger)hoursInPast;

- (NSDate*)dateForMinutesInFuture:(NSInteger)minutesInFuture;
- (NSDate*)dateForMinutesInPast:(NSInteger)minutesInPast;
+ (NSDate*)dateFromString:(NSString*)dateString withFormat:(NSString*)formatString;
- (NSDate*)dateByStrippingTimeFromDate;
+ (NSDate*)dateFromString:(NSString*)datestring;
- (BOOL)isInFuture;
- (NSDate*)dateWithSecondsStrippedFromTime:(NSDate*)date;
@end
