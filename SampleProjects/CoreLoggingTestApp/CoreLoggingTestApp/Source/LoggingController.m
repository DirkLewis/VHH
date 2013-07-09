//
//  LoggingFactory.m
//  ROMobileUniversal
//
//  Created by Dirk Lewis on 11/15/11.
//  Copyright (c) 2011 Optima HCS  All rights reserved.
//

#import "LoggingController.h"
#import "LoggingDefinition.h"

@interface LoggingController()
+ (int)createLoggingLevel;
+ (CoreDataLogger*)createCoreDataLogger;
+ (NSString*)createLogMessage:(NSString*)formatString, ...;
@end

@implementation LoggingController

int ddLogLevel;

NSManagedObjectContext *context;
NSMutableDictionary *_performanceLoggingDictionary;


#pragma mark - Initializer

+ (void)initializeLogger{
    
    [LoggingController setLogLevel:[LoggingController createLoggingLevel]];
#if DEBUG
    [DDLog addLogger:[DDTTYLogger sharedInstance]];
    [DDLog addLogger:[DDASLLogger sharedInstance]];
#endif
    //file logging
    DDFileLogger *fileLogger = [[DDFileLogger alloc]init];
    fileLogger.rollingFrequency = 60*60*24;
    fileLogger.logFileManager.maximumNumberOfLogFiles = 7;
    [DDLog addLogger:fileLogger];
    
    //core data loggin
    CoreDataLogger *dataLogger = [LoggingController createCoreDataLogger];
    [DDLog addLogger:dataLogger];
    _performanceLoggingDictionary = [NSMutableDictionary dictionary];
}

+ (void)resetLogLevel{

    [LoggingController setLogLevel:[LoggingController createLoggingLevel]];
}

#pragma mark - Setters

+ (void)setLogLevel:(int)logLevel{
    ddLogLevel = logLevel;
}

+ (int)logLevel{

    return ddLogLevel;
}

+ (void)setPerformanceStartTimeForTag:(NSString*)tag{
    [_performanceLoggingDictionary setObject:[NSDate date] forKey:[NSString stringWithFormat:@"%@-start",tag]];
}

#pragma mark - helpers
+ (NSArray*)logEntryContextArrayForNumber:(NSNumber*)number{

    
    switch ([number intValue]) {
        case klogContextSystemError:
            
            return [NSArray arrayWithObjects:@"System", [NSNumber numberWithInt:ROLogError], nil]; 
            break;
        case klogContextSystemWarning:
            return [NSArray arrayWithObjects:@"System", [NSNumber numberWithInt:ROLogWarning], nil]; 
            break;
        case klogContextSystemInformation:
            return [NSArray arrayWithObjects:@"System", [NSNumber numberWithInt:ROLogInformation], nil];
            break;
        case klogContextSystemVerbose:
            return [NSArray arrayWithObjects:@"System", [NSNumber numberWithInt:ROLogVerbose], nil]; 
            break;
        case klogContextAuthenticationError:
            return [NSArray arrayWithObjects:@"Authorization", [NSNumber numberWithInt:ROLogError], nil]; 
            break;
        case klogContextAuthenticationWarning:
            return [NSArray arrayWithObjects:@"Authorization", [NSNumber numberWithInt:ROLogWarning], nil]; 
            break;
        case klogContextAuthenticationInformation:
            return [NSArray arrayWithObjects:@"Authorization", [NSNumber numberWithInt:ROLogInformation], nil]; 
            break;
        case klogContextAuthenticationVerbose:
            return [NSArray arrayWithObjects:@"Authorization", [NSNumber numberWithInt:ROLogVerbose], nil];
            break;
        case klogContextAccessError:
            return [NSArray arrayWithObjects:@"Access", [NSNumber numberWithInt:ROLogError], nil]; 
            break;
        case klogContextAccessWarning:
            return [NSArray arrayWithObjects:@"Access", [NSNumber numberWithInt:ROLogWarning], nil];
            break;
        case klogContextAccessInformation:
            return [NSArray arrayWithObjects:@"Access", [NSNumber numberWithInt:ROLogInformation], nil]; 
            break;
        case klogContextAccessVerbose:
            return [NSArray arrayWithObjects:@"Access", [NSNumber numberWithInt:ROLogInformation], nil]; 
            break;
        case klogContextDocumentError:
            return [NSArray arrayWithObjects:@"Documentation", [NSNumber numberWithInt:ROLogError], nil];
            break;
        case klogContextDocumentWarning:
            return [NSArray arrayWithObjects:@"Documentation", [NSNumber numberWithInt:ROLogWarning], nil];
            break;
        case klogContextDocumentInformation:
            return [NSArray arrayWithObjects:@"Documentation", [NSNumber numberWithInt:ROLogInformation], nil];
            break;
        case klogContextDocumentVerbose:
            return [NSArray arrayWithObjects:@"Documentation", [NSNumber numberWithInt:ROLogVerbose], nil];
            break;
        case klogContextPerformance:
            return [NSArray arrayWithObjects:@"Performance", [NSNumber numberWithInt:ROLogPerformance], nil];
            break;
        default:
            return nil;
            break;
    }

}

