//
//  SQLiteBackingstore.h
//  CoreDataRepositoryFramework
//
//  Created by Dirk Lewis on 6/18/12.
//  Copyright (c) 2012 Optima HCS. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "BackingstoreProtocol.h"
#import <CoreData/CoreData.h>

@interface SQLiteBackingstore : NSObject <BackingstoreProtocol>

@property (copy,nonatomic,readonly) NSString *modelName;
@property (copy,nonatomic,readonly) NSString *fileName;
@property (copy,nonatomic,readonly) NSString *configName;
@property (nonatomic, strong, readonly) NSManagedObjectModel *managedObjectModel;
@property (nonatomic, strong, readonly) NSManagedObjectContext *managedObjectContext;
@property (nonatomic, strong, readonly) NSPersistentStoreCoordinator *persistentStoreCoordinator;

@end
