//
//  FlexibleFRCTableDatasource.m
//  FlexibleTableLibrary
//
//  Created by Dirk Lewis on 8/27/12.
//  Copyright (c) 2012 VHH. All rights reserved.
//

#import "FlexibleFRCTableDatasource.h"
#import "FlexibleCellDescription.h"
#import "FlexibleTableViewCell.h"

@interface FlexibleFRCTableDatasource()

@property (strong,nonatomic)NSFetchedResultsController *fetchedResultsController;
@property (assign,nonatomic)FRCBlockType frcBlock;
@property (assign,nonatomic)CellDescriptionBlockType cellDescriptionBlock;
@property (strong,nonatomic)UITableView *tableView;
@end

@implementation FlexibleFRCTableDatasource

- (id)initWithFetchedResultsControllerBlock:(FRCBlockType)frcBlock cellDescriptionBlock:(CellDescriptionBlockType)cellDescriptionBlock
{
    self = [super init];
    if (self) {
        _frcBlock = frcBlock;
        _fetchedResultsController = frcBlock();
        _cellDescriptionBlock = cellDescriptionBlock;
    }
    return self;
}

#pragma mark - Public Methods
- (void)performFetch{
    
    NSError *error = nil;
    [self.fetchedResultsController performFetch:&error];
    
    if (error) {
        DLog(@"%@",error);
    }
    self.fetchedResultsController.delegate = self;

}
- (void)resetFRC{

    self.fetchedResultsController = nil;

}

#pragma mark - TableView Datasource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    if (!self.tableView) {
        self.tableView = tableView;
    }
    NSInteger numberOfSections = [[self.fetchedResultsController sections]count];
    DLog(@"%i",numberOfSections);
    return numberOfSections;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    id  sectionInfo = [[self.fetchedResultsController sections] objectAtIndex:section];
    return [sectionInfo numberOfObjects];

}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
	id dataObject = [self.fetchedResultsController objectAtIndexPath:indexPath];
    FlexibleCellDescription *cellDescription = self.cellDescriptionBlock(dataObject);
    
    if (!cellDescription) {
        [NSException raise:@"Cell Description can not be nil" format:nil];
    }
    
    NSString *cellIdentifier = [cellDescription.cellClass reuseIdentifier];
    
    FlexibleTableViewCell *cell = (FlexibleTableViewCell*)[tableView dequeueReusableCellWithIdentifier:cellIdentifier];

    if (cell == nil)
	{
		cell = [[cellDescription.cellClass alloc] init];
	}
    
    if (cellDescription.backgroundViewClass) {
        cell.backgroundView = [[cellDescription.backgroundViewClass alloc]init];
        NSInteger numberOfRowsInSection = [[[self.fetchedResultsController sections] objectAtIndex:[indexPath section]]numberOfObjects];
        ((id<CustomCellBackgroundProtocol>)cell.selectedBackgroundView).lastCell = (indexPath.row == (numberOfRowsInSection - 1));
    }
    
    if (cellDescription.selectedBackgroundViewClass) {
        cell.selectedBackgroundView = [[cellDescription.selectedBackgroundViewClass alloc]init];
        NSInteger numberOfRowsInSection = [[[self.fetchedResultsController sections] objectAtIndex:[indexPath section]]numberOfObjects];
        ((id<CustomCellBackgroundProtocol>)cell.selectedBackgroundView).lastCell = (indexPath.row == (numberOfRowsInSection - 1));
        ((id<CustomCellBackgroundProtocol>)cell.selectedBackgroundView).selected = YES;
    }
    
    [cell configureForData:dataObject tableView:tableView indexPath:indexPath];
	return cell;
}

- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath{
    
    return self.allowDeletes;
    
}

- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath{
    
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        id dataObject = [self.fetchedResultsController objectAtIndexPath:indexPath];
        [self.fetchedResultsController.managedObjectContext deleteObject:dataObject];
        

    }
    else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }
}

- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath{
    
    return self.allowMoves;
}
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)sourceIndexPath toIndexPath:(NSIndexPath *)destinationIndexPath{
    
    NSLog(@"Row moved");
}

//- (NSArray*)sectionIndexTitlesForTableView:(UITableView *)tableView{
//    
//    //return self.sectionIndexDisplayArray;
//}
//- (NSInteger)tableView:(UITableView *)tableView sectionForSectionIndexTitle:(NSString *)title atIndex:(NSInteger)index{
//    
//    //return [self.sectionsArray indexOfObject:title];
//}

#pragma mark - fetched results controller delegate

- (void)controllerWillChangeContent:(NSFetchedResultsController *)controller{
    DLog(@"stopper");
    [self.tableView beginUpdates];
    
}

- (void)controllerDidChangeContent:(NSFetchedResultsController *)controller{
    [self.tableView endUpdates];
    DLog(@"stopper");

}

- (void)controller:(NSFetchedResultsController *)controller didChangeSection:(id<NSFetchedResultsSectionInfo>)sectionInfo atIndex:(NSUInteger)sectionIndex forChangeType:(NSFetchedResultsChangeType)type{
    switch(type) {
    
        case NSFetchedResultsChangeInsert:
            DLog(@"stopper");

            [self.tableView insertSections:[NSIndexSet indexSetWithIndex:sectionIndex] withRowAnimation:UITableViewRowAnimationFade];
            break;
            
        case NSFetchedResultsChangeDelete:
            DLog(@"stopper");

            [self.tableView deleteSections:[NSIndexSet indexSetWithIndex:sectionIndex] withRowAnimation:UITableViewRowAnimationFade];
            break;
    }}

- (void)controller:(NSFetchedResultsController *)controller didChangeObject:(id)anObject atIndexPath:(NSIndexPath *)indexPath forChangeType:(NSFetchedResultsChangeType)type newIndexPath:(NSIndexPath *)newIndexPath{
    
    switch(type) {
            
        case NSFetchedResultsChangeInsert:
            DLog(@"stopper");

            [self.tableView insertRowsAtIndexPaths:[NSArray arrayWithObject:newIndexPath] withRowAnimation:UITableViewRowAnimationFade];
            break;
            
        case NSFetchedResultsChangeDelete:
            DLog(@"stopper");

            [self.tableView deleteRowsAtIndexPaths:[NSArray arrayWithObject:indexPath] withRowAnimation:UITableViewRowAnimationFade];
            break;
            
        case NSFetchedResultsChangeUpdate:{
            DLog(@"stopper");
            FlexibleTableViewCell *cell = (FlexibleTableViewCell*)[self.tableView cellForRowAtIndexPath:indexPath];
            [cell configureForData:anObject tableView:self.tableView indexPath:indexPath];
            break;
        }
        case NSFetchedResultsChangeMove:
            DLog(@"stopper");

            [self.tableView deleteRowsAtIndexPaths:[NSArray arrayWithObject:indexPath] withRowAnimation:UITableViewRowAnimationFade];
            [self.tableView insertRowsAtIndexPaths:[NSArray arrayWithObject:newIndexPath] withRowAnimation:UITableViewRowAnimationFade];
            break;
    }
}
@end
