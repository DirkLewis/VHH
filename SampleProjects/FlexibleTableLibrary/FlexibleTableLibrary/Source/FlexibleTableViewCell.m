//
//  ROCell.m
//  ROMobileUniversal
//
//  Created by Dirk Lewis on 2/3/12.
//  Copyright (c) 2012 Optima HCS. All rights reserved.
//

#import "FlexibleTableViewCell.h"
const CGFloat ROCellDefaultRowHeight = 44.0;

@implementation FlexibleTableViewCell{

    NSArray *_contentArray;

}

@synthesize content = _content;

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
    }
    return self;
}

+ (NSString *)reuseIdentifier{
	return NSStringFromClass(self);
}

+ (NSString *)nibName{
	return nil;
}

+ (UITableViewCellStyle)style{
	return UITableViewCellStyleDefault;
}


+ (BOOL) isHeaderFooter{
    return NO;
}

+ (CGFloat)rowHeight{
    return ROCellDefaultRowHeight;
}

+ (CGFloat)rowExpandedHeight{
    return ROCellDefaultRowHeight;
}


- (id)init{
	UITableViewCellStyle style = [[self class] style];
	NSString *identifier = [[self class] reuseIdentifier];
    
	if (self = [super initWithStyle:style reuseIdentifier:identifier])
	{
		NSString *nibName = [[self class] nibName];
		if (nibName)
		{
			@autoreleasepool {
				_contentArray = [[NSBundle mainBundle] loadNibNamed:nibName owner:self options:nil];
			}
			NSAssert(self.content != nil, @"NIB file loaded but content property not set.");
			[self addSubview:self.content];
		}
        
		[self finishConstruction];
	}
	return self;
}


- (UIView *)contentView{
	if (self.content)
	{
		return self.content;
	}
	return [super contentView];
}

 
- (void)prepareForReuse{
}


- (void)finishConstruction{
}


- (void)configureForData:(id)dataObject tableView:(UITableView *)tableView indexPath:(NSIndexPath *)indexPath
{

}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
	[super setSelected:selected animated:animated];
    
	if (!self.content)
	{
		UIColor *clearColor = [UIColor clearColor];
		if (![self.textLabel.backgroundColor isEqual:clearColor])
		{
			self.textLabel.backgroundColor = [UIColor clearColor];
		}
		if (![self.detailTextLabel.backgroundColor isEqual:clearColor])
		{
			self.detailTextLabel.backgroundColor = [UIColor clearColor];
		}
	}
}




@end
