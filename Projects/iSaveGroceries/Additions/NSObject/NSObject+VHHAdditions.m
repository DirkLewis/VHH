//
//  NSObject+ROAdditions.m
//  ROMobileUniversal
//
//  Created by Dirk Lewis on 11/16/11.
//  Copyright Video Hoo Haa  All rights reserved.
//

#import "NSObject+VHHAdditions.h"
#import <objc/runtime.h>
@implementation NSObject (VHHAdditions)

- (NSString *)className
{
	return [NSString stringWithUTF8String:class_getName([self class])];
}
+ (NSString *)className
{
	return [NSString stringWithUTF8String:class_getName(self)];
}

@end
