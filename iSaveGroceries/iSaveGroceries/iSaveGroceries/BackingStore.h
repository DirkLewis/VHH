//
//  BackingStore.h
//  ROMobileUniversal
//
//  Created by Dirk Lewis on 12/9/11.
//  Copyright Video Hoo Haa. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@interface BackingStore : NSObject

@property (nonatomic, strong, readonly) NSString *modelName;
@property (nonatomic, strong, readonly) NSString *fileName;
@property (nonatomic, strong, readonly) NSString *configName;


@property (nonatomic, strong, readonly) NSManagedObjectModel *managedObjectModel;
@property (nonatomic, strong, readonly) NSManagedObjectContext *managedObjectContext;
@property (nonatomic, strong, readonly) NSPersistentStoreCoordinator *persistentStoreCoordinator;

- (id)initWithModelName:(NSString*)modelName toFile:(NSString*)fileName fromConfiguration:(NSString*)configuration;

- (BOOL)resetBackingstore;
@end
