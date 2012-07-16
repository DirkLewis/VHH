//
//  SaleItemTableViewCell.m
//  iSaveGroceries
//
//  Created by Dirk on 2/19/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "SaleItemTableViewCell.h"
#import "ShoppingList.h"
@implementation SaleItemTableViewCell

@synthesize itemDescription = _itemDescription;
@synthesize itemWeight = _itemWeight;
@synthesize salePrice = _salePrice;
@synthesize regularPrice = _regularPrice;
@synthesize saleEndDate = _saleEndDate;
@synthesize comment = _comment;
@synthesize itemPurchaseNumber = _itemPurchaseNumber;
@synthesize stepper = _stepper;
+ (CGFloat)rowHeight{
    return 65;
}

+ (CGFloat)rowExpandedHeight{
    return 130;
}

+ (BOOL) isHeaderFooter{
    return NO;
}

+ (NSString *)reuseIdentifier{
    
    return @"SaleItemsCellIdentifier";
}

- (void)configureForData:(id)dataObject TableView:(UITableView *)tableView IndexPath:(NSIndexPath *)indexPath{
    
    SaleItem *item = (SaleItem*)dataObject;
    
    self.itemDescription.text = item.itemDescription;
    self.itemWeight.text = [NSString stringWithFormat:@"Wgt. %@", item.weight];
    self.regularPrice.text = [NSString stringWithFormat:@"Reg: %@", item.regularPrice];
    self.salePrice.text = [NSString stringWithFormat:@"Sale: %@",   item.salePrice];
    self.comment.text = item.comment;
    self.saleEndDate.text = [NSString stringWithFormat:@"Ends:%@", [NSString stringFromDate:item.saleEndDate withFormat:@"MM/dd"]];
    self.itemPurchaseNumber.text = [NSString stringWithFormat:@"%i Added",[item.saleItemToShoppingList count]];
    self.stepper.value = [item.saleItemToShoppingList count];

}

- (void)handleSelectionInTableView:(UITableView *)tableView{
    
	[tableView deselectRowAtIndexPath:[tableView indexPathForSelectedRow] animated:YES];
}

- (IBAction)touchStepper:(id)sender{

    UIStepper *stepper = (UIStepper*)sender;
    NSNumber *temp = [NSNumber numberWithDouble:[stepper value]];
    self.itemPurchaseNumber.text = [NSString stringWithFormat:@"%i Added",[temp intValue]];
    
    UITableView *tableView = (UITableView*)[self superview];
    NSIndexPath *indexPath = [tableView indexPathForCell:self];
    GroceryStoresViewController *flexController = (id)[tableView dataSource];
    SaleItem *saleItem = [flexController dataForRow:indexPath.row InSection:indexPath.section];
    ShoppingList *newListItem = [[iSaveRepository sharedInstance] insertNewEntityNamed:[ShoppingList className]];
    [saleItem addSaleItemToShoppingListObject:newListItem];
    
    [[iSaveRepository sharedInstance] save];
    
}

@end