#pragma mark - Fine Grain Loggers

+ (void)logSystemError:(NSString*)formatString, ...{
    NSString *logMsg = [LoggingController createLogMessage:formatString];
    ROLogSystemError(logMsg);
}

+ (void)logSystemWarning:(NSString*)formatString, ...{
    NSString *logMsg = [LoggingController createLogMessage:formatString];
    ROLogSystemWarning(logMsg);
}

+ (void)logSystemInfo:(NSString*)formatString, ...{
    NSString *logMsg = [LoggingController createLogMessage:formatString];
    ROLogSystemInformation(logMsg);
}

+ (void)logSystemVerbose:(NSString*)formatString, ...{
    NSString *logMsg = [LoggingController createLogMessage:formatString];
    ROLogSystemVerbose(logMsg);
}

+ (void)logAuthError:(NSString*)formatString, ...{
    NSString *logMsg = [LoggingController createLogMessage:formatString];
    ROLogAuthError(logMsg);
}

+ (void)logAuthWarning:(NSString*)formatString, ...{
    NSString *logMsg = [LoggingController createLogMessage:formatString];
    ROLogAuthWarning(logMsg);
}

+ (void)logAuthInfo:(NSString*)formatString, ...{
    NSString *logMsg = [LoggingController createLogMessage:formatString];
    ROLogAuthInformation(logMsg);
}

+ (void)logAuthVerbose:(NSString*)formatString, ...{
    NSString *logMsg = [LoggingController createLogMessage:formatString];
    ROLogAuthVerbose(logMsg);
}

+ (void)logAccessError:(NSString*)formatString, ...{
    NSString *logMsg = [LoggingController createLogMessage:formatString];
    ROLogAccessError(logMsg);
}

+ (void)logAccessWarning:(NSString*)formatString, ...{
    NSString *logMsg = [LoggingController createLogMessage:formatString];
    ROLogAccessWarning(logMsg);
}

+ (void)logAccessInfo:(NSString*)formatString, ...{
    NSString *logMsg = [LoggingController createLogMessage:formatString];
    ROLogAccessInformation(logMsg);
}

+ (void)logAccessVerbose:(NSString*)formatString, ...{
    NSString *logMsg = [LoggingController createLogMessage:formatString];
    ROLogAccessVerbose(logMsg);
}

+ (void)logDocumentError:(NSString*)formatString, ...{
    NSString *logMsg = [LoggingController createLogMessage:formatString];
    ROLogDocumentError(logMsg);
}

+ (void)logDocumentWarning:(NSString*)formatString, ...{
    NSString *logMsg = [LoggingController createLogMessage:formatString];
    ROLogDocumentWarning(logMsg);
}

+ (void)logDocumentInfo:(NSString*)formatString, ...{
    NSString *logMsg = [LoggingController createLogMessage:formatString];
    ROLogDocumentInformation(logMsg);
}

+ (void)logDocumentVerbose:(NSString*)formatString, ...{
    NSString *logMsg = [LoggingController createLogMessage:formatString];
    ROLogDocumentVerbose(logMsg);
}

+ (void)logPerformanceForTag:(NSString*)tag fromMethod:(NSString*)method{

    @synchronized(self){
        
    
        NSDate *start = [_performanceLoggingDictionary objectForKey:[NSString stringWithFormat:@"%@-start",tag]];
        NSDate *end = [NSDate date];
        
        NSTimeInterval secondsBetween = [end timeIntervalSinceDate:start];

        //NSString *logMsg = [NSString stringWithFormat:@"%@\nStarted: %@\nEnded: %@\nSeconds: %f", method,start,end,secondsBetween];
        NSString *logMsg = [NSString stringWithFormat:@"%@\nTotal Seconds: %f", method,secondsBetween];
        [_performanceLoggingDictionary removeObjectForKey:[NSString stringWithFormat:@"%@-start",tag]];
        ROLogPerformance(logMsg);

    }

}

#pragma mark - Private methods

+ (NSString*)createLogMessage:(NSString*)formatString, ...{

    @synchronized(self){
        
        if (!formatString) return nil;
        va_list args;
        
        va_start(args, formatString);
        
        NSString *logMsg = [[NSString alloc] initWithFormat:formatString arguments:args];
        va_end(args);
        return logMsg;
    }
}

