//
//  MasterViewController.h
//  FlexibleFetchedResults
//
//  Created by Dirk Lewis on 8/31/12.
//  Copyright (c) 2012 VHH. All rights reserved.
//

#import <UIKit/UIKit.h>
@class FlexibleFRCTableDatasource;

@interface MasterViewController : UITableViewController

@property (strong,nonatomic)FlexibleFRCTableDatasource *flexibleDatasource;

@end
