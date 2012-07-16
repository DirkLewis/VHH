//
//  NSArray+VHHAdditions.h
//  ROMobileUniversal
//
//  Created by Dirk Lewis on 11/15/11.
//  Copyright Video Hoo Haa  All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSArray (VHHAdditions)

- (NSArray *)sectionsGroupedByKeyPath:(NSString *)keyPath;

/**
 * Calls performSelector on all objects in the array.

- (void)perform:(SEL)selector;
*/

- (void)perform:(SEL)selector withObject:(id)p1;
- (void)perform:(SEL)selector withObject:(id)p1 withObject:(id)p2;
- (void)perform:(SEL)selector withObject:(id)p1 withObject:(id)p2 withObject:(id)p3;

/**
 * @return nil or an object that matches value with isEqual:
 */
- (id)objectWithValue:(id)value forKey:(id)key;
- (NSArray *)objectsWithValue:(id)value forKey:(id)key;

/**
 * @return the first object with the given class.
 */
- (id)objectWithClass:(Class)cls;

/**
 * @param selector Required format: - (NSNumber*)method:(id)object;

- (BOOL)containsObject:(id)object withSelector:(SEL)selector;
*/

@end
