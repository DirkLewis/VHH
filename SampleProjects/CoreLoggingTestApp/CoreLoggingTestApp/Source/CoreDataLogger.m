//
//  CoreDataLogger
//  ROMobileUniversal
//
//  Created by Dirk Lewis 11/16/2011
//  Copyright 2011 Optima  All rights reserved.
//
#import "CoreDataLogger.h"
#import "SystemLogRepository.h"
#import "SystemLogEntry.h"

@interface CoreDataLogger ()
- (void)validateLogDirectory;
@end

@implementation CoreDataLogger{
	NSString *logDirectory;

}

- (id)initWithLogDirectory:(NSString *)aLogDirectory
{
	if ((self = [super init]))
	{
		logDirectory = [aLogDirectory copy];
		[self validateLogDirectory];
	}
	return self;
}


#pragma mark - Private Methods

- (void)validateLogDirectory
{
	// Validate log directory exists or create the directory.
	
	BOOL isDirectory;
	if ([[NSFileManager defaultManager] fileExistsAtPath:logDirectory isDirectory:&isDirectory])
	{
		if (!isDirectory)
		{
			
			logDirectory = nil;
		}
	}
	else
	{
		NSError *error = nil;
		
		BOOL result = [[NSFileManager defaultManager] createDirectoryAtPath:logDirectory
		                                        withIntermediateDirectories:YES
		                                                         attributes:nil
		                                                              error:&error];
		if (!result)
		{		
			logDirectory = nil;
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
	NSPredicate *predicate = [NSPredicate predicateWithFormat:@"timestamp < %@", maxDate];
	
	NSUInteger batchSize = (saveThreshold > 0) ? saveThreshold : 500;
	NSUInteger count = 0;
	
	NSFetchRequest *fetchRequest = [SystemLogEntry fetchRequestForAllSystemLogEntries];
	[fetchRequest setFetchBatchSize:batchSize];
	[fetchRequest setPredicate:predicate];
	
	NSArray *oldLogEntries = [[SystemLogRepository sharedSystemLogRepository] resultsForRequest:fetchRequest];
	
	for (SystemLogEntry *logEntry in oldLogEntries)
	{
		[[[SystemLogRepository sharedSystemLogRepository] context] deleteObject:logEntry];
		
		if (++count >= batchSize)
		{
			[self saveContext];
		}
	}
	
	if (shouldSaveWhenDone)
	{
		[self saveContext];
	}
}

#pragma mark - DDLogger

- (BOOL)db_log:(DDLogMessage *)logMessage
{
	    
    SystemLogEntry *logEntry = [[SystemLogRepository sharedSystemLogRepository] insertNewEntityNamed:[SystemLogEntry entityName]];
	
	logEntry.context   = [NSNumber numberWithInt:logMessage->logContext];
	logEntry.level     = [NSNumber numberWithInt:logMessage->logFlag];
	logEntry.message   = logMessage->logMsg;
	logEntry.timestamp = logMessage->timestamp;
	
	
	return YES;
}

- (void)saveContext
{
    [[SystemLogRepository sharedSystemLogRepository] saveWithRollbackOnError];
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
