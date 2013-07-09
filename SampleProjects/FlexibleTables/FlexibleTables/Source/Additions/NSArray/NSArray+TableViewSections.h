//
//  NSArray+TableViewSections.h
//  Rehab Optima Mobile
//
//  Created by Dirk Lewis on 7/9/12.
//  Copyright (c) 2012 GiftRAP Corp. All rights reserved.
//

#import <Foundation/Foundation.h>
typedef void (^SimpleSectionsBlock)(id data, NSInteger index);
@interface NSArray (TableViewSections)

- (NSArray*)sectionsForKeyName:(NSString*)keyname andSectionList:(NSArray*)sectionList;
- (NSDictionary*)sectionedDataForKeyname:(NSString*)keyname andSectionList:(NSArray*)sectionList;

@end
