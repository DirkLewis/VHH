//
//  LoggingViewController.h
//  ROMobileUniversal
//
//  Created by Dirk Lewis on 11/18/11.
//  Copyright (c) 2011 Optima HCS. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <FlexibleTableLibrary/FlexibleTableDatasource.h>
#import <FlexibleTableLibrary/FlexibleTableViewProtocol.h>
#import <FlexibleTableLibrary/FlexiblePullToRefreshTableViewHeader.h>
#import "SystemLogViewCell.h"

@interface SystemLogViewController : UITableViewController <FlexibleTableViewProtocol,FlexibleRefreshTableHeaderDelegate,FlexibleTableViewDelegate>

@property (strong, nonatomic) FlexibleTableDatasource *flexibleDatasource;
@property (strong, nonatomic) NSArray *logEntries; 
@property (strong, nonatomic) NSString *logType;

@end
