//
//  SystemLogSummaryViewController.h
//  ROMobileUniversal
//
//  Created by JoseB on 2/23/12.
//  Copyright (c) 2012 Optima HCS. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <FlexibleTableLibrary/FlexibleTableDatasource.h>
#import <FlexibleTableLibrary/FlexibleTableViewProtocol.h>
#import <FlexibleTableLibrary/FlexiblePullToRefreshTableViewHeader.h>
#import "SystemLogSummaryTableViewCell.h"
#import "SystemLogViewController.h"

@interface SystemLogSummaryViewController : UITableViewController <FlexibleTableViewProtocol,FlexibleRefreshTableHeaderDelegate,FlexibleTableViewDelegate>

@property (strong, nonatomic) FlexibleTableDatasource *flexibleDatasource;

@end
