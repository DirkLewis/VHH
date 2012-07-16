//
//  GroceryStores.h
//  iSaveGroceries
//
//  Created by Dirk on 2/11/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface GroceryStoresViewController : FlexibleViewControllerForTables <FlexibleTableViewProtocol> 

@property (strong,nonatomic)Location *location;

@end
