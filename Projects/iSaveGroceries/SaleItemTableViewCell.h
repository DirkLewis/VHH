//
//  SaleItemTableViewCell.h
//  iSaveGroceries
//
//  Created by Dirk on 2/19/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "FlexibleTableViewCell.h"

@interface SaleItemTableViewCell : FlexibleTableViewCell

@property (strong,nonatomic)IBOutlet UILabel *itemDescription;
@property (strong,nonatomic)IBOutlet UILabel *regularPrice;
@property (strong,nonatomic)IBOutlet UILabel *salePrice;
@property (strong,nonatomic)IBOutlet UILabel *itemWeight;
@property (strong,nonatomic)IBOutlet UILabel *saleEndDate;
@property (strong,nonatomic)IBOutlet UILabel *comment;
@property (strong,nonatomic)IBOutlet UILabel *itemPurchaseNumber;
@property (strong,nonatomic)IBOutlet UIStepper *stepper;
- (IBAction)touchStepper:(id)sender;


@end
