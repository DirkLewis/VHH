//
//  BackingStoreProtocol.h
//  VHHCoreRepository
//
//  Created by Dirk Lewis on 7/2/13.
//  Copyright (c) 2013 VideoHooHaa. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol BackingstoreProtocol <NSObject>

@required
@property (copy,nonatomic,readonly) NSString *modelName;
@property (copy,nonatomic,readonly) NSString *fileName;
@property (copy,nonatomic,readonly) NSString *configName;
@property (nonatomic,strong,readonly) NSManagedObjectModel *managedObjectModel;
@property (nonatomic,strong,readonly) NSManagedObjectContext *managedObjectContext;
@property (nonatomic,strong,readonly) NSPersistentStoreCoordinator *persistentStoreCoordinator;
@property (nonatomic,strong,readonly) NSMutableArray *errorArray;

- (instancetype)initWithModelName:(NSString*)modelName toFile:(NSString*)fileName fromConfiguration:(NSString*)configuration;
- (BOOL)resetBackingstore;
- (BOOL)closeBackingstore;
- (BOOL)openBackingstore;
- (BOOL)DeleteBackingStore;
- (BOOL)persistantStoreFileExistsByName:(NSString*)storeName;

@end
