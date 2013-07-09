#import "_SystemLogEntry.h"

@interface SystemLogEntry : _SystemLogEntry {}

+ (NSFetchRequest *)fetchRequestForAllSystemLogEntries;
+ (NSNumber*)fetchCountForAllSystemLogEntries;
+ (NSArray*)fetchArrayOfAllSystemLogEntries;
+ (NSArray*)fetchArrayOfAllAuthenticationLogEntries;
+ (NSArray*)fetchArrayOfAllAccessLogEntries;
+ (NSArray*)fetchArrayOfAllDocumentLogEntries;
+ (NSArray*)fetchArrayOfAllPerformanceLogEntries;
+ (NSArray *)sortDescriptorsForSystemLogEntries;
+ (NSArray*)fetchArrayOfAllLogEntries;
@end
