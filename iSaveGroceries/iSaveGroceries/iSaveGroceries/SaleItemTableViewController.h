//
//  SaleItemTableViewController.h
//  iSaveGroceries
//
//  Created by Dirk on 2/19/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "FlexibleViewControllerForTables.h"
@interface SaleItemTableViewController : FlexibleViewControllerForTables <FlexibleViewControllerForTablesProtocol, UISearchBarDelegate>

@property (strong,nonatomic)GroceryStore *groceryStore;
- (IBAction)touchStepper:(id)sender;
@property (strong, nonatomic) IBOutlet UISearchBar *searchBar;

@end
