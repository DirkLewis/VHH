

#import "FlexibleGradientBackgroundTable.h"
#import <QuartzCore/QuartzCore.h>

#ifndef kCFCoreFoundationVersionNumber_iPhoneOS_4_0
#define kCFCoreFoundationVersionNumber_iPhoneOS_4_0 550.32
#endif

static CGGradientRef TableBackgroundGradient(void)
{
	static CGGradientRef layoutGradient = NULL;
	if (!layoutGradient)
	{
		UIColor *contentColorTop = [UIColor colorWithRed:0.90 green:0.92 blue:0.95 alpha:1.0];
		UIColor *contentColorBottom = [UIColor colorWithRed:0.70 green:0.72 blue:0.75 alpha:1.0];

		CGColorSpaceRef colorspace = CGColorSpaceCreateDeviceRGB();
		CGFloat backgroundColorComponents[3][4];
		memcpy(
			backgroundColorComponents[0],
			CGColorGetComponents(contentColorTop.CGColor),
			sizeof(CGFloat) * 4);
		memcpy(
			backgroundColorComponents[1],
			CGColorGetComponents(contentColorBottom.CGColor),
			sizeof(CGFloat) * 4);
		
		const CGFloat endpointLocations[2] = {0.0, 1.0};
		layoutGradient =
			CGGradientCreateWithColorComponents(
				colorspace,
				(const CGFloat *)backgroundColorComponents,
				endpointLocations,
				2);
		CFRelease(colorspace);
	}
	return layoutGradient;
}

@implementation FlexibleGradientBackgroundTable

//
// initWithFrame:style:
//
// Init method for the object.
//
- (id)initWithFrame:(CGRect)aFrame style:(UITableViewStyle)aStyle
{
	self = [super initWithFrame:aFrame style:aStyle];
	if (self != nil)
	{
		self.backgroundColor = [UIColor clearColor];
		self.opaque = YES;
		self.separatorStyle = UITableViewCellSeparatorStyleNone;
	}
	return self;
}


//
// layoutSubviews
//
// Find the default layer and remove it.
//
- (void)layoutSubviews
{
	[super layoutSubviews];
	
	if (kCFCoreFoundationVersionNumber < kCFCoreFoundationVersionNumber_iPhoneOS_4_0)
	{
		for (CALayer *layer in self.layer.sublayers)
		{
			if (CGRectEqualToRect([self.layer bounds], [layer frame]))
			{
				layer.hidden = YES;
			}
		}
	}
}

//
// drawRect:
//
// Draw the view.
//
- (void)drawRect:(CGRect)rect
{
	if (self.opaque)
	{
		CGContextRef context = UIGraphicsGetCurrentContext();
		rect = self.bounds;
		
		CGContextDrawLinearGradient(
			context,
			TableBackgroundGradient(),
			CGPointMake(rect.origin.x, rect.origin.y),
			CGPointMake(rect.origin.x + rect.size.width, rect.origin.y + rect.size.height),
			0);
	}
}

@end
