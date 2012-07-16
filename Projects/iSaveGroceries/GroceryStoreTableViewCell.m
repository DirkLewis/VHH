//
//  GroceryStoreTableViewCell.m
//  iSaveGroceries
//
//  Created by Dirk on 2/12/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "GroceryStoreTableViewCell.h"
#import "GroceryStoresViewController.h"
@implementation GroceryStoreTableViewCell{

}

@synthesize favoriteButton = _favoriteButton;
@synthesize titleLabel = _titleLabel;
@synthesize detailLabel = _detailLabel;
@synthesize lastUpdatedLabel = _lastUpdatedLabel;
+ (CGFloat)rowHeight{
    return 55;
}

+ (CGFloat)rowExpandedHeight{
    return 55;
}

+ (BOOL) isHeaderFooter{
    return NO;
}

+ (NSString *)reuseIdentifier{
    
    return @"GroceryStoreCellIdentifier";
}


- (void)configureForData:(id)dataObject TableView:(UITableView *)tableView IndexPath:(NSIndexPath *)indexPath{
    
    GroceryStore *store = (GroceryStore*)dataObject;
    self.titleLabel.text = [NSString stringWithFormat:@"%@",store.groceryStoreName];
    self.detailLabel.text = [NSString stringWithFormat:@"%@",store.numberOfSaleItems];
    if (store.lastUpdated) {
        self.lastUpdatedLabel.text = [NSString stringWithFormat:@"Last Update: %@", [NSString stringFromDate:store.lastUpdated withFormat:@"MM/dd"]];
    }
    else{
        self.lastUpdatedLabel.text = [NSString stringWithFormat:@"Last Update: %@", @"??"];
    }
    
    if ([store favoriteStoreValue]) {
        [self.favoriteButton setImage:[UIImage imageNamed:@"pebblesG"] forState:UIControlStateNormal];
    }
    else{
        [self.favoriteButton setImage:[UIImage imageNamed:@"pebblesW"] forState:UIControlStateNormal];

    }
    
}

- (void)handleSelectionInTableView:(UITableView *)tableView{
    
}

#pragma mark - Actions
- (IBAction)touchFavorite:(id)sender{

    UITableView *tableView = (UITableView*)[self superview];
    
    NSIndexPath *indexPath = [tableView indexPathForCell:self];
    
    GroceryStoresViewController *flexController = (id)[tableView dataSource];
    
    GroceryStore *store = [flexController dataForRow:indexPath.row InSection:indexPath.section];
    
    BOOL isFavorite = [store.favoriteStore boolValue];
    
    UIImage *image;
    if (isFavorite) {
        image = [UIImage imageNamed:@"pebblesW"];
        store.favoriteStore = [NSNumber numberWithBool:NO];
    }
    else{
        image = [UIImage imageNamed:@"pebblesG"];
        store.favoriteStore = [NSNumber numberWithBool:YES];
    }
    
    [self.favoriteButton setImage:image forState:UIControlStateNormal];
    [[iSaveRepository sharedInstance] save];
}






@end
