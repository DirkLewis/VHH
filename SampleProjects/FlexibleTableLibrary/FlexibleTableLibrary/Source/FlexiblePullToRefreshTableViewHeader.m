//
//  FlexiblePullToRefreshTableViewHeader.m
//  ROMobileUniversal
//
//  Created by Dirk Lewis on 2/27/12.
//  Copyright (c) 2012 Optima HCS. All rights reserved.
//

#import "FlexiblePullToRefreshTableViewHeader.h"
#import "FlexibleTableStyleSheet.h"

#define FLIP_ANIMATION_DURATION 0.18f

@interface FlexiblePullToRefreshTableViewHeader ( Private )

- (void)setState:(FlexiblePullRefreshState)state;

@end

@implementation FlexiblePullToRefreshTableViewHeader{

    FlexiblePullRefreshState _state;
    UILabel *_lastUpdatedLabel;
    UILabel *_statusLabel;
    CALayer *_arrowImage;
    UIActivityIndicatorView *_activityView;
    
}

#pragma mark - Synthisize

#pragma mark - Life Cycle
- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
        [FlexibleTableStyleSheet styleFlexibleHeaderView:self];

		UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(0.0f, frame.size.height - 30.0f, self.frame.size.width, 20.0f)];
        [FlexibleTableStyleSheet styleFlexibleHeaderLastUpdatedLabel:label];
		[self addSubview:label];
		_lastUpdatedLabel=label;
		
		label = [[UILabel alloc] initWithFrame:CGRectMake(0.0f, frame.size.height - 48.0f, self.frame.size.width, 20.0f)];
        [FlexibleTableStyleSheet styleFlexibleHeaderStatusLabel:label];
		[self addSubview:label];
		_statusLabel=label;
		
        CALayer *layer = [CALayer layer];
        [FlexibleTableStyleSheet styleFlexibleHeaderImageLayer:layer frame:frame];
		
#if __IPHONE_OS_VERSION_MAX_ALLOWED >= 40000
		if ([[UIScreen mainScreen] respondsToSelector:@selector(scale)]) {
			layer.contentsScale = [[UIScreen mainScreen] scale];
		}
#endif
		
		[[self layer] addSublayer:layer];
		_arrowImage=layer;
		
		UIActivityIndicatorView *view = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleGray];
		view.frame = CGRectMake(25.0f, frame.size.height - 38.0f, 20.0f, 20.0f);
		[self addSubview:view];
		_activityView = view;
		
		[self setState:FlexiblePullRefreshNormal];
    
    }
    
    return self;
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
}
*/

#pragma mark - Private Methods

- (void)setState:(FlexiblePullRefreshState)state{

    switch (state) {
            
        case FlexiblePullRefreshPulling:
            
            _statusLabel.text = @"Release to refresh...";
            [CATransaction begin];
            [CATransaction setAnimationDuration:FLIP_ANIMATION_DURATION];
            _arrowImage.transform = CATransform3DMakeRotation((M_PI / 180.0) * 180.0f, 0.0f, 0.0f, 1.0f);
            [CATransaction commit];
            
            break;
        
        case FlexiblePullRefreshNormal:
            
            if (_state == FlexiblePullRefreshPulling) {
				[CATransaction begin];
				[CATransaction setAnimationDuration:FLIP_ANIMATION_DURATION];
				_arrowImage.transform = CATransform3DIdentity;
				[CATransaction commit];
			}
            
            _statusLabel.text = @"Pull down to refresh...";
            [_activityView stopAnimating];
            [CATransaction begin];
            [CATransaction setValue:(id)kCFBooleanTrue forKey:kCATransactionDisableActions];
            _arrowImage.hidden = NO;
            _arrowImage.transform = CATransform3DIdentity;
            [CATransaction commit];
            [self refreshLastUpdatedDate];
            
            break;
        
        case FlexiblePullRefreshLoading:
            
            _statusLabel.text = @"Loading...";
            [_activityView startAnimating];
            [CATransaction begin];
            [CATransaction setValue:(id)kCFBooleanTrue forKey:kCATransactionDisableActions];
            _arrowImage.hidden = YES;
            [CATransaction commit];
            
            
            break;
        default:
            break;
    }
    
    _state = state;
}

