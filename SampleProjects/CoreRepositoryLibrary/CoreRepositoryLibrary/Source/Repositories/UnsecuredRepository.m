//
//  UnsecuredRepository.m
//  CoreRepositoryLibrary
//
//  Created by Dirk Lewis on 9/1/12.
//  Copyright (c) 2012 VHH. All rights reserved.
//

#import "UnsecuredRepository.h"

@implementation UnsecuredRepository

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

@end
