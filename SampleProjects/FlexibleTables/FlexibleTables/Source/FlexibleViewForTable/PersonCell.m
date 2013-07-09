//
//  PersonCell.m
//  FlexibleTables
//
//  Created by Dirk Lewis on 7/24/12.
//  Copyright (c) 2012 Optima HCS. All rights reserved.
//

#import "PersonCell.h"

@implementation PersonCell
@synthesize personNameLabel;

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];
    
    // Configure the view for the selected state
}

+ (CGFloat)rowHeight{
    return 55;
}

+ (CGFloat)rowExpandedHeight{
    return 100;
}

+ (BOOL) isHeaderFooter{
    return NO;
}

- (void)configureForData:(id)dataObject tableView:(UITableView *)tableView indexPath:(NSIndexPath *)indexPath{
    
    NSDictionary *data = (NSDictionary*)dataObject;
    self.personNameLabel.text = [NSString stringWithFormat:@"%@ %@",[data valueForKey:@"firstName"],[data valueForKey:@"lastName"]];
    
}

//+ (NSString *)reuseIdentifier{
//    
//    return @"PersonCellIdentifyer";
//}

@end