#pragma mark - Public Methods
- (void)refreshLastUpdatedDate{

    if ([self.delegate respondsToSelector:@selector(flexibleRefreshTableHeaderDataSourceLastUpdated:)]) {
        NSDate *date = [self.delegate flexibleRefreshTableHeaderDataSourceLastUpdated:self];
        NSDateFormatter *dateFormatter = [[NSDateFormatter alloc]init];
        [dateFormatter setAMSymbol:@"AM"];
        [dateFormatter setPMSymbol:@"PM"];
        [dateFormatter setDateFormat:@"MM/dd/yyyy hh:mm:a"];
        _lastUpdatedLabel.text = [NSString stringWithFormat:@"Last Updated: %@", [dateFormatter stringFromDate:date]];

    }
    else{
        _lastUpdatedLabel.text = nil;
    }
}

- (void)flexibleRefreshScrollViewDidScroll:(UIScrollView *)scrollView{

    if (_state == FlexiblePullRefreshLoading) {
        CGFloat offset = MAX(scrollView.contentOffset.y * -1, 0);
        offset = MIN(offset, 60);
        scrollView.contentInset = UIEdgeInsetsMake(offset, 0.0f, 0.0f, 0.0f);
    }
    else if (scrollView.isDragging){
        
        BOOL isLoading = NO;
        if ([self.delegate respondsToSelector:@selector(flexibleRefreshTableHeaderDataSourceIsLoading:)]) {
            isLoading = [self.delegate flexibleRefreshTableHeaderDataSourceIsLoading:self];
        }
        
        if (_state == FlexiblePullRefreshPulling && scrollView.contentOffset.y > -65.0f && scrollView.contentOffset.y < 0.0f && !isLoading) {
            [self setState:FlexiblePullRefreshNormal];
        }
        else if (_state == FlexiblePullRefreshNormal && scrollView.contentOffset.y < -65.0f && !isLoading){
            [self setState:FlexiblePullRefreshPulling];
        }
        
        if (scrollView.contentInset.top != 0) {
            scrollView.contentInset = UIEdgeInsetsZero;
        }
    
    }
}

- (void)flexibleRefreshScrollViewDidEndDragging:(UIScrollView *)scrollView{

    BOOL isLoading = NO;
    
    if ([self.delegate respondsToSelector:@selector(flexibleRefreshTableHeaderDataSourceIsLoading:)]) {
        isLoading = [self.delegate flexibleRefreshTableHeaderDataSourceIsLoading:self];
    }
    
    if (scrollView.contentOffset.y <= -65.0f && !isLoading) {
        
        if ([self.delegate respondsToSelector:@selector(flexibleRefreshTableHeaderDidTriggerRefresh:)]) {
            [self.delegate flexibleRefreshTableHeaderDidTriggerRefresh:self];
        }
        
        [self setState:FlexiblePullRefreshLoading];
        [UIView beginAnimations:nil context:NULL];
        [UIView setAnimationDuration:0.2];
        scrollView.contentInset = UIEdgeInsetsMake(60.0f, 0.0f, 0.0f, 0.0f);
        [UIView commitAnimations];
        
    }
    
}

- (void)flexibleRefreshScrollViewDataSourceDidFinishedLoading:(UIScrollView *)scrollView{
    
	[UIView beginAnimations:nil context:NULL];
	[UIView setAnimationDuration:.3];
	[scrollView setContentInset:UIEdgeInsetsMake(0.0f, 0.0f, 0.0f, 0.0f)];
	[UIView commitAnimations];
	
	[self setState:FlexiblePullRefreshNormal];
}

#pragma mark - clean-up
- (void)dealloc{

    _delegate = nil;
    _activityView = nil;
    _statusLabel = nil;
    _arrowImage = nil;
    _lastUpdatedLabel = nil;
}

@end
