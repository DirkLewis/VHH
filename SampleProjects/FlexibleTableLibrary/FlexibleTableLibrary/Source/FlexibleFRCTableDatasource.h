//
//  FlexibleFRCTableDatasource.h
//  FlexibleTableLibrary
//
//  Created by Dirk Lewis on 8/27/12.
//  Copyright (c) 2012 VHH. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>
#import "FlexibleTableViewProtocol.h"

@class FlexibleCellDescription;


typedef NSFetchedResultsController* (^FRCBlockType)();
typedef FlexibleCellDescription* (^CellDescriptionBlockType)(id dataObject);

@interface FlexibleFRCTableDatasource : NSObject <UITableViewDataSource,NSFetchedResultsControllerDelegate>
@property (nonatomic,assign) BOOL allowMultipleCellSelection;
@property (nonatomic,assign) BOOL allowDeletes;
@property (nonatomic,assign) BOOL allowMoves;

- (id)initWithFetchedResultsControllerBlock:(FRCBlockType)frcBlock cellDescriptionBlock:(CellDescriptionBlockType)cellDescriptionBlock;

- (void)resetFRC;
- (void)performFetch;

@end
