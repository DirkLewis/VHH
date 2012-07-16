//
//  FlexibleTableViewController.h
//  ROMobileUniversal
//
//  Created by Dirk Lewis on 2/8/12.
//  Copyright (c) 2012 Optima HCS. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "VHHUIViewController.h"
#import "FlexiblePullToRefreshTableViewHeader.h"
@class FlexibleTableViewCell;

@interface FlexibleViewControllerForTables : VHHUIViewController <UITableViewDelegate, UITableViewDataSource, UITextFieldDelegate, FlexibleRefreshTableHeaderDelegate>


@property (strong,nonatomic) IBOutlet UITableView *flexibleTableView;
@property (assign,nonatomic) BOOL constantRowHeight;
@property (assign,nonatomic) BOOL useCustomHeaders;
@property (strong,nonatomic) UITextField *currentTextField;
@property (assign,nonatomic) BOOL allowMultipleCellSelection;
@property (strong,nonatomic) FlexiblePullToRefreshTableViewHeader *pullToRefreshHeaderView;


- (NSArray *)sectionAtIndex:(NSInteger)sectionIndex;
- (id)dataForRow:(NSInteger)rowIndex InSection:(NSInteger)sectionIndex;
- (NSArray *)allDataInSection:(NSInteger)sectionIndex;
- (void)setData:(id)dataObject ForRow:(NSInteger)rowIndex InSection:(NSInteger)sectionIndex;
- (void)refreshCellForRow:(NSInteger)rowIndex InSection:(NSInteger)sectionIndex;
- (Class)cellClassForRow:(NSInteger)rowIndex InSection:(NSInteger)sectionIndex;
- (void)addSectionAtIndex:(NSInteger)sectionIndex WithAnimation:(UITableViewRowAnimation)animation;
- (void)removeRowAtIndex:(NSInteger)rowIndex InSection:(NSInteger)sectionIndex WithAnimation:(UITableViewRowAnimation)animation;
- (void)removeAllSectionsWithAnimation:(UITableViewRowAnimation)animation;
- (void)appendRowToSection:(NSInteger)sectionIndex CellClass:(Class)cellClass CellData:(id)cellData WithAnimation:(UITableViewRowAnimation)animation;
- (void)addRowAtIndex:(NSInteger)rowIndex InSection:(NSInteger)sectionIndex CellClass:(Class)cellClass CellData:(id)cellData WithAnimation:(UITableViewRowAnimation)animation;
- (void)emptySectionAtIndex:(NSInteger)sectionIndex WithAnimation:(UITableViewRowAnimation)animation;
- (void)removeSectionAtIndex:(NSInteger)sectionIndex WithAnimation:(UITableViewRowAnimation)animation;
- (BOOL)cellIsSelected:(NSIndexPath *)indexPath;
- (IBAction)dismissKeyboard:(id)sender;
- (void)headerSectionsReordered;
- (void)setCellIsSelected:(NSNumber*)selectedIndex forKey:(id)key;
- (NSIndexPath*)indexPathForFlexibleCell:(FlexibleTableViewCell*)flexibleCell;

@end
