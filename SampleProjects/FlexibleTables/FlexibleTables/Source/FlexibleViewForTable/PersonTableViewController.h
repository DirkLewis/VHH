//
//  PersonTableViewController.h
//  FlexibleTables
//
//  Created by Dirk Lewis on 7/24/12.
//  Copyright (c) 2012 Optima HCS. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <FlexibleTableLibrary/FlexibleTableViewProtocol.h>
#import <FlexibleTableLibrary/FlexiblePullToRefreshTableViewHeader.h>

@class FlexibleTableDatasource;

@interface PersonTableViewController : UITableViewController <FlexibleTableViewProtocol,FlexibleRefreshTableHeaderDelegate,FlexibleTableViewDelegate>

@property (strong, nonatomic) FlexibleTableDatasource *flexibleDatasource;
- (IBAction)touchAddItem:(id)sender;

@end
