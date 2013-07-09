//
//  Repository.m
//  VHHCoreRepository
//
//  Created by Dirk Lewis on 7/2/13.
//  Copyright (c) 2013 VideoHooHaa. All rights reserved.
//

#import "Repository.h"
#import "DataEncryption.h"

@interface Repository()
@property (strong,nonatomic,readwrite) id<BackingstoreProtocol> backingstore;
@property (strong,nonatomic,readwrite) id<RepositorySecurityStrategyProtocol> securityStrategy;
@property (strong,nonatomic,readwrite) NSMutableArray *errorArray;

@end

@implementation Repository{

}

#pragma mark - Initialization
- (instancetype)init
{
    [NSException raise:@"Please use default initializer initWithBackingStore:" format:@"Not default initializer"];
    return nil;
}

- (instancetype)initWithBackingStore:(id<BackingstoreProtocol>)backingStore securityStrategy:(id<RepositorySecurityStrategyProtocol>)securityStrategy{
    self = [super init];
    if (self) {
        
        if ([NSStringFromClass([self class])isEqualToString:@"Repository"]) {
            [NSException raise:@"Must subclass Repository" format:@"please subclass"];
        }
        
        _backingstore = backingStore;
        _isRepositoryOpen = NO;
        _securityStrategy = securityStrategy;
        _errorArray = [NSMutableArray array];
    }
    return self;
}

+ (instancetype)repository:(id<BackingstoreProtocol>)backingstore securityStrategy:(id<RepositorySecurityStrategyProtocol>)securityStrategy{
    
    return [[self alloc]initWithBackingStore:backingstore securityStrategy:securityStrategy];
}

#pragma mark - Repository Open \ Close

- (RepositoryOperationStatus)closeRepository{
    [NSException raise:@"Must Override" format:nil];
    return RepositoryOperationStatusFeatureNotImplemented;
}
- (RepositoryOperationStatus)openRepository{
    [NSException raise:@"Must Override" format:nil];
    return RepositoryOperationStatusFeatureNotImplemented;
}

- (RepositoryOperationStatus)resetBackingStore{
    [NSException raise:@"Must Override" format:nil];
    return RepositoryOperationStatusFeatureNotImplemented;
}
- (RepositoryOperationStatus)deleteBackingStore{
    [NSException raise:@"Must Override" format:nil];
    return RepositoryOperationStatusFeatureNotImplemented;
}

#pragma mark - Repository Data Access Methods
- (instancetype)insertNewEntityNamed:(NSString*)entityName{
    
    if ([self isRepositoryOpen]) {
        return [NSEntityDescription insertNewObjectForEntityForName:entityName inManagedObjectContext:[self.backingstore managedObjectContext]];

    }
    else{
        [NSException raise:@"Repository Closed" format:@"you must first open repository"];
        return nil;
    }
}

- (NSFetchRequest*)fetchRequestForEntityNamed:(NSString*)entityName batchSize:(NSInteger)batchSize{
    
    if ([self isRepositoryOpen]) {
        NSFetchRequest *fetchRequest = [[NSFetchRequest alloc]initWithEntityName:entityName];
        if (batchSize > 0) {
            [fetchRequest setFetchBatchSize:batchSize];
        }
        return fetchRequest;
    }
    else{
        [NSException raise:@"Repository Closed" format:@"you must first open repository"];
        return nil;

    }
}

- (NSArray*)resultsForRequest:(NSFetchRequest*)fetchRequest error:(NSError*)error{
    
    if ([self isRepositoryOpen]) {
        NSArray *resultsArray = [[self.backingstore managedObjectContext] executeFetchRequest:fetchRequest error:&error];
        if (error) {
            [self.errorArray addObject:error];
            return nil;
        }
        
        return resultsArray;
    }
    else{
        [NSException raise:@"Repository Closed" format:@"you must first open repository"];
        return nil;
    }
    
}

- (NSArray*)resultsForRequest:(NSFetchRequest *)fetchRequest{
    
    if ([self isRepositoryOpen]) {
        NSError *error = nil;
        NSArray *resultsArray = [self resultsForRequest:fetchRequest error:error];
        if (error) {
            [self.errorArray addObject:error];
            return nil;
        }
        
        return resultsArray;
    }
    else{
        [NSException raise:@"Repository Closed" format:@"you must first open repository"];
        return nil;
    }

}

- (BOOL)deleteManagedObject:(NSManagedObject*)managedObject{
    if ([self isRepositoryOpen]) {
        [[self.backingstore managedObjectContext]deleteObject:managedObject];
        return [self save];
    }
    else{
        [NSException raise:@"Repository Closed" format:@"you must first open repository"];
        return NO;
    }

}

#pragma mark - Data Persist Methods
- (BOOL)save{
    
    if ([self isRepositoryOpen]) {
        if (![[self.backingstore managedObjectContext] hasChanges]) {
            return YES;
        }
        
        NSError *error = nil;
        if (![[self.backingstore managedObjectContext] save:&error]) {
            [self.errorArray addObject:error];
            NSLog(@"Errors:\n%@",[[error userInfo] objectForKey:NSDetailedErrorsKey]);
            return NO;
        }
        
        return YES;
    }
    else{
        [NSException raise:@"Repository Closed" format:@"you must first open repository"];
        return NO;
    }

}

- (BOOL)saveWithRollbackOnError{
    
    if ([self isRepositoryOpen]) {
        if (![self save]) {
            [[self.backingstore managedObjectContext] rollback];
            return NO;
        }
        return YES;
    }
    else{
        [NSException raise:@"Repository Closed" format:@"you must first open repository"];
        return NO;
    }

}

@end
