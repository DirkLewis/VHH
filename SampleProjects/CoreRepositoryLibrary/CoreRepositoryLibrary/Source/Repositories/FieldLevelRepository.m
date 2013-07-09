//
//  FieldLevelRepository.m
//  CoreDataRepositoryFramework
//
//  Created by Dirk Lewis on 7/19/12.
//  Copyright (c) 2012 Optima HCS. All rights reserved.
//

#import "FieldLevelRepository.h"

@implementation FieldLevelRepository

- (RepositoryOperationStatus)closeRepository{
    
    if ([self.backingstore closeBackingstore]) {
        self.context = nil;
        self.isRepositoryOpen = NO;
        return RepositoryOperationStatusSuccess;
    }
    return RepositoryOperationStatusRepositoryOpenFail;
}

- (RepositoryOperationStatus)openRepository{
    
    if ([self.backingstore openBackingstore]) {
        self.context = [self.backingstore managedObjectContext];
        self.isRepositoryOpen = YES;
        return RepositoryOperationStatusSuccess;
    }
    
    return RepositoryOperationStatusRepositoryOpenFail;
}

- (RepositoryOperationStatus)reEncryptRepositoryWithPasswordTracker:(id<PasswordProtocol>)passwordTracker{
    [self.securityStrategy reEncryptRepository:self passwordTracker:(id<PasswordProtocol>)passwordTracker];
    return  RepositoryOperationStatusSuccess;
}

@end
