//
//  SQLiteBackingstore.m
//  VHHCoreRepository
//
//  Created by Dirk Lewis on 7/2/13.
//  Copyright (c) 2013 VideoHooHaa. All rights reserved.
//

#import "SQLiteBackingstore.h"

@interface SQLiteBackingstore()

@property (copy,nonatomic,readwrite) NSString *modelName;
@property (copy,nonatomic,readwrite) NSString *fileName;
@property (copy,nonatomic,readwrite) NSString *configName;
@property (nonatomic,strong,readwrite) NSManagedObjectModel *managedObjectModel;
@property (nonatomic,strong,readwrite) NSManagedObjectContext *managedObjectContext;
@property (nonatomic,strong,readwrite) NSPersistentStoreCoordinator *persistentStoreCoordinator;
@property (nonatomic,strong,readwrite)NSMutableArray *errorArray;

- (BOOL)resetPersistentStoreCoordiator:(BOOL)deleteStore;
- (BOOL)datastoreMigrationRequired:(NSURL*)datastoreURL;
- (BOOL)createDocumentDirectoryForSaving;

@end

@implementation SQLiteBackingstore{
    
}

- (instancetype)init
{
    [NSException raise:@"Please use default initializer initWithModelName:toFile:fromConfiguration" format:@""];
    return nil;
}

#pragma mark - Backingstore Protocol
- (instancetype)initWithModelName:(NSString*)modelName toFile:(NSString*)fileName fromConfiguration:(NSString*)configuration{
    
    self = [super init];
    if (self) {
        _modelName = modelName;
        _fileName = fileName;
        _configName = configuration;
        _errorArray = [NSMutableArray array];
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
        _managedObjectContext = nil;
        self.errorArray = nil;
        [self managedObjectContext];
    }
    else {
        return NO;
    }
    
    return YES;
}

- (BOOL)DeleteBackingStore{
    if ([self resetPersistentStoreCoordiator:YES]) {
        _managedObjectContext = nil;
        self.errorArray = nil;
    }
    else {
        return NO;
    }
    
    return YES;
}

- (BOOL)closeBackingstore{
    
    if ([self resetPersistentStoreCoordiator:NO]) {
        _managedObjectContext = nil;
        self.errorArray = nil;
    }
    else {
        return NO;
    }
    
    return YES;
}

- (BOOL)persistantStoreFileExistsByName:(NSString*)storeName{

    NSError *error = nil;
    NSString *path = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES)[0];
    
    NSArray *files = [[NSFileManager defaultManager] contentsOfDirectoryAtPath:path error:&error];
    
    for (NSString *file in files) {
        if ([file isEqualToString:storeName]) {
            return YES;
        }
    }
  

    return NO;
}

#pragma mark - Private Mehtods

- (BOOL)resetPersistentStoreCoordiator:(BOOL)deleteStore{
    
    NSArray *stores = [self.persistentStoreCoordinator persistentStores];
    NSError *error = nil;
    for (NSPersistentStore *store in stores) {
        [self.persistentStoreCoordinator removePersistentStore:store error:&error];
        
        if (deleteStore) {
            
            [[NSFileManager defaultManager] removeItemAtPath:[NSString stringWithFormat:@"%@%@",store.URL.path,@"-wal"] error:&error];
            [[NSFileManager defaultManager] removeItemAtPath:[NSString stringWithFormat:@"%@%@",store.URL.path,@"-shm"] error:&error];
            [[NSFileManager defaultManager] removeItemAtPath:store.URL.path error:&error];
        }
    }
    
    _persistentStoreCoordinator = nil;
    
    if (error) {
        [self.errorArray addObject:error];
        return NO;
    }
    
    return YES;
}

- (BOOL)datastoreMigrationRequired:(NSURL*)datastoreURL{
    
    NSError *error = nil;
    NSDictionary *sourceMetaData = [NSPersistentStoreCoordinator metadataForPersistentStoreOfType:NSSQLiteStoreType URL:datastoreURL error:&error];
    
    if (error) {
        //TODO: add a way to send out important failure notificatons
        [self.errorArray addObject:error];
    }
    
    NSManagedObjectModel *destination = [_persistentStoreCoordinator managedObjectModel];
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
                [self.errorArray addObject:error];
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
    
    if (_managedObjectContext) {
        return _managedObjectContext;
    }
    
    NSPersistentStoreCoordinator *coordinator = [self persistentStoreCoordinator];
    if (coordinator) {
        _managedObjectContext = [[NSManagedObjectContext alloc]init];
        [_managedObjectContext setPersistentStoreCoordinator:coordinator];
    }
    
    return _managedObjectContext;
}

- (NSManagedObjectModel*)managedObjectModel{
    
    if (_managedObjectModel) {
        return _managedObjectModel;
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
    
    _managedObjectModel = [NSManagedObjectModel modelByMergingModels:models];
    return _managedObjectModel;
}

- (NSPersistentStoreCoordinator*)persistentStoreCoordinator{
    
    if (_persistentStoreCoordinator) {
        return _persistentStoreCoordinator;
    }
    
    NSError *error = nil;
    
    _persistentStoreCoordinator = [[NSPersistentStoreCoordinator alloc]initWithManagedObjectModel:[self managedObjectModel]];
    
    if ([self createDocumentDirectoryForSaving]) {
        
        NSURL *storeURL = [[[[NSFileManager defaultManager] URLsForDirectory:NSDocumentDirectory inDomains:NSUserDomainMask] lastObject] URLByAppendingPathComponent:self.fileName];
        NSDictionary *options = [NSDictionary dictionaryWithObjectsAndKeys: [NSNumber numberWithBool:YES], NSMigratePersistentStoresAutomaticallyOption,[NSNumber numberWithBool:YES], NSInferMappingModelAutomaticallyOption, nil];
        
        if ([self datastoreMigrationRequired:storeURL]) {
            NSLog(@"migration required");
        }
        
        if (![_persistentStoreCoordinator addPersistentStoreWithType:NSSQLiteStoreType configuration:self.configName URL:storeURL options:options error:&error])
        {
            [self.errorArray addObject:error];
            NSLog(@"Unresolved error %@, %@", error, [error userInfo]);
            abort();
        }
    }
    
    return _persistentStoreCoordinator;
}

#pragma mark - Misc
- (NSString*)description{
    
    return [NSString stringWithFormat:@"\nModel:%@\nFile:%@\nConfig:%@",self.modelName,self.fileName,self.configName];
}
@end
