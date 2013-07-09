 //
//  SQLiteBackingstore.m
//  CoreDataRepositoryFramework
//
//  Created by Dirk Lewis on 6/18/12.
//  Copyright (c) 2012 Optima HCS. All rights reserved.
//

#import "SQLiteBackingstore.h"
@interface SQLiteBackingstore()

- (BOOL)resetPersistentStoreCoordiator:(BOOL)deleteStore;
- (BOOL)datastoreMigrationRequired:(NSURL*)datastoreURL;
- (BOOL)createDocumentDirectoryForSaving;
@end


@implementation SQLiteBackingstore{

    
}

@synthesize modelName = _modelName;
@synthesize fileName = _fileName; 
@synthesize configName = _configName;
@synthesize managedObjectModel = __managedObjectModel;
@synthesize managedObjectContext = __managedObjectContext; 
@synthesize persistentStoreCoordinator = __persistentStoreCoordinator;

- (id)init
{
    [NSException raise:@"Please use default initializer initWithModelName:toFile:fromConfiguration" format:@""];
    return nil;
}

#pragma mark - Backingstore Protocol
- (id)initWithModelName:(NSString*)modelName toFile:(NSString*)fileName fromConfiguration:(NSString*)configuration{

    self = [super init];
    if (self) {
        _modelName = modelName;
        _fileName = fileName;
        _configName = configuration;
    }
    return self;
}

- (BOOL)openBackingstore{

    if ([self managedObjectContext]) {
        return YES;
    }
    
    return NO;
}

- (BOOL)resetBackingstore{
    
    if ([self resetPersistentStoreCoordiator:YES]) {
        __managedObjectContext = nil;
        [self managedObjectContext];
    }
    else {
        return NO;
    }
    
    return YES;
}
- (BOOL)closeBackingstore{
    
    if ([self resetPersistentStoreCoordiator:NO]) {
        __managedObjectContext = nil;
    }
    else {
        return NO;
    }
    
    return YES;
}

- (BOOL)secureAndCloseBackingstore:(NSString*)password{
    return NO;
}

#pragma mark - Private Mehtods
- (BOOL)resetPersistentStoreCoordiator:(BOOL)deleteStore{

    NSArray *stores = [self.persistentStoreCoordinator persistentStores];
    NSError *error = nil;
    for (NSPersistentStore *store in stores) {
        [self.persistentStoreCoordinator removePersistentStore:store error:&error];
        
        if (deleteStore) {
            [[NSFileManager defaultManager] removeItemAtURL:store.URL error:&error];
        }
    }
    
    __persistentStoreCoordinator = nil;
    
    if (error) {
        return NO;
    }
    
    return YES;
}

- (BOOL)datastoreMigrationRequired:(NSURL*)datastoreURL{
    
    NSError *error = nil;
    NSDictionary *sourceMetaData = [NSPersistentStoreCoordinator metadataForPersistentStoreOfType:NSSQLiteStoreType URL:datastoreURL error:&error];                
    NSManagedObjectModel *destination = [__persistentStoreCoordinator managedObjectModel];
    BOOL isModelCompatibile = [destination isConfiguration:nil compatibleWithStoreMetadata:sourceMetaData];
    
    if (!sourceMetaData) {
        return NO;
    }
    if (isModelCompatibile) {
        return NO;
    }
    return  YES;
}

- (BOOL)createDocumentDirectoryForSaving{

    BOOL isDirectory;
    
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    
    if ([paths count] == 1) {
        
        NSFileManager *fileManager = [[NSFileManager alloc] init];
        
        if (!([fileManager fileExistsAtPath:[paths objectAtIndex:0] isDirectory:&isDirectory] && isDirectory)) {
            
            NSError *error = nil;
            
            [[NSFileManager defaultManager] createDirectoryAtPath:[paths objectAtIndex:0] withIntermediateDirectories:YES attributes:nil error:&error];
            
            if (error) {
                return NO;
            }
            else{
                // directory exists for saving
                return YES;
            }
        }
        else{
            
            //directory exists for saving
            return YES;
            
        }
    }
    
    return NO;   

}

#pragma mark - Coredata Stack
- (NSManagedObjectContext*)managedObjectContext{

    if (__managedObjectContext) {
        return __managedObjectContext;
    }
    
    NSPersistentStoreCoordinator *coordinator = [self persistentStoreCoordinator];
    if (coordinator) {
        __managedObjectContext = [[NSManagedObjectContext alloc]init];
        [__managedObjectContext setPersistentStoreCoordinator:coordinator];
    }
    
    return __managedObjectContext;
}

- (NSManagedObjectModel*)managedObjectModel{

    if (__managedObjectModel) {
        return __managedObjectModel;
    }

    NSMutableArray *models = [NSMutableArray array];

    for (NSBundle *bundle in [NSBundle allBundles]) {
        NSArray *modelPaths = [bundle pathsForResourcesOfType:@"momd" inDirectory:nil];
        
        for (NSString *modelPath in modelPaths) {
            NSURL *momURL = [NSURL fileURLWithPath:modelPath];
            NSString *path = [NSString stringWithFormat:@"%@.momd",self.modelName];
            int count = [[[momURL pathComponents] filteredArrayUsingPredicate:[NSPredicate predicateWithFormat:@"SELF contains[c] %@",path]]count];
            if (count > 0) {
                NSManagedObjectModel *model = [[NSManagedObjectModel alloc]initWithContentsOfURL:momURL];
                if (models) {
                    [models addObject:model];
                }
            }
        }
    }
 
    __managedObjectModel = [NSManagedObjectModel modelByMergingModels:models];
    return __managedObjectModel;
}

- (NSPersistentStoreCoordinator*)persistentStoreCoordinator{

    if (__persistentStoreCoordinator) {
        return __persistentStoreCoordinator;
    }
    
    NSError *error = nil;
    
    __persistentStoreCoordinator = [[NSPersistentStoreCoordinator alloc]initWithManagedObjectModel:[self managedObjectModel]];
    
    if ([self createDocumentDirectoryForSaving]) {
        
        NSURL *storeURL = [[[[NSFileManager defaultManager] URLsForDirectory:NSDocumentDirectory inDomains:NSUserDomainMask] lastObject] URLByAppendingPathComponent:self.fileName];
        NSDictionary *options = [NSDictionary dictionaryWithObjectsAndKeys: [NSNumber numberWithBool:YES], NSMigratePersistentStoresAutomaticallyOption,[NSNumber numberWithBool:YES], NSInferMappingModelAutomaticallyOption, nil];
        
        if ([self datastoreMigrationRequired:storeURL]) {
            NSLog(@"migration required");
        }
        
        if (![__persistentStoreCoordinator addPersistentStoreWithType:NSSQLiteStoreType configuration:self.configName URL:storeURL options:options error:&error])
        {
            NSLog(@"Unresolved error %@, %@", error, [error userInfo]);
            abort();
        }    
    }
    
    return __persistentStoreCoordinator;
}

#pragma mark - Misc
- (NSString*)description{

    return [NSString stringWithFormat:@"\nModel:%@\nFile:%@\nConfig:%@",self.modelName,self.fileName,self.configName];
}


@end
