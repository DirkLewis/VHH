//
//  FlexiblePullToRefreshTableViewHeader.h
//  ROMobileUniversal
//
//  Created by Dirk Lewis on 2/27/12.
//  Copyright (c) 2012 Optima HCS. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <QuartzCore/QuartzCore.h>

typedef enum {

    FlexiblePullRefreshPulling = 0,
    FlexiblePullRefreshNormal,
    FlexiblePullRefreshLoading
    
} FlexiblePullRefreshState;


@protocol FlexibleRefreshTableHeaderDelegate;

@interface FlexiblePullToRefreshTableViewHeader : UIView

@property (weak,nonatomic) id <FlexibleRefreshTableHeaderDelegate> delegate;

- (void)refreshLastUpdatedDate;
- (void)flexibleRefreshScrollViewDidScroll:(UIScrollView *)scrollView;
- (void)flexibleRefreshScrollViewDidEndDragging:(UIScrollView *)scrollView;
- (void)flexibleRefreshScrollViewDataSourceDidFinishedLoading:(UIScrollView *)scrollView;

@end

@protocol FlexibleRefreshTableHeaderDelegate <NSObject>

- (void) flexibleRefreshTableHeaderDidTriggerRefresh:(FlexiblePullToRefreshTableViewHeader*)view;
- (BOOL) flexibleRefreshTableHeaderDataSourceIsLoading:(FlexiblePullToRefreshTableViewHeader*)view;

@optional
- (NSDate*)flexibleRefreshTableHeaderDataSourceLastUpdated:(FlexiblePullToRefreshTableViewHeader*)view;

@end