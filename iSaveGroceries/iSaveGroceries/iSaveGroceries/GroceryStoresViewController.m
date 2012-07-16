//
//  GroceryStores.m
//  iSaveGroceries
//
//  Created by Dirk on 2/11/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "GroceryStoresViewController.h"
#import "SaleItemTableViewController.h"

@interface GroceryStoresViewController ( Private )

- (void)saleItemsByGroceryStore:(GroceryStore*)groceryStore;
@end

@implementation GroceryStoresViewController{

    BOOL _isLoading;
    int _countDown;
}

@synthesize location = _location;

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
    if (!self.pullToRefreshHeaderView) {
        FlexiblePullToRefreshTableViewHeader *headerView = [[FlexiblePullToRefreshTableViewHeader alloc]initWithFrame:CGRectMake(0.0f, 0.0f - self.flexibleTableView.bounds.size.height, self.view.frame.size.width, self.flexibleTableView.bounds.size.height)];
        headerView.delegate = self;
        [self.flexibleTableView addSubview:headerView];
        self.pullToRefreshHeaderView = headerView;
    }
    [self refresh];
    

}

- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Return YES for supported orientations
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}


- (void)createRows{
    
    [self addSectionAtIndex:0 WithAnimation:UITableViewRowAnimationAutomatic];
    NSArray *sortedStores = [[_location.locationToStore allObjects]sortedArrayUsingDescriptors:[GroceryStore sortDescriptorsForGroceryStores]]; 
    for (GroceryStore *store in sortedStores) {
        [self appendRowToSection:0 CellClass:[GroceryStoreTableViewCell class] CellData:store WithAnimation:UITableViewRowAnimationAutomatic];
    }
}


- (void)refresh{
    
    [self refreshWithDelay:0.0];
    
}

- (void)refreshWithDelay:(NSTimeInterval)delay{
    
	[self removeAllSectionsWithAnimation:UITableViewRowAnimationFade];
	[self performSelector:@selector(createRows) withObject:nil afterDelay:delay];
}

#pragma mark - Pull To Refresh

- (void)scrollViewDidScroll:(UIScrollView *)scrollView{
    
    [self.pullToRefreshHeaderView flexibleRefreshScrollViewDidScroll:scrollView];
}

- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate{
    
    [self.pullToRefreshHeaderView flexibleRefreshScrollViewDidEndDragging:scrollView];
}

- (void)flexibleRefreshTableHeaderDidTriggerRefresh:(FlexiblePullToRefreshTableViewHeader *)view{
    
    _isLoading = YES;
    
    NSArray *stores = [[self.location.locationToStore allObjects]filteredArrayUsingPredicate:[NSPredicate predicateWithFormat:@" favoriteStore == YES"]];
    _countDown = [stores count];
    for (GroceryStore *groceryStore in stores) {

        if (groceryStore.favoriteStore) {
            
            [self saleItemsByGroceryStore:groceryStore];

        }
    }
}

- (BOOL)flexibleRefreshTableHeaderDataSourceIsLoading:(FlexiblePullToRefreshTableViewHeader *)view{
    
    return _isLoading;
}

- (NSDate*)flexibleRefreshTableHeaderDataSourceLastUpdated:(FlexiblePullToRefreshTableViewHeader *)view{
    return [NSDate date];
}

- (void)saleItemsByGroceryStore:(GroceryStore*)groceryStore{

    [SmartSource requestSaleItemsByGroceryStore:groceryStore results:^(id resultsData) {
        
        NSString *result = resultsData;
        NSArray *saleItems = [SmartSourceElementParser parseGrocerySaleItems:result];
        [SaleItem storeSaleItemFromArray:saleItems groceryStore:groceryStore];        
        groceryStore.numberOfSaleItems = [NSNumber numberWithInt:[saleItems count]];
        [[iSaveRepository sharedInstance] save];
        groceryStore.lastUpdated = [NSDate date];
        _countDown --;
        if (_countDown == 0) {
            _isLoading = NO;
            [self.pullToRefreshHeaderView flexibleRefreshScrollViewDataSourceDidFinishedLoading:self.flexibleTableView];
            [self refresh];

        }
        
    }];
}

#pragma mark - TableView delegate methods

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    [super tableView:tableView didSelectRowAtIndexPath:indexPath];
    
    /////////////////////
    GroceryStore* groceryStore = (GroceryStore*)[self dataForRow:indexPath.row InSection:indexPath.section];

    NSDate *saleExpires = [groceryStore saleItemsExpireyDate];
    
    if (![saleExpires isInFuture]) {
        [self showHUDWithText:@"Getting Sales"];

        [SmartSource requestSaleItemsByGroceryStore:groceryStore results:^(id resultsData) {
            
            NSString *result = resultsData;
            NSArray *saleItems = [SmartSourceElementParser parseGrocerySaleItems:result];
            [SaleItem storeSaleItemFromArray:saleItems groceryStore:groceryStore];
            NSLog(@"stopper - %@",saleItems);
            
            groceryStore.numberOfSaleItems = [NSNumber numberWithInt:[saleItems count]];
            groceryStore.lastUpdated = [NSDate date];
            [[iSaveRepository sharedInstance] save];
            [self hideHUDWithText:[NSString stringWithFormat:@"%i sales found",[saleItems count]]];
            
            SaleItemTableViewController *saleItemVC = [self.storyboard instantiateViewControllerWithIdentifier:@"SaleItemsViewController"];
            saleItemVC.groceryStore = groceryStore;
            
            [self refresh];
            [self.navigationController pushViewController:saleItemVC animated:YES];
            
        }];
    }
    else{
        SaleItemTableViewController *saleItemVC = [self.storyboard instantiateViewControllerWithIdentifier:@"SaleItemsViewController"];
        saleItemVC.groceryStore = groceryStore;
        
        [self refresh];
        [self.navigationController pushViewController:saleItemVC animated:YES];
    
    }

    
    
    ////////////////////
    
//    Class cellClass = [self cellClassForRow:indexPath.row InSection:indexPath.section];
//    if ([cellClass isHeaderFooter] && [indexPath row] == 0) {
//        return;
//    }
//    
//    if ([cellClass isHeaderFooter] && [[self sectionAtIndex:[indexPath section]]count] - 1 == [indexPath row]) {
//        return;
//    }
//    
//    // Toggle 'selected' state
//    BOOL isSelected = ![self cellIsSelected:indexPath];
//    // Store cell 'selected' state keyed on indexPath
//    NSNumber *selectedIndex = [NSNumber numberWithBool:isSelected];
//    [self setCellIsSelected:selectedIndex forKey:indexPath];
//    
//    [self.flexibleTableView beginUpdates];
//    [self.flexibleTableView endUpdates];
    
    
    
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
    
//    GroceryStoreTableViewCell *cell = (GroceryStoreTableViewCell*)sender;
//    NSIndexPath *indexPath =  [self indexPathForFlexibleCell:cell];
//    id data = [self dataForRow:indexPath.row InSection:indexPath.section];
//    NSLog(@"stopper - %@",data);

}
@end
