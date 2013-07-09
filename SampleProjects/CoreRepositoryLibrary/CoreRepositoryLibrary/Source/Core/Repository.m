//
//  Repository.m
//  CoreDataRepositoryFramework
//
//  Created by Dirk Lewis on 6/18/12.
//  Copyright (c) 2012 Optima HCS. All rights reserved.
//

#import "Repository.h"
#import "DataEncryption.h"


@interface Repository()


@end

@implementation Repository{
    
}

@synthesize isRepositoryOpen = _isRepositoryOpen;
@synthesize backingstore = _backingstore;
@synthesize context = _context;
@synthesize securityStrategy = _securityStrategy;
@synthesize isRepositorySecured = _isRepositorySecured;

#pragma mark - Initialization
- (id)init
{
    [NSException raise:@"Please use default initializer initWithBackingStore:" format:@"Not default initializer"];
    return nil;
}

- (id)initWithBackingStore:(id<BackingstoreProtocol>)backingStore securityStrategy:(id<RepositorySecurityStrategyProtocol>)securityStrategy{
    self = [super init];
    if (self) {
        _backingstore = backingStore;
        _isRepositoryOpen = NO;
        _securityStrategy = securityStrategy;
    }
    return self;
}

+ (Repository*)repository:(id<BackingstoreProtocol>)backingstore securityStrategy:(id<RepositorySecurityStrategyProtocol>)securityStrategy{
    
    return [[Repository alloc]initWithBackingStore:backingstore securityStrategy:securityStrategy];
}

#pragma mark - Open \ Close

- (RepositoryOperationStatus)closeRepository{
    [NSException raise:@"Must Override" format:nil];
    return RepositoryOperationStatusFeatureNotImplemented;
}
- (RepositoryOperationStatus)openRepository{
    [NSException raise:@"Must Override" format:nil];
    return RepositoryOperationStatusFeatureNotImplemented;
}

#pragma mark - Data Access Methods
- (id)insertNewEntityNamed:(NSString*)entityName{
    return [NSEntityDescription insertNewObjectForEntityForName:entityName inManagedObjectContext:[self context]];
}

- (NSFetchRequest*)fetchRequestForEntityNamed:(NSString*)entityName batchSize:(NSInteger)batchSize{
    NSFetchRequest *fetchRequest = [[NSFetchRequest alloc]initWithEntityName:entityName];
    if (batchSize > 0) {
        [fetchRequest setFetchBatchSize:batchSize];
    }
    return fetchRequest;
}

- (NSArray*)resultsForRequest:(NSFetchRequest*)fetchRequest error:(NSError*)error{
    
    NSArray *resultsArray = [self.context executeFetchRequest:fetchRequest error:&error];
    if (error) {
        return nil;
    }
    
    return resultsArray;
}

- (NSArray*)resultsForRequest:(NSFetchRequest *)fetchRequest{
    
    NSError *error = nil;
    NSArray *resultsArray = [self resultsForRequest:fetchRequest error:error];
    if (error) {
        return nil;
    }
    
    return resultsArray;
}

- (BOOL)deleteManagedObject:(NSManagedObject*)managedObject{
    
    [[self context]deleteObject:managedObject];
    return [self save];
}

#pragma mark - Data Persist Methods
- (BOOL)save{
    
    if (![self.context hasChanges]) {
        return YES;
    }
    
    NSError *error = nil;
    if (![self.context save:&error]) {
        NSLog(@"Errors:\n%@",[[error userInfo] objectForKey:NSDetailedErrorsKey]);
        return NO;
    }
    
    return YES;
}

- (BOOL)saveWithRollbackOnError{
    
    if (![self save]) {
        [self.context rollback];
        return NO;
    }
    return YES;
}

- (BOOL)resetBackingstore{
    
    BOOL result = YES;
    [self.backingstore resetBackingstore];
    self.context = [self.backingstore managedObjectContext];
    
    if (!self.context) {
        result = NO;
    }
    
    return result;
}

@end
