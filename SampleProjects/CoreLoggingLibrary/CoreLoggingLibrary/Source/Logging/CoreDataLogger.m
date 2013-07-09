//
//  CoreDataLogger
//  ROMobileUniversal
//
//  Created by Dirk Lewis 11/16/2011
//  Copyright 2011 Optima  All rights reserved.
//
#import "CoreDataLogger.h"
#import "CoreLoggingProtocols.h"

@interface CoreDataLogger ()

@property (nonatomic,strong) id<CoreLoggingDataManagementProtocol> logDataManager;
@property (nonatomic,copy) NSString *logDirectory;

- (void)validateLogDirectory;
@end

@implementation CoreDataLogger{

}

- (id)initWithLogDirectory:(NSString *)logDirectory andlogDataManager:(id<CoreLoggingDataManagementProtocol>)logDataManager
{
	if ((self = [super init]))
	{
		_logDirectory = logDirectory;
        _logDataManager = logDataManager;
		[self validateLogDirectory];
	}
	return self;
}

- (id)initWithLogDirectory:(NSString *)logDirectory
{
    return [self initWithLogDirectory:logDirectory andlogDataManager:nil];
}


#pragma mark - Private Methods

- (void)validateLogDirectory
{
	// Validate log directory exists or create the directory.
	
	BOOL isDirectory;
	if ([[NSFileManager defaultManager] fileExistsAtPath:self.logDirectory isDirectory:&isDirectory])
	{
		if (!isDirectory)
		{
			
			self.logDirectory = nil;
		}
	}
	else
	{
		NSError *error = nil;
		
		BOOL result = [[NSFileManager defaultManager] createDirectoryAtPath:self.logDirectory
		                                        withIntermediateDirectories:YES
		                                                         attributes:nil
		                                                              error:&error];
		if (!result)
		{		
			self.logDirectory = nil;
		}
	}
}

#pragma mark - Public Methods

- (void)deleteOldLogEntries:(BOOL)shouldSaveWhenDone
{
	if (maxAge <= 0.0)
	{
		// Deleting old log entries is disabled.
		// The superclass won't likely call us if this is the case, but we're being cautious.
		return;
	}
	
	NSDate *maxDate = [NSDate dateWithTimeIntervalSinceNow:(-1.0 * maxAge)];
    [self.logDataManager deleteMessagesOlderThan:maxDate];
	
	if (shouldSaveWhenDone)
	{
		[self saveContext];
	}
}

#pragma mark - DDLogger

- (BOOL)db_log:(DDLogMessage *)logMessage
{
    [self.logDataManager messageToLog:logMessage->logMsg messageContext:[NSNumber numberWithInt:logMessage->logContext] logLevel:[NSNumber numberWithInt:logMessage->logFlag] timeStamp:logMessage->timestamp];	
	return YES;
}

- (void)saveContext
{
    [self.logDataManager save];
}

- (void)db_save
{
	[self saveContext];
}

- (void)db_delete
{
	[self deleteOldLogEntries:YES];
}

- (void)db_saveAndDelete
{
	[self deleteOldLogEntries:NO];
	[self saveContext];
}

@end