+ (CoreDataLogger*)createCoreDataLogger{


    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSApplicationSupportDirectory, NSUserDomainMask, YES);
    NSString *basePath = ([paths count] > 0) ? [paths objectAtIndex:0] : NSTemporaryDirectory();
    NSNumber *saveThreshold = [[NSUserDefaults standardUserDefaults] objectForKey:@"loggingsavethreshold"];
    NSNumber *saveInterval = [[NSUserDefaults standardUserDefaults] objectForKey:@"loggingsaveinterval"];
    NSNumber *maxAge = [[NSUserDefaults standardUserDefaults] objectForKey:@"loggingmaxage"];
    NSNumber *deleteInterval = [[NSUserDefaults standardUserDefaults] objectForKey:@"loggingdeleteinterval"];
    NSNumber *deleteOnEverySave = [[NSUserDefaults standardUserDefaults] objectForKey:@"loggingdeleteeverysave"];
    
    if (!saveThreshold) {
#if DEBUG
        saveThreshold = @0;//[dictionary valueForKey:@"loggingsavethreshold"];
#else
        saveThreshold = @100;//[NSNumber numberWithInt:100];
#endif     
        [[NSUserDefaults standardUserDefaults] setValue:saveThreshold forKey:@"loggingsavethreshold"];

    }
    
    if (!saveInterval) {
#if DEBUG
        saveInterval = @15;//[dictionary valueForKey:@"loggingsaveinterval"];
#else
        saveInterval = @60;//[NSNumber numberWithInt:60];
#endif
        [[NSUserDefaults standardUserDefaults] setValue:saveInterval forKey:@"loggingsaveinterval"];
         
    }
    
    if (!maxAge) {
        maxAge = [NSNumber numberWithInt:7];
        [[NSUserDefaults standardUserDefaults] setValue:maxAge forKey:@"loggingmaxage"];

    }
    
    if (!deleteInterval) {
        deleteInterval = [NSNumber numberWithInt:300];
        [[NSUserDefaults standardUserDefaults] setValue:deleteInterval forKey:@"loggingdeleteinterval"];

    }
    
    if (!deleteOnEverySave) {
        deleteOnEverySave = [NSNumber numberWithBool:NO];
        [[NSUserDefaults standardUserDefaults] setValue:deleteOnEverySave forKey:@"loggingdeleteeverysave"];

    }
    
    CoreDataLogger *coreDataLogger = [[CoreDataLogger alloc] initWithLogDirectory:[basePath stringByAppendingPathComponent:@"CoreDataLogger"]];
	coreDataLogger.saveThreshold     = [saveThreshold intValue];
	coreDataLogger.saveInterval      = [saveInterval intValue];             // 60 seconds
	coreDataLogger.maxAge            = 60 * 60 * 24 * [maxAge floatValue];    // 7 days
	coreDataLogger.deleteInterval    = [deleteInterval intValue];      // 5 minutes
	coreDataLogger.deleteOnEverySave = [deleteOnEverySave boolValue];
    
    [[NSUserDefaults standardUserDefaults]synchronize];
    return coreDataLogger;
}

+ (int)createLoggingLevel{

    int logLevel = LOG_LEVEL_OFF | LOG_LEVEL_AUTH_OFF | LOG_LEVEL_DOCUMENT_OFF | LOG_LEVEL_ACCESS_OFF;
    
    if (![[NSUserDefaults standardUserDefaults] objectForKey:@"enablelogging"]) {
        
        [[NSUserDefaults standardUserDefaults] setValue:[NSNumber numberWithBool:YES] forKey:@"enablelogging"];
    }
    else if (![[NSUserDefaults standardUserDefaults] boolForKey:@"enablelogging"] ) {
        return logLevel;
    }
    
    NSNumber *authLogLevel = [[NSUserDefaults standardUserDefaults] objectForKey:@"authloglevel"];
    NSNumber *accessLogLevel = [[NSUserDefaults standardUserDefaults] objectForKey:@"accessloglevel"];
    NSNumber *docLogLevel = [[NSUserDefaults standardUserDefaults] objectForKey:@"docloglevel"];
    NSNumber *sysLogLevel = [[NSUserDefaults standardUserDefaults] objectForKey:@"systemloglevel"];

        
    if (!authLogLevel) {
#if DEBUG
        authLogLevel = @240;
#else
        authLogLevel = @16;
#endif
        [[NSUserDefaults standardUserDefaults] setValue:authLogLevel forKey:@"authloglevel"];
    }
    
    if (!docLogLevel) {
#if DEBUG
        docLogLevel = @3840;
#else
        docLogLevel = @256;
#endif
        [[NSUserDefaults standardUserDefaults] setValue:docLogLevel forKey:@"docloglevel"];
    }
    
    if (!accessLogLevel) {
#if DEBUG
        accessLogLevel = @61440;
#else
        accessLogLevel = @4096;
#endif
        [[NSUserDefaults standardUserDefaults] setValue:accessLogLevel forKey:@"accessloglevel"];
    }
    
    if (!sysLogLevel) {
#if DEBUG
        sysLogLevel = @1966080;
#else
        sysLogLevel = @131072;
#endif        
        [[NSUserDefaults standardUserDefaults] setValue:sysLogLevel forKey:@"systemloglevel"];
    }
    
    logLevel = ([authLogLevel intValue] | [docLogLevel intValue] | [accessLogLevel intValue] | [sysLogLevel intValue]);
    
    if([[NSUserDefaults standardUserDefaults] boolForKey:@"enableperformancelogging"]){
        logLevel = (logLevel | LOG_LEVEL_PERFORMANCE_ON);
    }
   
    return logLevel;

}

@end
