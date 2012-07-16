//
//  SaleItemTableViewController.m
//  iSaveGroceries
//
//  Created by Dirk on 2/19/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "SaleItemTableViewController.h"
#import "SaleItemTableViewCell.h"
@implementation SaleItemTableViewController{

    NSArray *_categories;
    NSString *_searchText;

}
@synthesize searchBar = _searchBar;

@synthesize groceryStore = _groceryStore;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)didReceiveMemoryWarning
{
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
    
    // Release any cached data, images, etc that aren't in use.
}

#pragma mark - View lifecycle

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    [VHHStyleSheet styleTableForMenuList:self.flexibleTableView];
    self.useCustomHeaders = YES;
    self.allowMultipleCellSelection = NO;
    [self refresh];

}

- (void)viewDidUnload
{
    [self setSearchBar:nil];
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Return YES for supported orientations
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

#pragma mark - Flexible Tables
- (void)createRows{
    
    if ([_searchText length] == 0) {
        _categories = [SaleItem fetchArrayOfSortedCategoriesForStore:self.groceryStore];
        
        for (int i = 0; i < [_categories count]; i++) {
            NSArray *items = [SaleItem fetchArrayOfAllSaleItemsSortedByDescriptionForStore:self.groceryStore inCategory:[_categories objectAtIndex:i]];
            [self addSectionAtIndex:i WithAnimation:UITableViewRowAnimationAutomatic];
            for (SaleItem *item in items) {
                [self appendRowToSection:i CellClass:[SaleItemTableViewCell class] CellData:item WithAnimation:UITableViewRowAnimationAutomatic];
                
            }
            
        } 
        [self.searchBar resignFirstResponder];
    }
    else{
    
        _categories = nil;
        NSArray *items = [SaleItem fetchArrayOfAllSaleItemsSortedByDescriptionForStore:self.groceryStore inCategory:0 containing:_searchText];
        [self addSectionAtIndex:0 WithAnimation:UITableViewRowAnimationAutomatic];
        for (SaleItem *item in items) {
            [self appendRowToSection:0 CellClass:[SaleItemTableViewCell class] CellData:item WithAnimation:UITableViewRowAnimationAutomatic];
            
        }
        [self.searchBar becomeFirstResponder];
    }
    
   
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
    [self.searchBar resignFirstResponder];
    
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
    
    return [_categories objectAtIndex:section];
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender{
    

    
}
- (IBAction)touchStepper:(id)sender {
    
}

#pragma mark - Search delegates

- (void)searchBarSearchButtonClicked:(UISearchBar *)searchBar{

    [self.searchBar resignFirstResponder];


}
- (void)searchBar:(UISearchBar *)searchBar textDidChange:(NSString *)searchText{
    
    _searchText = searchText;
    [self refresh];


}

@end
