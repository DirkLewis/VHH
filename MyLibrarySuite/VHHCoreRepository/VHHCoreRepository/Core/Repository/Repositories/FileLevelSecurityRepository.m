//
//  FileLevelSecurityRepository.m
//  VHHCoreRepository
//
//  Created by Dirk Lewis on 7/2/13.
//  Copyright (c) 2013 VideoHooHaa. All rights reserved.
//

#import "FileLevelSecurityRepository.h"

@interface FileLevelSecurityRepository()

@end

@implementation FileLevelSecurityRepository{

}

- (RepositoryOperationStatus)openRepository{
    
    if ([self.securityStrategy isRepositorySecured:self]) {
        return RepositoryOperationStatusRepositoryOpenFail;
    }
    
    if ([self.backingstore openBackingstore]) {
        [self.backingstore managedObjectContext];
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
