//
//  PersonTableViewController.m
//  FlexibleTables
//
//  Created by Dirk Lewis on 7/24/12.
//  Copyright (c) 2012 Optima HCS. All rights reserved.
//

#import "PersonTableViewController.h"
#import "PersonCell.h"
#import <FlexibleTableLibrary/FlexiblePullToRefreshTableViewHeader.h>
#import <FlexibleTableLibrary/FlexibleTableStyleSheet.h>
#import <FlexibleTableLibrary/FlexibleTableDatasource.h>

#import "NSArray+TableViewSections.h"
#import "CustomTableHeader.h"
#import "CustomTableFooter.h"
#import "CustomCellBackground.h"
#import "GeneralStyleSheet.h"
#import "NSString+ROAdditions.h"
@interface PersonTableViewController ()

@property (strong,nonatomic) NSIndexPath *lastIndexPath;
@property (strong,nonatomic) NSMutableArray *people;
@property (strong,nonatomic) FlexiblePullToRefreshTableViewHeader *pullToRefreshHeaderView;
@property (assign,nonatomic) BOOL isLoading;
@property (strong,nonatomic) NSArray *sectionsArray;
@end

@implementation PersonTableViewController

- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (NSDictionary*)dictionaryWithFirstName:(NSString*)firstName andLastName:(NSString*)lastName{

    NSMutableDictionary *person = [NSMutableDictionary dictionary];
    [person setValue:firstName forKey:@"firstName"];
    [person setValue:lastName forKey:@"lastName"];
    [person setValue:[NSString stringWithNewGuid] forKey:@"personID"];
    return (NSDictionary*)person;

}
- (void)viewDidLoad
{
    [super viewDidLoad];
    self.people = [NSMutableArray array];

    [self.people addObject:[self dictionaryWithFirstName:@"John" andLastName:@"Doe"]];
    [self.people addObject:[self dictionaryWithFirstName:@"Jane" andLastName:@"Koe"]];
    [self.people addObject:[self dictionaryWithFirstName:@"Baby" andLastName:@"Soe"]];

    self.flexibleDatasource = [[FlexibleTableDatasource alloc]init];
    self.tableView.dataSource = self.flexibleDatasource;
    [self.flexibleDatasource setAllowDeletes:YES];
    //[self.flexibleDatasource setAllowMoves:YES];
    [self.flexibleDatasource setAllowMultipleCellSelection:YES];
    [self.flexibleDatasource setFlexibleDelegate:self];
    
    [GeneralStyleSheet styleTableForMenuList:self.tableView];
    
    if (!self.pullToRefreshHeaderView) {
        FlexiblePullToRefreshTableViewHeader *headerView = [[FlexiblePullToRefreshTableViewHeader alloc]initWithFrame:CGRectMake(0.0f, 0.0f - self.tableView.bounds.size.height, self.view.frame.size.width, self.tableView.bounds.size.height)];
        headerView.delegate = self;
        [self.tableView addSubview:headerView];
        self.pullToRefreshHeaderView = headerView;
    }
    
    [self refresh];

    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
 
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
}

- (void)viewWillAppear:(BOOL)animated{
    
    if (self.lastIndexPath) {
        [self.flexibleDatasource tableView:self.tableView refreshCellForIndexPath:self.lastIndexPath];
    }
    [super viewWillAppear:animated];
}

