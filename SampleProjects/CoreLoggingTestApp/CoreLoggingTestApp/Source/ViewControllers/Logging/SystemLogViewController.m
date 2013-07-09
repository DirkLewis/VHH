//
//  LoggingViewController.m
//  ROMobileUniversal
//
//  Created by Dirk Lewis on 11/18/11.
//  Copyright (c) 2011 Optima HCS. All rights reserved.
//

#import "SystemLogViewController.h"
#import <FlexibleTableLibrary/FlexiblePullToRefreshTableViewHeader.h>
#import <FlexibleTableLibrary/FlexibleTableStyleSheet.h>
#import <FlexibleTableLibrary/FlexibleTableDatasource.h>
#import "GeneralStyleSheet.h"
@interface SystemLogViewController ()

@property (strong,nonatomic) NSIndexPath *lastIndexPath;
@property (strong,nonatomic) NSMutableArray *people;
@property (strong,nonatomic) FlexiblePullToRefreshTableViewHeader *pullToRefreshHeaderView;
@property (assign,nonatomic) BOOL isLoading;
@property (strong,nonatomic) NSArray *sectionsArray;
@end


@implementation SystemLogViewController

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

/*
// Implement loadView to create a view hierarchy programmatically, without using a nib.
- (void)loadView
{
}
*/

- (void) viewWillAppear:(BOOL)animated {

    [GeneralStyleSheet styleTableForMenuList:self.tableView];
    
}


// Implement viewDidLoad to do additional setup after loading the view, typically from a nib.
- (void)viewDidLoad
{
    [self setTitle:@"Log Details"];
    
    self.flexibleDatasource = [[FlexibleTableDatasource alloc]init];
    self.tableView.dataSource = self.flexibleDatasource;
    [self.flexibleDatasource setAllowDeletes:YES];
    [self.flexibleDatasource setAllowMultipleCellSelection:YES];
    [self.flexibleDatasource setFlexibleDelegate:self];
    
    [GeneralStyleSheet styleTableForMenuList:self.tableView];
    
    if (!self.pullToRefreshHeaderView) {
        FlexiblePullToRefreshTableViewHeader *headerView = [[FlexiblePullToRefreshTableViewHeader alloc]initWithFrame:CGRectMake(0.0f, 0.0f - self.tableView.bounds.size.height, self.view.frame.size.width, self.tableView.bounds.size.height)];
        headerView.delegate = self;
        [self.tableView addSubview:headerView];
        self.pullToRefreshHeaderView = headerView;
    }
    
    
    [super viewDidLoad];
    [self refresh];
    
}

- (void)viewDidUnload
{
    [self setLogEntries:nil];
    [self setLogType:nil];
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
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

    [self.flexibleDatasource tableView:self.tableView addSectionAtIndex:0 withAnimation:UITableViewRowAnimationAutomatic];
        for (SystemLogEntry *logEntry in [self.logEntries sortedArrayUsingDescriptors:[SystemLogEntry sortDescriptorsForSystemLogEntries]]) {
            [self.flexibleDatasource tableView:self.tableView appendRowToSection:0 cellClass:[SystemLogViewCell class] cellData:logEntry withAnimation:UITableViewRowAnimationAutomatic];
    }

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
    
    SystemLogViewCell *cell =  (SystemLogViewCell*)[tableView cellForRowAtIndexPath:indexPath];

    if (cell.messageText.frame.size.width > 512) {
        NSString *oldText = cell.messageText.text;
        cell.messageText.text = @"";
        cell.messageText.text = oldText;
    }

    
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

@end
