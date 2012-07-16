//
//  BackingStore.m
//  ROMobileUniversal
//
//  Created by Dirk Lewis on 12/9/11.
//  Copyright Video Hoo Haa. All rights reserved.
//

#import "BackingStore.h"
#import "FileUtilities.h"
@interface BackingStore ( Private )

- (NSURL *)applicationDocumentsDirectory;

@end

@implementation BackingStore

@synthesize modelName = _modelName;
@synthesize fileName = _fileName;
@synthesize configName = _configName;

@synthesize managedObjectModel = __managedObjectModel;
@synthesize managedObjectContext = __managedObjectContext;
@synthesize persistentStoreCoordinator = __persistentStoreCoordinator;

- (id)initWithModelName:(NSString*)modelName toFile:(NSString*)fileName fromConfiguration:(NSString*)configuration{
    
    self = [super init];
    if (self) {
        _modelName = modelName;
        _fileName = fileName;
        _configName = configuration;
    }
    return self;
    
}

- (void)saveContext
{
    NSError *error = nil;
    NSManagedObjectContext *managedObjectContext = self.managedObjectContext;
    if (managedObjectContext != nil)
    {
        if ([managedObjectContext hasChanges] && ![managedObjectContext save:&error])
        {
            /*
             Replace this implementation with code to handle the error appropriately.
             
             abort() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development. 
             */
            NSLog(@"Unresolved error %@, %@", error, [error userInfo]);
            abort();
        } 
    }
}

#pragma mark - Core Data stack

/**
 Returns the managed object context for the application.
 If the context doesn't already exist, it is created and bound to the persistent store coordinator for the application.
 */
- (NSManagedObjectContext *)managedObjectContext
{
    if (__managedObjectContext != nil)
    {
        return __managedObjectContext;
    }
    
    NSPersistentStoreCoordinator *coordinator = [self persistentStoreCoordinator];
    if (coordinator != nil)
    {
        __managedObjectContext = [[NSManagedObjectContext alloc] init];
        [__managedObjectContext setPersistentStoreCoordinator:coordinator];
    }
    return __managedObjectContext;
}

/**
 Returns the managed object model for the application.
 If the model doesn't already exist, it is created from the application's model.
 */
- (NSManagedObjectModel *)managedObjectModel
{
    if (__managedObjectModel != nil)
    {
        return __managedObjectModel;
    }
    
    NSMutableArray *models = [NSMutableArray array];
	for(NSBundle *bundle in [NSBundle allBundles])
	{
		NSArray *modelPaths = [bundle pathsForResourcesOfType:@"momd" inDirectory:nil];
		for(NSString *modelPath in modelPaths)
		{
			NSURL *momURL = [NSURL fileURLWithPath:modelPath];
            
            NSString *path = [NSString stringWithFormat:@"%@.momd",self.modelName];
            int count = [[[momURL pathComponents] filteredArrayUsingPredicate:[NSPredicate predicateWithFormat:@"SELF contains[c] %@",path]]count];
            
            if (count > 0) {
                NSManagedObjectModel *model = [[NSManagedObjectModel alloc] initWithContentsOfURL:momURL];
                if(model != nil) {
                    [models addObject:model];
                }
            }
		}
	}
    
    __managedObjectModel = [NSManagedObjectModel modelByMergingModels:models];
    return __managedObjectModel;
}

/**
 Returns the persistent store coordinator for the application.
 If the coordinator doesn't already exist, it is created and the application's store added to it.
 */
- (NSPersistentStoreCoordinator *)persistentStoreCoordinator
{
    if (__persistentStoreCoordinator != nil)
    {
        return __persistentStoreCoordinator;
    }

    [FileUtilities validateAndOrCreateDocumentDirectoryForSaving];
    NSURL *storeURL = [[self applicationDocumentsDirectory] URLByAppendingPathComponent:self.fileName];
    
    
    NSError *error = nil;
    __persistentStoreCoordinator = [[NSPersistentStoreCoordinator alloc] initWithManagedObjectModel:[self managedObjectModel]];
    if (![__persistentStoreCoordinator addPersistentStoreWithType:NSSQLiteStoreType configuration:self.configName URL:storeURL options:nil error:&error])
    {
        /*
         Replace this implementation with code to handle the error appropriately.
         
         abort() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development. 
         
         Typical reasons for an error here include:
         * The persistent store is not accessible;
         * The schema for the persistent store is incompatible with current managed object model.
         Check the error message to determine what the actual problem was.
         
         
         If the persistent store is not accessible, there is typically something wrong with the file path. Often, a file URL is pointing into the application's resources directory instead of a writeable directory.
         
         If you encounter schema incompatibility errors during development, you can reduce their frequency by:
         * Simply deleting the existing store:
         [[NSFileManager defaultManager] removeItemAtURL:storeURL error:nil]
         
         * Performing automatic lightweight migration by passing the following dictionary as the options parameter: 
         [NSDictionary dictionaryWithObjectsAndKeys:[NSNumber numberWithBool:YES], NSMigratePersistentStoresAutomaticallyOption, [NSNumber numberWithBool:YES], NSInferMappingModelAutomaticallyOption, nil];
         
         Lightweight migration will only work for a limited set of schema changes; consult "Core Data Model Versioning and Data Migration Programming Guide" for details.
         
         */
        NSLog(@"Unresolved error %@, %@", error, [error userInfo]);
        abort();
    }    
    
    return __persistentStoreCoordinator;
}

#pragma mark - Application's Documents directory

/**
 Returns the URL to the application's Documents directory.
 */
- (NSURL *)applicationDocumentsDirectory
{
    return [[[NSFileManager defaultManager] URLsForDirectory:NSDocumentDirectory inDomains:NSUserDomainMask] lastObject];
}

#pragma mark - Clean up
- (BOOL)resetBackingstore{
    
    NSArray *stores = [self.persistentStoreCoordinator persistentStores];
    for (NSPersistentStore *store in stores) {
        [self.persistentStoreCoordinator removePersistentStore:store error:nil];
        [[NSFileManager defaultManager] removeItemAtURL:store.URL error:nil];
    }

    __managedObjectContext = nil;
    __persistentStoreCoordinator = nil;
    [self managedObjectContext];
    return YES;
    
}
@end