- (void)viewDidUnload
{
    [self setFlexibleDatasource:nil];
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

#pragma mark - Pull To Refresh

- (void)scrollViewDidScroll:(UIScrollView *)scrollView{
    
    [self.pullToRefreshHeaderView flexibleRefreshScrollViewDidScroll:scrollView];
}

- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate{
    
    [self.pullToRefreshHeaderView flexibleRefreshScrollViewDidEndDragging:scrollView];
}

- (void)flexibleRefreshTableHeaderDidTriggerRefresh:(FlexiblePullToRefreshTableViewHeader *)view{
    
    [self refreshWithDelay:2.0f];
    
}

- (BOOL)flexibleRefreshTableHeaderDataSourceIsLoading:(FlexiblePullToRefreshTableViewHeader *)view{
    
    return self.isLoading;
}

- (NSDate*)flexibleRefreshTableHeaderDataSourceLastUpdated:(FlexiblePullToRefreshTableViewHeader *)view{
    return [NSDate date];
}

#pragma mark - Flex Protocol

- (void)createRows{
    
    self.sectionsArray = [self.people sectionsForKeyName:@"lastName" andSectionList:[[UILocalizedIndexedCollation currentCollation]sectionIndexTitles]];
    [self.flexibleDatasource setSectionsArray:self.sectionsArray];
    [self.flexibleDatasource setSectionIndexDisplayArray:[[UILocalizedIndexedCollation currentCollation]sectionIndexTitles]];
    //[self.flexibleDatasource setSectionIndexDisplayArray:self.sectionsArray];

    NSDictionary *peopleBySection = [self.people sectionedDataForKeyname:@"lastName" andSectionList:[[UILocalizedIndexedCollation currentCollation]sectionIndexTitles]];
    self.isLoading = YES;

    for (NSString *section in self.sectionsArray) {
        [self.flexibleDatasource tableView:self.tableView addSectionAtIndex:[self.sectionsArray indexOfObject:section] withAnimation:UITableViewRowAnimationAutomatic];
        for (NSDictionary *person in [peopleBySection valueForKey:section]) {
            //[self.flexibleDatasource tableView:self.tableView appendRowToSection:[self.sectionsArray indexOfObject:section] cellClass:[PersonCell class] cellData:person backgroundViewClass:[CustomCellBackground class] selectedBackgroundViewClass:[CustomCellBackground class] withAnimation:UITableViewRowAnimationAutomatic];
            [self.flexibleDatasource tableView:self.tableView appendRowToSection:[self.sectionsArray indexOfObject:section] cellClass:[PersonCell class] cellData:person withAnimation:UITableViewRowAnimationAutomatic];
        }
    }
    
    self.isLoading = NO;
    [self.pullToRefreshHeaderView flexibleRefreshScrollViewDataSourceDidFinishedLoading:self.tableView];

    NSLog(@"stopper");
}
- (void)refreshWithDelay:(NSTimeInterval)delay {
    
	[self.flexibleDatasource tableView:self.tableView removeAllSectionsWithAnimation:UITableViewRowAnimationFade];
	[self performSelector:@selector(createRows) withObject:nil afterDelay:delay];
    [self.pullToRefreshHeaderView refreshLastUpdatedDate];

}

- (void)refresh {
    
    [self refreshWithDelay:0.0];
}

- (void)flexibleTableDataRemoved:(id)data indexPath:(NSIndexPath *)indexPath{

    NSLog(@"%@",data);
    NSLog(@"%@",self.people);
    [self.people removeObject:data];
    NSLog(@"%@",self.people);
    NSLog(@"stopper");
    
    if ([[self.flexibleDatasource numberOfRowsInSection:indexPath]intValue] == 0) {
        [self refresh];
    }
    NSLog(@"stopper");
}

#pragma mark - Table view delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];    

    _lastIndexPath = indexPath;
    Class cellClass = [self.flexibleDatasource cellClassForIndexPath:indexPath];
    if ([cellClass isHeaderFooter] && [indexPath row] == 0) {
        return;
    }
    
    if ([cellClass isHeaderFooter] && [[self.flexibleDatasource sectionAtIndex:[indexPath section]]count] - 1 == [indexPath row]) {
        return;
    }
    
    // Toggle 'selected' state
    BOOL isSelected = ![self.flexibleDatasource cellIsSelected:indexPath];
    // Store cell 'selected' state keyed on indexPath
    NSNumber *selectedIndex = [NSNumber numberWithBool:isSelected];
    [self.flexibleDatasource setCellIsSelected:selectedIndex forKey:indexPath];
    
   // ((CustomCellBackground*)[tableView cellForRowAtIndexPath:indexPath].selectedBackgroundView).selected = isSelected;
    
    [tableView beginUpdates];
    [tableView endUpdates];
    
    NSLog(@"stopper");
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    Class cellClass = [self.flexibleDatasource cellClassForIndexPath:indexPath];
    
    if ([cellClass isHeaderFooter] && [indexPath row] == 0) {
        return [cellClass rowHeight];
    }
    
    if ([cellClass isHeaderFooter] && [[self.flexibleDatasource sectionAtIndex:[indexPath section]]count] - 1 == [indexPath row]) {
        return [cellClass rowHeight];
    }  
    
    if ([self.flexibleDatasource cellIsSelected:indexPath]) {
        
        return [cellClass rowExpandedHeight];
    }
    else{
        return [cellClass rowHeight];
    }
}

- (NSString*)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section{
    
    return [self.sectionsArray objectAtIndex:section];
}

- (UIView*)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    
    //allocate the view if it doesn't exist yet
    UIView *headerView  = [[UIView alloc] init];
    headerView.backgroundColor = [UIColor clearColor];
    
    //crete the labels
    UILabel *fieldName = [[UILabel alloc] initWithFrame:CGRectMake(20, 2, 320, 20)];
    //    fieldName.tag = kFieldLabelTag;
    [fieldName setBackgroundColor:[UIColor clearColor]];
    [fieldName setFont:[UIFont boldSystemFontOfSize:14]];
    [fieldName setTextColor:[UIColor darkGrayColor]];
    [fieldName setText:[self tableView:tableView titleForHeaderInSection:section]];
    
    [headerView addSubview:fieldName];
    
    return headerView;
}

//- (UIView*)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section{
//    
//    
//    CustomTableFooter *footer = nil;
//    if ([[self.flexibleDatasource allDataInSection:section]count] > 0) {
//        footer = [[CustomTableFooter alloc]init];
//        
//    }
//    return footer;
//}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    
    return 30;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    
    return 15;
}

#pragma mark - Actions

- (IBAction)touchAddItem:(id)sender {
    [self.people addObject:[self dictionaryWithFirstName:@"Test" andLastName:@"Doe"]];
    [self.people addObject:[self dictionaryWithFirstName:@"Test" andLastName:@"Koe"]];
    [self.people addObject:[self dictionaryWithFirstName:@"Test" andLastName:@"Soe"]];

    [self refresh];
}
@end
