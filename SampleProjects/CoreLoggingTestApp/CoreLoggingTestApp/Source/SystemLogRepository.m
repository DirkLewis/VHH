//
//  SystemRepository.m
//  CoreLogging
//
//  Created by Dirk Lewis on 7/26/12.
//  Copyright (c) 2012 Optima HCS. All rights reserved.
//

#import "SystemLogRepository.h"
#import <CoreRepositoryLibrary/CoreRepositoryLibraryHeaders.h>


@implementation SystemLogRepository


+ (SystemLogRepository*)sharedSystemLogRepository{

    static dispatch_once_t onceToken;
    static SystemLogRepository *shared = nil;
    
    dispatch_once(&onceToken, ^{
        
        shared = (SystemLogRepository*)[RepositoryFactory createFieldLevelRepositoryForModel:@"Model" toFile:@"SystemLog.sqlite" fromConfiguration:@"Logging"];
        [shared openRepository];
        
    });
    
    return shared;
}

@end
