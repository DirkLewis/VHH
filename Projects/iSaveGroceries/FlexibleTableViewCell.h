//
//  ROCell.h
//  ROMobileUniversal
//
//  Created by Dirk Lewis on 2/3/12.
//  Copyright (c) 2012 Optima HCS. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface FlexibleTableViewCell : UITableViewCell
@property (nonatomic, weak) UIView *content;

+ (NSString *)reuseIdentifier;
+ (NSString *)nibName;
+ (UITableViewCellStyle)style;
+ (CGFloat)rowHeight;
+ (CGFloat)rowExpandedHeight;
+ (BOOL) isHeaderFooter;

- (void)configureForData:(id)dataObject TableView:(UITableView *)tableView IndexPath:(NSIndexPath *)indexPath;
//- (void)configureForData:(id)dataObject TableView:(UITableView *)tableView IndexPath:(NSIndexPath *)indexPath Storyboard:(UIStoryboard*)storyBoard;

- (void)finishConstruction;
- (void)handleSelectionInTableView:(UITableView *)tableView;
@end
