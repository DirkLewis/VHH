//
//  CustomCellBackground.h
//  ROMobileUniversal
//
//  Created by Dirk Lewis on 4/16/12.
//  Copyright (c) 2012 Optima HCS. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <FlexibleTableLibrary/FlexibleTableViewProtocol.h>

@interface CustomCellBackground : UIView <CustomCellBackgroundProtocol>
@property (assign) BOOL lastCell;
@property (assign) BOOL selected;
@end
