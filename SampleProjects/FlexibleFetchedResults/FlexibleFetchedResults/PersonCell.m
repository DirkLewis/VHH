//
//  PersonCell.m
//  FlexibleFetchedResults
//
//  Created by Dirk Lewis on 9/1/12.
//  Copyright (c) 2012 VHH. All rights reserved.
//

#import "PersonCell.h"
#import "Person.h"
@implementation PersonCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
    }
    return self;
}

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
    
    Person *data = (Person*)dataObject;
    self.personNameLabel.text = [NSString stringWithFormat:@"%@ %@",data.firstName,data.lastName];
    
}

@end
