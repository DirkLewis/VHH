//
//  SystemLogSummaryViewController.m
//  ROMobileUniversal
//
//  Created by JoseB on 2/23/12.
//  Copyright (c) 2012 Optima HCS. All rights reserved.
//

#import "SystemLogSummaryViewController.h"
#import <FlexibleTableLibrary/FlexiblePullToRefreshTableViewHeader.h>
#import <FlexibleTableLibrary/FlexibleTableStyleSheet.h>
#import <FlexibleTableLibrary/FlexibleTableDatasource.h>
#import "SystemLogEntry.h"
#import "GeneralStyleSheet.h"

@interface SystemLogSummaryViewController ()

@property (strong,nonatomic) NSIndexPath *lastIndexPath;
@property (strong,nonatomic) NSMutableArray *people;
@property (strong,nonatomic) FlexiblePullToRefreshTableViewHeader *pullToRefreshHeaderView;
@property (assign,nonatomic) BOOL isLoading;
@property (strong,nonatomic) NSArray *sectionsArray;
@end

@implementation SystemLogSummaryViewController

#pragma mark - View lifecycle

- (void)viewDidLoad
{
    [self.parentViewController setTitle:@"Log"];

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
    [super viewDidLoad];

    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
 
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
}

- (void)viewDidUnload
{
    [super viewDidUnload];
    
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (void) viewWillAppear:(BOOL)animated {
    
    [GeneralStyleSheet styleTableForMenuList:self.tableView];
    self.tabBarController.navigationItem.rightBarButtonItem = nil;
    
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
  
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


#pragma mark - FlexibleTableViewDelegate

- (void)createRows {
    
    NSArray *systemLogEntries = [SystemLogEntry fetchArrayOfAllSystemLogEntries];
    NSArray *authenticationLogEntries = [SystemLogEntry fetchArrayOfAllAuthenticationLogEntries];
    NSArray *accessLogEntries = [SystemLogEntry fetchArrayOfAllAccessLogEntries];
    NSArray *documentationLogEntries = [SystemLogEntry fetchArrayOfAllDocumentLogEntries];
    NSArray *perfLogEntries = [SystemLogEntry fetchArrayOfAllPerformanceLogEntries];
    
    NSDictionary *systemLogDictionary = [NSDictionary dictionaryWithObjects:[NSArray arrayWithObjects:@"System",systemLogEntries, nil] 
                                                                    forKeys:[NSArray arrayWithObjects:@"title", @"logEntries", nil]]; 
    
    NSDictionary *authenticationLogDictionary = [NSDictionary dictionaryWithObjects:[NSArray arrayWithObjects:@"Authentication",authenticationLogEntries, nil] 
                                                                            forKeys:[NSArray arrayWithObjects:@"title", @"logEntries", nil]];
    
    NSDictionary *accessLogDictionary = [NSDictionary dictionaryWithObjects:[NSArray arrayWithObjects:@"Access",accessLogEntries, nil]
                                                                    forKeys:[NSArray arrayWithObjects:@"title", @"logEntries", nil]];
    
    NSDictionary *documentationLogDictionary = [NSDictionary dictionaryWithObjects:[NSArray arrayWithObjects:@"Documentation",documentationLogEntries, nil] 
                                                                           forKeys:[NSArray arrayWithObjects:@"title", @"logEntries", nil]];
    
    NSDictionary *performanceLogDictionary = [NSDictionary dictionaryWithObjects:[NSArray arrayWithObjects:@"Performance",perfLogEntries, nil] 
                                                                         forKeys:[NSArray arrayWithObjects:@"title",@"logEntries", nil]];
    
    
    
    [self.flexibleDatasource tableView:self.tableView addSectionAtIndex:0 withAnimation:UITableViewRowAnimationAutomatic];

    [self.flexibleDatasource tableView:self.tableView appendRowToSection:0 cellClass:[SystemLogSummaryTableViewCell class] cellData:systemLogDictionary withAnimation:UITableViewRowAnimationAutomatic];

    [self.flexibleDatasource tableView:self.tableView appendRowToSection:0 cellClass:[SystemLogSummaryTableViewCell class] cellData:authenticationLogDictionary withAnimation:UITableViewRowAnimationAutomatic];

    [self.flexibleDatasource tableView:self.tableView appendRowToSection:0 cellClass:[SystemLogSummaryTableViewCell class] cellData:accessLogDictionary withAnimation:UITableViewRowAnimationAutomatic];

    [self.flexibleDatasource tableView:self.tableView appendRowToSection:0 cellClass:[SystemLogSummaryTableViewCell class] cellData:documentationLogDictionary withAnimation:UITableViewRowAnimationAutomatic];

    [self.flexibleDatasource tableView:self.tableView appendRowToSection:0 cellClass:[SystemLogSummaryTableViewCell class] cellData:performanceLogDictionary withAnimation:UITableViewRowAnimationAutomatic];

}

- (void)refreshWithDelay:(NSTimeInterval)delay {
	[self.flexibleDatasource tableView:self.tableView removeAllSectionsWithAnimation:UITableViewRowAnimationFade];
	[self performSelector:@selector(createRows) withObject:nil afterDelay:delay];
}

- (void)refresh {
    [self refreshWithDelay:0.0];
}

#pragma mark - TableView delegate methods

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    [self.tableView deselectRowAtIndexPath:indexPath animated:YES];
    
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
    
    [self.tableView beginUpdates];
    [self.tableView endUpdates];
    
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

- (void)tableView:(UITableView *)tableView accessoryButtonTappedForRowWithIndexPath:(NSIndexPath *)indexPath {
    
    SystemLogSummaryTableViewCell *cell = (SystemLogSummaryTableViewCell*)[self.tableView cellForRowAtIndexPath:indexPath];
 
    SystemLogViewController *destinationVC = [[self storyboard] instantiateViewControllerWithIdentifier:@"SystemLogViewControllerIdentifier"];
    
    destinationVC.logType = cell.logType;
    destinationVC.logEntries = cell.logEntries;
    
    [self.navigationController pushViewController:destinationVC animated:YES];
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section {
    return @"";
}

@end
