//
//  LoggingFactory.h
//  ROMobileUniversal
//
//  Created by Dirk Lewis on 11/15/11.
//  Copyright (c) 2011 Optima HCS  All rights reserved.
//

#import <Foundation/Foundation.h>
#pragma mark - Logging enum

typedef enum{
    
    ROLogError = 0,
    ROLogWarning = 1,
    ROLogInformation = 2,
    ROLogVerbose = 3,
    ROLogPerformance = 4
    
} LoggingLevels;

@class CoreDataLogger;
@class NSManagedObjectContext;

@interface LoggingController : NSObject

+ (void)initializeLogger;
+ (void)resetLogLevel;
+ (void)setLogLevel:(int)logLevel;
+ (int)logLevel;

+ (void)logAuthError:(NSString*)formatString, ...;
+ (void)logAuthWarning:(NSString*)formatString, ...;
+ (void)logAuthInfo:(NSString*)formatString, ...;
+ (void)logAuthVerbose:(NSString*)formatString, ...;

+ (void)logAccessError:(NSString*)formatString, ...;
+ (void)logAccessWarning:(NSString*)formatString, ...;
+ (void)logAccessInfo:(NSString*)formatString, ...;
+ (void)logAccessVerbose:(NSString*)formatString, ...;

+ (void)logDocumentError:(NSString*)formatString, ...;
+ (void)logDocumentWarning:(NSString*)formatString, ...;
+ (void)logDocumentInfo:(NSString*)formatString, ...;
+ (void)logDocumentVerbose:(NSString*)formatString, ...;

+ (void)logSystemError:(NSString*)formatString, ...;
+ (void)logSystemWarning:(NSString*)formatString, ...;
+ (void)logSystemInfo:(NSString*)formatString, ...;
+ (void)logSystemVerbose:(NSString*)formatString, ...;

+ (void)logPerformanceForTag:(NSString*)tag fromMethod:(NSString*)method;

+ (void)setPerformanceStartTimeForTag:(NSString*)tag;

+ (NSArray*)logEntryContextArrayForNumber:(NSNumber*)number;



@end
