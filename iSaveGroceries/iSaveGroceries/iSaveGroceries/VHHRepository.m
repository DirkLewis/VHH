//
//  RORepository.m
//  ROMobileUniversal
//
//  Created by Dirk Lewis 11/16/2011
//  Copyright 2011 Optima  All rights reserved.
//

#import "VHHRepository.h"
#import "NSObject+VHHAdditions.h"

@implementation VHHRepository{

}

@synthesize managedObjectContext = __managedObjectContext;
@synthesize backingStore = _backingStore;

- (id)initWithBackingStore:(BackingStore*)backingStore {
    self = [super init];
    if (self) {
        _backingStore = backingStore;
        __managedObjectContext = backingStore.managedObjectContext;
    }
    return self;
}

+ (VHHRepository*)repository:(BackingStore*)backingStore{
    
    return [[VHHRepository alloc] initWithBackingStore:backingStore];

}

//*             *//
- (id)insertNewEntityNamed:(NSString *)entityName
{
    return [NSEntityDescription insertNewObjectForEntityForName:entityName inManagedObjectContext:[self managedObjectContext]];
}

//*             *//
- (NSFetchRequest *)fetchRequestForEntityNamed:(NSString *)entityName{
    // create fetch request
    NSFetchRequest *fetchRequest = [[NSFetchRequest alloc] init];
    // set entity and managed object context
	[fetchRequest setEntity:[NSEntityDescription entityForName:entityName inManagedObjectContext:[self managedObjectContext]]];
    return fetchRequest;
}

//*             *//
- (NSFetchedResultsController *)fetchedResultsControllerForRequest:(NSFetchRequest *)fetchRequest sectionNameKeyPath:(NSString*)keyPath cacheName:(NSString*)cacheName
{
	NSFetchedResultsController *frc = 
    [[NSFetchedResultsController alloc] initWithFetchRequest:fetchRequest 
                                        managedObjectContext:self.managedObjectContext 
                                          sectionNameKeyPath:keyPath 
                                                   cacheName:cacheName];
	
	return frc;
}

//*             *//
- (NSArray *)resultsForRequest:(NSFetchRequest *)fetchRequest
{
	NSError *error = nil;
	NSArray *results = [self.managedObjectContext executeFetchRequest:fetchRequest error:&error];
	if (error) {
        // log the error.  This won't be as helpful here as up the stack so 
        // consider calling the other selector from the consuming code
        
    }
	return results;
}

//*             *//
- (NSManagedObject *)singleResultForRequest:(NSFetchRequest *)fetchRequest
{
    NSError *error = nil;
    NSManagedObject *result = [self singleResultForRequest:fetchRequest error:&error];
    if (error) {
        // log the error.  This won't be as helpful here as up the stack so 
        // consider calling the other selector from the consuming code
    }
    return result;
}

//*             *//
- (NSManagedObject *)singleResultForRequest:(NSFetchRequest *)fetchRequest error:(NSError **)aError
{
	NSError *error = nil;
	NSArray *results = [self.managedObjectContext executeFetchRequest:fetchRequest error:&error];
    
    // check for error
    if( error || !results )
    {
		if(aError) {
			*aError = error;
		}
    }
    else
    {
        NSManagedObject *result = [results lastObject];
        return result;
    }
    
    return nil;
}

- (BOOL)saveWithRollbackOnError{

    if (![self save]) {
        [self.managedObjectContext rollback];
        return NO;
    }
    
    return YES;
}

- (BOOL)save
{
    if (![self.managedObjectContext hasChanges]) {
        return YES;
    }
    
    NSError *error = nil;
    if (![self.managedObjectContext save:&error])
    {
        NSArray* detailedErrors = [[error userInfo] objectForKey:NSDetailedErrorsKey];
        if(detailedErrors != nil && [detailedErrors count] > 0) {
            for(NSError* detailedError in detailedErrors) {
#warning TODO:Log proper error here
            }
        }
        else {
#warning TODO:Log proper error here
        }
        return NO;
    }
    return YES;
}

- (BOOL)resetBackingstore{

    [self.backingStore resetBackingstore];
    self.managedObjectContext = self.backingStore.managedObjectContext;
    return YES;
}

@end