//
//  RepositoryFactory.h
//  VHHCoreRepository
//
//  Created by Dirk Lewis on 7/2/13.
//  Copyright (c) 2013 VideoHooHaa. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ProtocolHeaders.h"
@class FileLevelRepository,FieldLevelRepository;
@interface RepositoryFactory : NSObject
+ (FieldLevelRepository*)createFieldLevelRepositoryForModel:(NSString*)modelname toFile:(NSString*)filename fromConfiguration:(NSString*)configuration;
+ (FileLevelRepository*)createFileLevelRepositoryForModel:(NSString*)modelname toFile:(NSString*)filename fromConfiguration:(NSString*)configuration;
+ (id<RepositoryProtocol>)createUnsecuredRepositoryForModel:(NSString*)modelname toFile:(NSString*)filename fromConfiguration:(NSString*)configuration;

@end
