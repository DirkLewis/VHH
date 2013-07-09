//
//  FieldLevelSecurityRepository.m
//  VHHCoreRepository
//
//  Created by Dirk Lewis on 7/2/13.
//  Copyright (c) 2013 VideoHooHaa. All rights reserved.
//

#import "FieldLevelSecurityRepository.h"

@implementation FieldLevelSecurityRepository

- (RepositoryOperationStatus)closeRepository{
    
    if ([self.backingstore closeBackingstore]) {
        self.isRepositoryOpen = NO;
        return RepositoryOperationStatusSuccess;
    }
    return RepositoryOperationStatusRepositoryOpenFail;
}

- (RepositoryOperationStatus)openRepository{
    
    if ([self.backingstore openBackingstore]) {
        [self.backingstore managedObjectContext];
        self.isRepositoryOpen = YES;
        return RepositoryOperationStatusSuccess;
    }
    
    return RepositoryOperationStatusRepositoryOpenFail;
}

- (RepositoryOperationStatus)reEncryptRepositoryWithPasswordTracker:(id<PasswordProtocol>)passwordTracker{
    
    return  [self.securityStrategy reEncryptRepository:self passwordTracker:(id<PasswordProtocol>)passwordTracker];
}


@end
