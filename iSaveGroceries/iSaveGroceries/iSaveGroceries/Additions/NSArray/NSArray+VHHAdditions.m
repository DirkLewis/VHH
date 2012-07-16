//
//  NSArray+VHHAdditions.h
//  ROMobileUniversal
//
//  Created by Dirk Lewis on 11/15/11.
//  Copyright Video Hoo Haa  All rights reserved.
//

#import "NSArray+VHHAdditions.h"

@implementation NSArray (VHHAdditions)

/**
 Category method to transform an array into a grouped array of arrays,
 designed to facilitate easy retrieval in the context of a table view.
 The array is assumed to be sorted beforehand. This method divides the
 array entries into arrays sharing the same value for the key path and
 returns an aggregate array of these "section" arrays.
 
 @param keyPath The key path of the value to group by
 @returns an NSArray of sections, each an NSArray of section items
 */
- (NSArray *)sectionsGroupedByKeyPath:(NSString *)keyPath
{
	NSMutableArray *sections = [NSMutableArray array];
    
	// If we don't contain any items, return an empty collection of sections.
	if([self count] == 0) 
		return sections;
    
	// Create the first section and establish the first section's grouping value.
	NSMutableArray *sectionItems = [NSMutableArray array];
	id currentGroup = [[self objectAtIndex:0] valueForKey:keyPath];
    
	// Iterate over our items, placing them in the appropriate section and
	// creating new sections when necessary.
	for(id item in self)
	{
		// Retrieve the grouping value from the current item.
		id itemGroup = [item valueForKey:keyPath];
        
		// Compare the current item's grouping value to the current section's 
		// grouping value.
		if(![itemGroup isEqual:currentGroup])
		{
			// The current item doesn't belong in the current section, so
			// store the section we've been building and create a new one,
			// caching the new grouping value.
			[sections addObject:sectionItems];
			sectionItems = [NSMutableArray array];
			currentGroup = itemGroup;
		}
        
		// Add the item to the appropriate section.
		[sectionItems addObject:item];
	}
    
	// If we were adding items to a section that has not yet been added 
	// to the aggregate section collection, add it now.
	if([sectionItems count] > 0)
		[sections addObject:sectionItems];
    
	return sections;
}
/*
- (void)perform:(SEL)selector {
	NSEnumerator* e = [[self copy] objectEnumerator];
	for (id delegate; (delegate = [e nextObject]); ) {
		if ([delegate respondsToSelector:selector]) {
			[delegate performSelector:selector];
		}
	}
}
*/
- (void)perform:(SEL)selector withObject:(id)p1 {
	NSEnumerator* e = [[self copy] objectEnumerator];
	for (id delegate; (delegate = [e nextObject]); ) {
		if ([delegate respondsToSelector:selector]) {
			NSMethodSignature *sig = [delegate methodSignatureForSelector:selector];
			NSInvocation* invo = [NSInvocation invocationWithMethodSignature:sig];
			[invo setTarget:delegate];
			[invo setSelector:selector];
			[invo setArgument:&p1 atIndex:2];
			[invo invoke];
		}
	}
}

- (void)perform:(SEL)selector withObject:(id)p1 withObject:(id)p2 {
	NSEnumerator* e = [[self copy] objectEnumerator];
	for (id delegate; (delegate = [e nextObject]); ) {
		if ([delegate respondsToSelector:selector]) {
			NSMethodSignature *sig = [delegate methodSignatureForSelector:selector];
			NSInvocation* invo = [NSInvocation invocationWithMethodSignature:sig];
			[invo setTarget:delegate];
			[invo setSelector:selector];
			[invo setArgument:&p1 atIndex:2];
			[invo setArgument:&p2 atIndex:3];
			[invo invoke];
		}
	}
}

- (void)perform:(SEL)selector withObject:(id)p1 withObject:(id)p2
	 withObject:(id)p3 {
	NSEnumerator* e = [[self copy] objectEnumerator];
	for (id delegate; (delegate = [e nextObject]); ) {
		if ([delegate respondsToSelector:selector]) {
			NSMethodSignature *sig = [delegate methodSignatureForSelector:selector];
			NSInvocation* invo = [NSInvocation invocationWithMethodSignature:sig];
			[invo setTarget:delegate];
			[invo setSelector:selector];
			[invo setArgument:&p1 atIndex:2];
			[invo setArgument:&p2 atIndex:3];
			[invo setArgument:&p3 atIndex:4];
			[invo invoke];
		}
	}
}

- (id)objectWithValue:(id)value forKey:(id)key {
	for (id object in self) {
		id propertyValue = [object valueForKey:key];
		if ([propertyValue isEqual:value]) {
			return object;
		}
	}
	return nil;
}

- (NSArray *)objectsWithValue:(id)value forKey:(id)key{
    
	NSMutableArray *theArray = [NSMutableArray array];
	for(id object in self){
		
		id propertyValue = [object valueForKey:key];
		if ([propertyValue isEqual:value]) {
			[theArray addObject:object];
		}
        
	}
	
	return theArray;
    
}

- (id)objectWithClass:(Class)cls {
	for (id object in self) {
		if ([object isKindOfClass:cls]) {
			return object;
		}
	}
	return nil;
}
/*
- (BOOL)containsObject:(id)object withSelector:(SEL)selector {
	for (id item in self) {
		if ([[item performSelector:selector withObject:object] boolValue]) {
			return YES;
		}
	}
	return NO;
}
*/
@end
