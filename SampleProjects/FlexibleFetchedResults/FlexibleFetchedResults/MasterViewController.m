//
//  MasterViewController.m
//  FlexibleFetchedResults
//
//  Created by Dirk Lewis on 8/31/12.
//  Copyright (c) 2012 VHH. All rights reserved.
//

#import "MasterViewController.h"
#import "DetailViewController.h"

#import <FlexibleTableLibrary/FlexibleFRCTableDatasource.h>
#import <FlexibleTableLibrary/FlexibleCellDescription.h>
#import <CoreRepositoryLibrary/CoreRepositoryLibraryHeaders.h>

#import "Person.h"
#import "Address.h"
#import "PersonCell.h"

@interface MasterViewController () {
    NSMutableArray *_objects;
}

@property (strong,nonatomic)Repository *repository;

@end

@implementation MasterViewController

- (void)awakeFromNib
{
    [super awakeFromNib];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    self.navigationItem.leftBarButtonItem = self.editButtonItem;

    UIBarButtonItem *addButton = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemAdd target:self action:@selector(insertNewObject:)];
    self.navigationItem.rightBarButtonItem = addButton;
    
    self.repository = [RepositoryFactory createUnsecuredRepositoryForModel:@"Model" toFile:@"Model.sqlite" fromConfiguration:nil];
    [self.repository openRepository];
    
    [self createFlexibleDatasource];
    
    self.flexibleDatasource.allowDeletes = YES;
    [self.flexibleDatasource performFetch];
    self.tableView.dataSource = self.flexibleDatasource;
}

- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation != UIInterfaceOrientationPortraitUpsideDown);
}

#pragma mark - Private methods

- (void)createFlexibleDatasource{
    
    self.flexibleDatasource = [[FlexibleFRCTableDatasource alloc]initWithFetchedResultsControllerBlock:^NSFetchedResultsController *{
        
        NSFetchedResultsController *fetchedResultsController = nil;
        NSFetchRequest *fetchRequest = [self.repository fetchRequestForEntityNamed:[Person entityName] batchSize:20];
        NSSortDescriptor *sort = [[NSSortDescriptor alloc] initWithKey:@"lastName" ascending:NO];
        [fetchRequest setSortDescriptors:[NSArray arrayWithObject:sort]];
        fetchedResultsController = [[NSFetchedResultsController alloc] initWithFetchRequest:fetchRequest managedObjectContext:self.repository.context sectionNameKeyPath:nil cacheName:@"Root"];
        return fetchedResultsController;
        
    } cellDescriptionBlock:^FlexibleCellDescription *(id dataObject) {
        
        if ([dataObject isKindOfClass:[Person class]]) {
            return [[FlexibleCellDescription alloc]initWithCellClass:[PersonCell class] AndData:nil backgroundViewClass:nil selectedBackgroundViewClass:nil];
        }
        else if ([dataObject isKindOfClass:[Address class]]){
            return nil;
        }
        return nil;
    }];

}

- (void)createNewPerson{
    Person *newPerson = [self.repository insertNewEntityNamed:[Person entityName]];
    newPerson.firstName = @"John";
    newPerson.lastName = @"Doe";
    [self.repository save];}

- (void)insertNewObject:(id)sender
{
    [self createNewPerson];
}


- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if ([[segue identifier] isEqualToString:@"showDetail"]) {
        NSIndexPath *indexPath = [self.tableView indexPathForSelectedRow];
        NSDate *object = [_objects objectAtIndex:indexPath.row];
        [[segue destinationViewController] setDetailItem:object];
    }
}

@end
