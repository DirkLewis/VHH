//
//  RORepository.h
//  ROMobileUniversal
//
//  Created by Dirk Lewis 11/16/2011
//  Copyright 2011 Optima  All rights reserved.
//

@class BackingStore;

/** Base class for all repository classes.  Provides shared, common behavior */
@interface VHHRepository : NSObject


//- (id)initWithContext:(NSManagedObjectContext*)context;
- (id)initWithBackingStore:(BackingStore*)backingStore;

/** managed object context used by this repository instance */
@property(strong, nonatomic) NSManagedObjectContext *managedObjectContext;
@property (strong, nonatomic) BackingStore *backingStore;

/** 
 Saves a few keystrokes when creating new model objects.  
 Returns a new, autoreleased NSManagedObject in the Repository's NSManagedObjectContext 
 */
- (id)insertNewEntityNamed:(NSString *)entityName;

+ (VHHRepository*)repository:(BackingStore*)backingStore;

/** Configures an NSFetchedRequest for the provided entityName using the repos NSManagedObjectContext */ 
- (NSFetchRequest *)fetchRequestForEntityNamed:(NSString *)entityName;

/**  Returns a fetchedResultsController for the fetchRequest  */
- (NSFetchedResultsController *)fetchedResultsControllerForRequest:(NSFetchRequest *)fetchRequest  sectionNameKeyPath:(NSString*)keyPath cacheName:(NSString*)cacheName;

/** 
 Returns an array for the fetchRequest 
 or error.  Error is logged.
 */
- (NSArray *)resultsForRequest:(NSFetchRequest *)fetchRequest;

/** 
 Returns a single instance when fetchRequest returns data, nil if no results 
 or error.  Error is passed through the aError out param 
 */
- (NSManagedObject *)singleResultForRequest:(NSFetchRequest *)fetchRequest error:(NSError **)aError;

/** 
 Returns a single instance when fetchRequest returns data, nil if no results 
 or error.  Error is logged.
 */
- (NSManagedObject *)singleResultForRequest:(NSFetchRequest *)fetchRequest;

/** saves changes in context.  returns YES for success */
- (BOOL)save;
- (BOOL)saveWithRollbackOnError;
- (BOOL)resetBackingstore;

@end
