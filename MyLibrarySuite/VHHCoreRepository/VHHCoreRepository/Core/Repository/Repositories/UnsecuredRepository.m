//
//  UnsecuredRepository.m
//  VHHCoreRepository
//
//  Created by Dirk Lewis on 7/2/13.
//  Copyright (c) 2013 VideoHooHaa. All rights reserved.
//

#import "UnsecuredRepository.h"

@interface UnsecuredRepository()

@end

@implementation UnsecuredRepository{

}

- (RepositoryOperationStatus)closeRepository{
    
    if ([self.backingstore closeBackingstore]) {
        self.isRepositoryOpen = NO;
        return RepositoryOperationStatusSuccess;
    }
    return RepositoryOperationStatusRepositoryCloseFail;
}

- (RepositoryOperationStatus)openRepository{
    
    if ([self.backingstore openBackingstore]) {
        [self.backingstore managedObjectContext];
        self.isRepositoryOpen = YES;
        return RepositoryOperationStatusSuccess;
    }
    
    return RepositoryOperationStatusRepositoryOpenFail;
}

@end
