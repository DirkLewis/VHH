//
//  CoreDataLogger
//  ROMobileUniversal
//
//  Created by Dirk Lewis 11/16/2011
//  Copyright 2011 Optima  All rights reserved.
//

#import <Foundation/Foundation.h>
#import "DDAbstractDatabaseLogger.h"
#import "CoreLoggingProtocols.h"

@interface CoreDataLogger : DDAbstractDatabaseLogger <DDLogger>

/**
 * Initializes an instance set to save it's CocoaBotLog.sqlite file to the given directory.
 * If the directory doesn't already exist, it is automatically created.
**/
- (id)initWithLogDirectory:(NSString *)logDirectory;
- (id)initWithLogDirectory:(NSString *)logDirectory andlogDataManager:(id<CoreLoggingDataManagementProtocol>)logDataManager;
- (void)saveContext;

@end
