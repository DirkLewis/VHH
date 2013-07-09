//
//  RepositoryFactory.h
//  CoreDataRepositoryFramework
//
//  Created by Dirk Lewis on 7/19/12.
//  Copyright (c) 2012 Optima HCS. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "RepositoryProtocols.h"
@class FileLevelRepository;
@class FieldLevelRepository;

@interface RepositoryFactory : NSObject
+ (FieldLevelRepository*)createFieldLevelRepositoryForModel:(NSString*)modelname toFile:(NSString*)filename fromConfiguration:(NSString*)configuration;
+ (FileLevelRepository*)createFileLevelRepositoryForModel:(NSString*)modelname toFile:(NSString*)filename fromConfiguration:(NSString*)configuration;
+ (id<RepositoryProtocol>)createUnsecuredRepositoryForModel:(NSString*)modelname toFile:(NSString*)filename fromConfiguration:(NSString*)configuration;

@end
