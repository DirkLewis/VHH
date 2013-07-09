//
//  FlexibleTableDatasource.m
//  FlexibleTables
//
//  Created by Dirk Lewis on 7/24/12.
//  Copyright (c) 2012 Optima HCS. All rights reserved.
//

#import "FlexibleTableDatasource.h"
#import "FlexibleCellDescription.h"
#import "FlexibleTableViewCell.h"
#import "FlexibleTableViewProtocol.h"
@interface FlexibleTableDatasource()

@property (nonatomic,strong) NSMutableArray *headerViews;
@property (nonatomic,strong) NSMutableArray *dataArray;
@property (nonatomic,strong) NSMutableDictionary *selectedIndexes;

@end

@implementation FlexibleTableDatasource

#pragma mark - TableView Datasource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
	return [self.dataArray count];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
	if (!self.dataArray)
	{
		return 0;
	}
	return [[self.dataArray objectAtIndex:section] count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
	NSArray *rows = [self.dataArray objectAtIndex:indexPath.section];
	FlexibleCellDescription *cellDescription = [rows objectAtIndex:indexPath.row];
	NSString *cellIdentifier = [cellDescription.cellClass reuseIdentifier];
	FlexibleTableViewCell *cell = (FlexibleTableViewCell*)[tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    
    if (cell == nil)
	{
		cell = [[cellDescription.cellClass alloc] init];
	}
    
    if (cellDescription.backgroundViewClass) {
        cell.backgroundView = [[cellDescription.backgroundViewClass alloc]init];
        ((id<CustomCellBackgroundProtocol>)cell.backgroundView).lastCell = (indexPath.row == [[self numberOfRowsInSection:indexPath]intValue] - 1);
    }
    
    if (cellDescription.selectedBackgroundViewClass) {
        cell.selectedBackgroundView = [[cellDescription.selectedBackgroundViewClass alloc]init];    
        ((id<CustomCellBackgroundProtocol>)cell.selectedBackgroundView).lastCell = (indexPath.row == [[self numberOfRowsInSection:indexPath]intValue] - 1);
        ((id<CustomCellBackgroundProtocol>)cell.selectedBackgroundView).selected = YES;
    }
    
    [cell configureForData:cellDescription.cellData tableView:tableView indexPath:indexPath];
	return cell;
}

- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath{
    
    return self.allowDeletes;
    
}

- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath{
    
    if (editingStyle == UITableViewCellEditingStyleDelete) {        
        id data = [self dataForIndexPath:indexPath];
        [self tableView:tableView removeRowAtIndexPath:indexPath withAnimation:UITableViewRowAnimationFade];
        [self.flexibleDelegate flexibleTableDataRemoved:data indexPath:indexPath];
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

- (NSArray*)sectionIndexTitlesForTableView:(UITableView *)tableView{
    
    return self.sectionIndexDisplayArray;
}
- (NSInteger)tableView:(UITableView *)tableView sectionForSectionIndexTitle:(NSString *)title atIndex:(NSInteger)index{
    
    return [self.sectionsArray indexOfObject:title];    
}

#pragma mark - TableView manipulation

- (void)headerSectionsReordered{
    _headerViews = nil;
}

- (NSNumber*)numberOfRowsInSection:(NSIndexPath*)indexPath{
    return [NSNumber numberWithInt:[[self sectionAtIndex:indexPath.section]count]];
}

- (NSArray *)sectionAtIndex:(NSInteger)sectionIndex{
    
    if ([self.dataArray count] <= sectionIndex)
	{
		return nil;
	}
	
	return [self.dataArray objectAtIndex:sectionIndex];
    
}

- (id)dataForIndexPath:(NSIndexPath*)indexPath{
    
	if ([self.dataArray count] <= indexPath.section)
	{
		return nil;
	}
	
	NSArray *section = [self.dataArray objectAtIndex:indexPath.section];
	if ([section count] <= indexPath.row)
	{
		return nil;
	}
	
    id data = [[section objectAtIndex:indexPath.row] cellData];
	return data;
}

- (NSArray *)allDataInSection:(NSInteger)sectionIndex{
    
    if ([self.dataArray count] <= sectionIndex)
	{
		return nil;
	}
    
	return [[self.dataArray objectAtIndex:sectionIndex] valueForKey:@"cellData"];
}

- (void)tableView:(UITableView*)tableView setData:(id)dataObject forIndexPath:(NSIndexPath *)indexPath{
    
    [[[self.dataArray objectAtIndex:indexPath.section] objectAtIndex:indexPath.row] setCellData:dataObject];
	FlexibleTableViewCell *cell = (FlexibleTableViewCell*)[tableView cellForRowAtIndexPath:indexPath];
    [cell configureForData:dataObject tableView:tableView indexPath:indexPath];
}

- (void)tableView:(UITableView*)tableView refreshCellForIndexPath:(NSIndexPath*)indexPath{
	NSDictionary *dataObject = [self dataForIndexPath:indexPath];
	FlexibleTableViewCell *cell = (FlexibleTableViewCell *)[tableView cellForRowAtIndexPath:indexPath];
	[cell configureForData:dataObject tableView:tableView indexPath:indexPath];
}

- (Class)cellClassForIndexPath:(NSIndexPath *)indexPath{
    
	if ([self.dataArray count] <= indexPath.section)
	{
		return nil;
	}
	
	NSArray *section = [self.dataArray objectAtIndex:indexPath.section];
	if ([section count] <= indexPath.row)
	{
		return nil;
	}
    
	return [[section objectAtIndex:indexPath.row] cellClass];
}

- (void)tableView:(UITableView*)tableView addSectionAtIndex:(NSInteger)sectionIndex withAnimation:(UITableViewRowAnimation)animation{
    if (!self.dataArray)
	{
		self.dataArray = [[NSMutableArray alloc] init];
	}
	
	if (sectionIndex > [self.dataArray count])
	{
		sectionIndex = [self.dataArray count];
	}
	
	[self.dataArray insertObject:[[NSMutableArray alloc] init] atIndex:sectionIndex];
    
	if (animation != UITableViewRowAnimationNone)
	{
		[tableView insertSections:[NSIndexSet indexSetWithIndex:sectionIndex] withRowAnimation:animation];
	}
	
	[self headerSectionsReordered];
}

- (void)tableView:(UITableView*)tableView removeRowAtIndexPath:(NSIndexPath*)indexPath withAnimation:(UITableViewRowAnimation)animation{
    
    if (indexPath.section >= [self.dataArray count])
	{
		return;
	}
	
	NSMutableArray *section = [self.dataArray objectAtIndex:indexPath.section];
	
	if (indexPath.row >= [section count])
	{
		return;
	}
    [section removeObjectAtIndex:indexPath.row];
    [tableView deleteRowsAtIndexPaths:[NSArray arrayWithObject:indexPath]withRowAnimation:animation];
}

- (void)tableView:(UITableView*)tableView removeAllSectionsWithAnimation:(UITableViewRowAnimation)animation{
    while ([self.dataArray count] > 0)
	{
		[self tableView:tableView removeSectionAtIndex:0 withAnimation:animation];
	}
    
    self.dataArray = nil;
}

- (void)tableView:(UITableView*)tableView appendRowToSection:(NSInteger)sectionIndex cellClass:(Class)cellClass cellData:(id)cellData withAnimation:(UITableViewRowAnimation)animation{
    
    [self tableView:tableView appendRowToSection:sectionIndex cellClass:cellClass cellData:cellData backgroundViewClass:nil selectedBackgroundViewClass:nil withAnimation:animation];
}

- (void)tableView:(UITableView*)tableView appendRowToSection:(NSInteger)sectionIndex cellClass:(Class)cellClass cellData:(id)cellData backgroundViewClass:(Class)backgroundViewClass selectedBackgroundViewClass:(Class)selectedBackgroundViewClass withAnimation:(UITableViewRowAnimation)animation{
    
    NSIndexPath *indexPath = [NSIndexPath indexPathForRow:NSIntegerMax inSection:sectionIndex];
    [self tableView:tableView addRowAtIndexPath:indexPath cellClass:cellClass cellData:cellData backgroundViewClass:backgroundViewClass selectedBackgroundViewClass:selectedBackgroundViewClass withAnimation:animation];
}

- (void)tableView:(UITableView*)tableView addRowAtIndexPath:(NSIndexPath*)indexPath cellClass:(Class)cellClass cellData:(id)cellData backgroundViewClass:(Class)backgroundViewClass selectedBackgroundViewClass:(Class)selectedBackgroundViewClass withAnimation:(UITableViewRowAnimation)animation{
    
    if (!self.dataArray)
	{
		self.dataArray = [[NSMutableArray alloc] init];
	}
	if ([self.dataArray count] == 0)
	{
		[self tableView:tableView addSectionAtIndex:0 withAnimation:animation];
	}
	
	if (indexPath.section > [self.dataArray count] - 1)
	{
        indexPath = [NSIndexPath indexPathForRow:indexPath.row inSection:([self.dataArray count]-1)];
	}
	NSMutableArray *tableSection = [self.dataArray objectAtIndex:indexPath.section];
	if (indexPath.row > [tableSection count])
	{
        indexPath = [NSIndexPath indexPathForRow:[tableSection count] inSection:indexPath.section];
	}
	
	[tableSection insertObject:[[FlexibleCellDescription alloc]initWithCellClass:cellClass AndData:cellData backgroundViewClass:backgroundViewClass selectedBackgroundViewClass:selectedBackgroundViewClass] atIndex:indexPath.row];
	
	if (animation != UITableViewRowAnimationNone)
	{
        
		[tableView insertRowsAtIndexPaths:[NSArray arrayWithObject:indexPath] withRowAnimation:animation];
	}
}

- (void)tableView:(UITableView*)tableView addRowAtIndexPath:(NSIndexPath*)indexPath cellClass:(Class)cellClass cellData:(id)cellData withAnimation:(UITableViewRowAnimation)animation{
    [self tableView:tableView addRowAtIndexPath:indexPath cellClass:cellClass cellData:cellData backgroundViewClass:nil selectedBackgroundViewClass:nil withAnimation:animation];
}

- (void)tableView:(UITableView*)tableView emptySectionAtIndex:(NSInteger)sectionIndex withAnimation:(UITableViewRowAnimation)animation{
    
    if (sectionIndex >= [self.dataArray count])
	{
		if (sectionIndex == [self.dataArray count])
		{
            [self tableView:tableView addSectionAtIndex:0 withAnimation:animation];
		}
		return;
	}
	
	NSMutableArray *indexPaths = [NSMutableArray array];
	int i;
	int count = [[self.dataArray objectAtIndex:sectionIndex] count];
	for (i = 0; i < count; i++)
	{
		[indexPaths addObject:[NSIndexPath indexPathForRow:i inSection:sectionIndex]];
	}
    
	[[self.dataArray objectAtIndex:sectionIndex] removeAllObjects];
    
	if (count && animation != UITableViewRowAnimationNone)
	{
		[tableView deleteRowsAtIndexPaths:indexPaths withRowAnimation:animation];
	}
}

- (void)tableView:(UITableView*)tableView removeSectionAtIndex:(NSInteger)sectionIndex withAnimation:(UITableViewRowAnimation)animation{
    
    if (sectionIndex >= [self.dataArray count])
	{
		return;
	}
	
	[self.dataArray removeObjectAtIndex:sectionIndex];
    
    [tableView deleteSections:[NSIndexSet indexSetWithIndex:sectionIndex] withRowAnimation:animation];
    
	[self headerSectionsReordered];
    
}

- (void)deselect:(UITableView*)tableView{
    
    [tableView deselectRowAtIndexPath:[tableView indexPathForSelectedRow] animated:YES];
    
}

- (BOOL)cellIsSelected:(NSIndexPath *)indexPath {
    // Return whether the cell at the specified index path is selected or not
    if (!_selectedIndexes) {
        _selectedIndexes = [NSMutableDictionary dictionary];
    }
    NSNumber *selectedIndex = [_selectedIndexes objectForKey:indexPath];
    return selectedIndex == nil ? FALSE : [selectedIndex boolValue];
}

- (void)setCellIsSelected:(NSNumber*)selectedIndex forKey:(id)key{
    if (!self.allowMultipleCellSelection) {
        [_selectedIndexes removeAllObjects];
    }    [_selectedIndexes setObject:selectedIndex forKey:key];
}

- (NSIndexPath*)tableView:(UITableView*)tableView indexPathForFlexibleCell:(FlexibleTableViewCell*)flexibleCell{
    
    return [tableView indexPathForCell:flexibleCell];
}

@end
