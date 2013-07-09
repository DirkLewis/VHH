#import "SystemLogEntry.h"
#import "SystemLogRepository.h"

#define AUTH_LOG  1
#define ACCESS_LOG  2
#define DOCUMENT_LOG  3
#define SYSTEM_LOG  4
#define PERFORMANCE_LOG 100

@interface SystemLogEntry ( Private )

+ (NSArray*)fetchArrayOfAllLogEntriesOfType:(NSInteger)logType;
+ (NSFetchRequest*)fetchRequestSystemLogEntry;

@end

@implementation SystemLogEntry

+ (NSFetchRequest *)fetchRequestForAllSystemLogEntries{
    
	NSFetchRequest *fetchRequest = [[SystemLogRepository sharedSystemLogRepository] fetchRequestForEntityNamed:[SystemLogEntry entityName] batchSize:25];
    [fetchRequest setFetchBatchSize:20];
    [fetchRequest setSortDescriptors:[[self class]sortDescriptorsForSystemLogEntries]];
    return fetchRequest;
}

+ (NSNumber*)fetchCountForAllSystemLogEntries{
    
    NSFetchRequest *fetchRequest = [self fetchRequestForAllSystemLogEntries];
    return [NSNumber numberWithInt: [[[SystemLogRepository sharedSystemLogRepository] resultsForRequest:fetchRequest] count]];
}

+ (NSArray*)fetchArrayOfAllLogEntries{
    
    NSFetchRequest *fetchRequest = [self fetchRequestForAllSystemLogEntries];
    return [[SystemLogRepository sharedSystemLogRepository] resultsForRequest:fetchRequest];
}


+ (NSArray *)sortDescriptorsForSystemLogEntries
{
	return [NSArray arrayWithObjects:[[NSSortDescriptor alloc] initWithKey:@"timestamp" ascending:NO],nil];
}

+ (NSFetchRequest*)fetchRequestSystemLogEntry{
    return [[SystemLogRepository sharedSystemLogRepository] fetchRequestForEntityNamed:[SystemLogEntry entityName] batchSize:25];
}


+ (NSArray*)fetchArrayOfAllLogEntriesOfType:(NSInteger)logType {
    
    NSFetchRequest *fetchRequest = [SystemLogEntry fetchRequestSystemLogEntry];
    NSPredicate *contextFilter;
    
    switch (logType) {
        case AUTH_LOG:
            contextFilter = [NSPredicate predicateWithFormat:@"context BETWEEN {0,3}"];
            break;
        case ACCESS_LOG:
            contextFilter = [NSPredicate predicateWithFormat:@"context BETWEEN {4,7}"];
            break;
        case DOCUMENT_LOG:
            contextFilter = [NSPredicate predicateWithFormat:@"context BETWEEN {8,11}"];
            break;
        case SYSTEM_LOG:
            contextFilter = [NSPredicate predicateWithFormat:@"context BETWEEN {12,15}"];
            break;
        case PERFORMANCE_LOG:
            contextFilter = [NSPredicate predicateWithFormat:@"context == 100"];
            break;
        default:
            contextFilter = [[NSPredicate alloc] init];
    }
    
    [fetchRequest setPredicate:contextFilter];
    [fetchRequest setSortDescriptors:[SystemLogEntry sortDescriptorsForSystemLogEntries]];
    
    return [[SystemLogRepository sharedSystemLogRepository] resultsForRequest:fetchRequest];
}

#pragma mark - Fetch Methods

+ (NSArray*)fetchArrayOfAllSystemLogEntries{
    return [SystemLogEntry fetchArrayOfAllLogEntriesOfType:SYSTEM_LOG];
}

+ (NSArray*)fetchArrayOfAllAccessLogEntries{
    return [SystemLogEntry fetchArrayOfAllLogEntriesOfType:ACCESS_LOG];
}

+ (NSArray*)fetchArrayOfAllAuthenticationLogEntries{
    return [SystemLogEntry fetchArrayOfAllLogEntriesOfType:AUTH_LOG];
}

+ (NSArray*)fetchArrayOfAllDocumentLogEntries{
    return [SystemLogEntry fetchArrayOfAllLogEntriesOfType:DOCUMENT_LOG];
}

+ (NSArray*)fetchArrayOfAllPerformanceLogEntries{
    return [SystemLogEntry fetchArrayOfAllLogEntriesOfType:PERFORMANCE_LOG];
}

@end
