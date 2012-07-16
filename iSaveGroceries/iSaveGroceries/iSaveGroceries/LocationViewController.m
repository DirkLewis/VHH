//
//  SecondViewController.m
//  iSaveGroceries
//
//  Created by Dirk on 2/11/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "LocationViewController.h"
#import "Location.h"
@interface LocationViewController ( Private )
- (BOOL)cellIsSelected:(NSIndexPath *)indexPath;
- (void)refreshNotification:(NSNotification*)notification;

@end

@implementation LocationViewController{


}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Release any cached data, images, etc that aren't in use.
}

#pragma mark - View lifecycle

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    self.useCustomHeaders = YES;
    [self refresh];
}

- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    UIBarButtonItem *button = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemRefresh target:self action:@selector(refresh)];
	[self.navigationItem setRightBarButtonItem:button animated:YES];
    [self.navigationItem setTitle:@"Locations"];
    
    [VHHStyleSheet styleTableForMenuList:self.flexibleTableView];
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    [[NSNotificationCenter defaultCenter] removeObserver:self];

    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(refreshNotification:) name:@"RefreshLocations" object:nil];
}

- (void)viewWillDisappear:(BOOL)animated
{
	[super viewWillDisappear:animated];
}

- (void)viewDidDisappear:(BOOL)animated
{
	[super viewDidDisappear:animated];
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Return YES for supported orientations
    return (interfaceOrientation != UIInterfaceOrientationPortraitUpsideDown);
}

- (void)refreshNotification:(NSNotification*)notification{

    [self refresh];

}


- (void)createRows{

    NSArray *locations = [Location fetchArrayOfAllLocationsSortedByCityName];

    [self addSectionAtIndex:0 WithAnimation:UITableViewRowAnimationAutomatic];
    for (Location *location in locations) {
        
        [self appendRowToSection:0 CellClass:[LocationTableViewCell class] CellData:location WithAnimation:UITableViewRowAnimationAutomatic];
    }
    
    NSLog(@"%@",locations);
    
    
}


- (void)refresh{
    
    [self refreshWithDelay:0.0];
    
}

- (void)refreshWithDelay:(NSTimeInterval)delay{
    
	[self removeAllSectionsWithAnimation:UITableViewRowAnimationFade];
	[self performSelector:@selector(createRows) withObject:nil afterDelay:delay];
}


#pragma mark - TableView delegate methods

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    [super tableView:tableView didSelectRowAtIndexPath:indexPath];    
    
    
    Class cellClass = [self cellClassForRow:indexPath.row InSection:indexPath.section];
    if ([cellClass isHeaderFooter] && [indexPath row] == 0) {
        return;
    }
    
    if ([cellClass isHeaderFooter] && [[self sectionAtIndex:[indexPath section]]count] - 1 == [indexPath row]) {
        return;
    }
    
    // Toggle 'selected' state
    BOOL isSelected = ![self cellIsSelected:indexPath];
    // Store cell 'selected' state keyed on indexPath
    NSNumber *selectedIndex = [NSNumber numberWithBool:isSelected];
    [self setCellIsSelected:selectedIndex forKey:indexPath];
    
    [self.flexibleTableView beginUpdates];
    [self.flexibleTableView endUpdates];
    
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    Class cellClass = [self cellClassForRow:indexPath.row InSection:indexPath.section];
    
    if ([cellClass isHeaderFooter] && [indexPath row] == 0) {
        return [cellClass rowHeight];
    }
    
    if ([cellClass isHeaderFooter] && [[self sectionAtIndex:[indexPath section]]count] - 1 == [indexPath row]) {
        return [cellClass rowHeight];
    }  
    
    if ([self cellIsSelected:indexPath]) {
        
        return [cellClass rowExpandedHeight];
    }
    else{
        return [cellClass rowHeight];
    }
}

- (NSString*)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section{
    
    return @"";
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender{

    NSIndexPath *indexPath =  [self.flexibleTableView indexPathForSelectedRow];
    id data = [self dataForRow:indexPath.row InSection:indexPath.section];
    GroceryStoresViewController *gsvc = (GroceryStoresViewController*)segue.destinationViewController;
    gsvc.location = (Location*)data;
    NSLog(@"stopper");
}





@end
