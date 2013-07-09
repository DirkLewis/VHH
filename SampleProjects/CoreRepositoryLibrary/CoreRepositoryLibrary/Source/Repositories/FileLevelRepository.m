//
//  FileLevelRepository.m
//  CoreDataRepositoryFramework
//
//  Created by Dirk Lewis on 7/19/12.
//  Copyright (c) 2012 Optima HCS. All rights reserved.
//

#import "FileLevelRepository.h"

@implementation FileLevelRepository

- (RepositoryOperationStatus)openRepository{

    if ([self.securityStrategy isRepositorySecured:self]) {
        return RepositoryOperationStatusRepositoryOpenFail;
    }
    
    if ([self.backingstore openBackingstore]) {
        self.context = [self.backingstore managedObjectContext];
        self.isRepositoryOpen = YES;
        return RepositoryOperationStatusSuccess;
    }
    
    return RepositoryOperationStatusRepositoryOpenFail;
}

- (RepositoryOperationStatus)closeRepository{
    
    if (![self.securityStrategy isRepositorySecured:self]) {
        return RepositoryOperationStatusRepositoryCloseFail;
    }
    
    if ([self.backingstore closeBackingstore]) {
        self.context = nil;
        self.isRepositoryOpen = NO;
        return RepositoryOperationStatusSuccess;
    }
    return RepositoryOperationStatusRepositoryCloseFail;
    
}

- (RepositoryOperationStatus)resetSecuredRepository{
    RepositoryOperationStatus status = [self.securityStrategy resetSecuredRepository:self];
    self.isRepositorySecured = [self.securityStrategy isRepositorySecured:self];
    return status;
}
- (RepositoryOperationStatus)secureRepositoryWithPassword:(NSString*)password{
    
    RepositoryOperationStatus status = [self.securityStrategy secureRepository:self withPassword:password];
    self.isRepositorySecured = [self.securityStrategy isRepositorySecured:self];
    return status;
}
- (RepositoryOperationStatus)unsecureRepositoryWithPassword:(NSString*)password{
    
    RepositoryOperationStatus status = [self.securityStrategy unsecureRepository:self withPassword:password];
    self.isRepositorySecured = [self.securityStrategy isRepositorySecured:self];
    return status;
}

@end
