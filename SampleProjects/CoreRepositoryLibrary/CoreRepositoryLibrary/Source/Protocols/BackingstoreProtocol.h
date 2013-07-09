//
//  BackingstoreProtocol.h
//  CoreDataRepositoryFramework
//
//  Created by Dirk Lewis on 6/18/12.
//  Copyright (c) 2012 Optima HCS. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>
@protocol BackingstoreProtocol <NSObject>

@required
@property (copy,nonatomic,readonly) NSString *modelName;
@property (copy,nonatomic,readonly) NSString *fileName;
@property (copy,nonatomic,readonly) NSString *configName;
@property (nonatomic, strong, readonly) NSManagedObjectModel *managedObjectModel;
@property (nonatomic, strong, readonly) NSManagedObjectContext *managedObjectContext;
@property (nonatomic, strong, readonly) NSPersistentStoreCoordinator *persistentStoreCoordinator;

- (id)initWithModelName:(NSString*)modelName toFile:(NSString*)fileName fromConfiguration:(NSString*)configuration;
- (BOOL)resetBackingstore;
- (BOOL)closeBackingstore;
- (BOOL)secureAndCloseBackingstore:(NSString*)password;
- (BOOL)openBackingstore;
@end
