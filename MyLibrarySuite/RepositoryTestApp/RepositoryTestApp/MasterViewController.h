//
//  MasterViewController.h
//  RepositoryTestApp
//
//  Created by Dirk Lewis on 7/2/13.
//  Copyright (c) 2013 VideoHooHaa. All rights reserved.
//

#import <UIKit/UIKit.h>

#import <CoreData/CoreData.h>

@interface MasterViewController : UITableViewController <NSFetchedResultsControllerDelegate>

@property (strong, nonatomic) NSFetchedResultsController *fetchedResultsController;
@property (strong, nonatomic) NSManagedObjectContext *managedObjectContext;

@end
