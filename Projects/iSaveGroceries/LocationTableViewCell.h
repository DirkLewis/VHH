//
//  LocationTableViewCell.h
//  iSaveGroceries
//
//  Created by Dirk on 2/11/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "FlexibleTableViewCell.h"

@interface LocationTableViewCell : FlexibleTableViewCell

@property (strong,nonatomic) IBOutlet UIButton *favoriteLocationButton;
@property (strong,nonatomic) IBOutlet UILabel *titleLabel;
@property (strong,nonatomic) IBOutlet UILabel *detailLabel;

- (IBAction)touchFavoriteLocation;
@end
