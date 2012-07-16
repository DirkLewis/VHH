//
//  ROCellDescription.m
//  ROMobileUniversal
//
//  Created by Dirk Lewis on 2/3/12.
//  Copyright (c) 2012 Optima HCS. All rights reserved.
//

#import "FlexibleCellDescription.h"

@implementation FlexibleCellDescription
@synthesize cellClass = _cellClass;
@synthesize cellData = _cellData;


- (id)initWithCellClass:(Class)cellClass AndData:(id)cellData{
	self = [super init];
	if (self)
	{
		_cellData = cellData;
		_cellClass = cellClass;
	}
	
	return self;
}

- (NSString *)description
{
	NSString *inherited = [super description];
	NSString *classDescription = [self.cellClass description];
	NSString *dataDescription = [self.cellData description];
	
	return [NSString stringWithFormat:@"%@ {\n\tcellClass: %@,\n\tcellDescription: %@\n}",inherited, classDescription, dataDescription];
}

@end

