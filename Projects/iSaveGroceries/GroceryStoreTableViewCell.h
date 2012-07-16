//
//  GroceryStoreTableViewCell.h
//  iSaveGroceries
//
//  Created by Dirk on 2/12/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "FlexibleTableViewCell.h"

@interface GroceryStoreTableViewCell : FlexibleTableViewCell

@property (strong,nonatomic) IBOutlet UIButton *favoriteButton;
@property (strong,nonatomic) IBOutlet UILabel *titleLabel;
@property (strong,nonatomic) IBOutlet UILabel *detailLabel;
@property (strong,nonatomic) IBOutlet UILabel *lastUpdatedLabel;

- (IBAction)touchFavorite:(id)sender;

@end
