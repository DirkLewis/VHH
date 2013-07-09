//
//  FlexibleTableDatasource.h
//  FlexibleTables
//
//  Created by Dirk Lewis on 7/24/12.
//  Copyright (c) 2012 Optima HCS. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "FlexibleTableViewProtocol.h"

@class FlexibleTableViewCell;

@interface FlexibleTableDatasource : NSObject <UITableViewDataSource>

@property (nonatomic,assign) BOOL allowMultipleCellSelection;
@property (nonatomic,copy)  NSArray *sectionsArray;
@property (nonatomic,copy) NSArray *sectionIndexDisplayArray;
@property (nonatomic,assign) BOOL allowDeletes;
@property (nonatomic,assign) BOOL allowMoves;

@property (nonatomic,assign) id<FlexibleTableViewDelegate> flexibleDelegate;

- (NSArray *)sectionAtIndex:(NSInteger)sectionIndex;
- (id)dataForIndexPath:(NSIndexPath*)indexPath;
- (NSArray *)allDataInSection:(NSInteger)sectionIndex;
- (void)tableView:(UITableView*)tableView setData:(id)dataObject forIndexPath:(NSIndexPath*)indexPath;
- (void)tableView:(UITableView*)tableView refreshCellForIndexPath:(NSIndexPath*)indexPath;
- (Class)cellClassForIndexPath:(NSIndexPath*)indexPath;
- (void)tableView:(UITableView*)tableView addSectionAtIndex:(NSInteger)sectionIndex withAnimation:(UITableViewRowAnimation)animation;
- (void)tableView:(UITableView*)tableView removeRowAtIndexPath:(NSIndexPath*)indexPath withAnimation:(UITableViewRowAnimation)animation;
- (void)tableView:(UITableView*)tableView removeAllSectionsWithAnimation:(UITableViewRowAnimation)animation;
- (void)tableView:(UITableView*)tableView appendRowToSection:(NSInteger)sectionIndex cellClass:(Class)cellClass cellData:(id)cellData withAnimation:(UITableViewRowAnimation)animation;
- (void)tableView:(UITableView*)tableView addRowAtIndexPath:(NSIndexPath*)indexPath cellClass:(Class)cellClass cellData:(id)cellData withAnimation:(UITableViewRowAnimation)animation;
- (void)tableView:(UITableView*)tableView emptySectionAtIndex:(NSInteger)sectionIndex withAnimation:(UITableViewRowAnimation)animation;
- (void)tableView:(UITableView*)tableView removeSectionAtIndex:(NSInteger)sectionIndex withAnimation:(UITableViewRowAnimation)animation;
- (BOOL)cellIsSelected:(NSIndexPath *)indexPath;
- (void)setCellIsSelected:(NSNumber*)selectedIndex forKey:(id)key;
- (NSIndexPath*)tableView:(UITableView*)tableView indexPathForFlexibleCell:(FlexibleTableViewCell*)flexibleCell;
- (NSNumber*)numberOfRowsInSection:(NSIndexPath*)indexPath;
- (void)tableView:(UITableView*)tableView addRowAtIndexPath:(NSIndexPath*)indexPath cellClass:(Class)cellClass cellData:(id)cellData backgroundViewClass:(Class)backgroundViewClass selectedBackgroundViewClass:(Class)selectedBackgroundViewClass withAnimation:(UITableViewRowAnimation)animation;
- (void)tableView:(UITableView*)tableView appendRowToSection:(NSInteger)sectionIndex cellClass:(Class)cellClass cellData:(id)cellData backgroundViewClass:(Class)backgroundViewClass selectedBackgroundViewClass:(Class)selectedBackgroundViewClass withAnimation:(UITableViewRowAnimation)animation;


@end
