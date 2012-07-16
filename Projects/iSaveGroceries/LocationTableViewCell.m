//
//  LocationTableViewCell.m
//  iSaveGroceries
//
//  Created by Dirk on 2/11/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "LocationTableViewCell.h"
#import "LocationViewController.h"
#import "iSaveRepository.h"

@implementation LocationTableViewCell

@synthesize favoriteLocationButton = _favoriteLocationButton;
@synthesize titleLabel = _titleLabel;
@synthesize detailLabel = _detailLabel;


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
    
    //return @"LocationCellIdentifier";
    return @"LocationTouchCellIdentifier";
}

- (void)configureForData:(id)dataObject TableView:(UITableView *)tableView IndexPath:(NSIndexPath *)indexPath{

    Location *location = (Location*)dataObject;
    
    self.titleLabel.text = [NSString stringWithFormat:@"%@ (%@)", location.cityName,location.zipCode];
    self.detailLabel.text = location.countyName;

}

- (void)handleSelectionInTableView:(UITableView *)tableView{

	[tableView deselectRowAtIndexPath:[tableView indexPathForSelectedRow] animated:YES];
}

#pragma mark - Actions

- (IBAction)touchFavoriteLocation{
    
    UITableView *tableView = (UITableView*)[self superview];
    
    NSIndexPath *indexPath = [tableView indexPathForCell:self];
    
    LocationViewController *flexController = (id)[tableView dataSource];
    
    Location *location = [flexController dataForRow:indexPath.row InSection:indexPath.section];
    
    BOOL isFavorite = [location.favoriteLocation boolValue];
    
    UIImage *image;
    if (isFavorite) {
        image = [UIImage imageNamed:@"pebblesW"];
        location.favoriteLocation = [NSNumber numberWithBool:NO];
    }
    else{
        image = [UIImage imageNamed:@"pebblesG"];
        location.favoriteLocation = [NSNumber numberWithBool:YES];
    }
    
    [self.favoriteLocationButton setImage:image forState:UIControlStateNormal];
    [[iSaveRepository sharedInstance] save];
    
    
}

@end
