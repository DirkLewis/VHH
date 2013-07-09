//
//  RepositoryFactory.m
//  VHHCoreRepository
//
//  Created by Dirk Lewis on 7/2/13.
//  Copyright (c) 2013 VideoHooHaa. All rights reserved.
//

#import "RepositoryFactory.h"
#import "Repository.h"
#import "FieldLevelSecurityRepository.h"
#import "BackingstoreProtocol.h"
#import "SQLiteBackingstore.h"
#import "FieldLevelSecurityStrategy.h"
#import "UnsecuredRepository.h"

@implementation RepositoryFactory
+ (id<RepositoryProtocol>)buildRepositoryForModel:(NSString*)modelname toFile:(NSString*)filename fromConfiguration:(NSString*)configuration withSecurityStrategy:(id<RepositorySecurityStrategyProtocol>)strategy{
    SQLiteBackingstore *bs = [[SQLiteBackingstore alloc]initWithModelName:modelname toFile:filename fromConfiguration:configuration];
    
    id<RepositoryProtocol> repository = nil;
    if ([strategy isKindOfClass:[FieldLevelSecurityStrategy class]]) {
        repository = [[FieldLevelSecurityRepository alloc]initWithBackingStore:bs securityStrategy:strategy];
    }
    else{
        repository = [[UnsecuredRepository alloc]initWithBackingStore:bs securityStrategy:nil];
    }
    
    return repository;
}

+ (id<RepositoryProtocol>)createFieldLevelRepositoryForModel:(NSString*)modelname toFile:(NSString*)filename fromConfiguration:(NSString*)configuration{
    id<RepositorySecurityStrategyProtocol> securityStrategy = [[FieldLevelSecurityStrategy alloc]init];
    return [RepositoryFactory buildRepositoryForModel:modelname toFile:filename fromConfiguration:configuration withSecurityStrategy:securityStrategy];
}

+ (id<RepositoryProtocol>)createUnsecuredRepositoryForModel:(NSString*)modelname toFile:(NSString*)filename fromConfiguration:(NSString*)configuration{
    return [RepositoryFactory buildRepositoryForModel:modelname toFile:filename fromConfiguration:configuration withSecurityStrategy:nil];
}
@end
