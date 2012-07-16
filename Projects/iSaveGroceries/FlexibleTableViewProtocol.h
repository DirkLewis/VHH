//
//  FlexibleTableViewProtocol.h
//  ROMobileUniversal
//
//  Created by Dirk Lewis on 2/8/12.
//  Copyright (c) 2012 Optima HCS. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol FlexibleTableViewProtocol <NSObject>

@required
- (void)createRows;
- (void)refresh;
- (void)refreshWithDelay:(NSTimeInterval)delay;

@end

@protocol FlexibleTableViewDelegate <NSObject>

@optional
- (void)flexibleTableViewRequiredRefresh:(id)sender;

@end
