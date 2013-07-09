//
//  NSArray+TableViewSections.m
//  Rehab Optima Mobile
//
//  Created by Dirk Lewis on 7/9/12.
//  Copyright (c) 2012 GiftRAP Corp. All rights reserved.
//

#import "NSArray+TableViewSections.h"

@implementation NSArray (TableViewSections)

- (void)processSectionsForKeyName:(NSString*)keyname andSectionList:(NSArray*)sectionList withBlock:(SimpleSectionsBlock)block{
    
    for (int i = 0; i < ([sectionList count] -1); i++) {        
        NSArray *itemsInSection = [self filteredArrayUsingPredicate:[NSPredicate predicateWithFormat:@"Self.%@ beginswith[c] %@",keyname, [[[UILocalizedIndexedCollation currentCollation]sectionIndexTitles] objectAtIndex:i]]];
        
        if ([itemsInSection count]>0) {
            block(itemsInSection, i);
            
        }
    }
    
}

- (NSArray*)sectionsForKeyName:(NSString*)keyname andSectionList:(NSArray*)sectionList{
    
    NSMutableArray *sections = [NSMutableArray array];
    [self processSectionsForKeyName:keyname andSectionList:sectionList withBlock:^(id data, NSInteger index) {
        
        [sections addObject:[sectionList objectAtIndex:index]];
         
    }];

    return sections;
    
}

- (NSDictionary*)sectionedDataForKeyname:(NSString*)keyname andSectionList:(NSArray*)sectionList{

    NSMutableDictionary *sectionedData = [NSMutableDictionary dictionary];
    
    [self processSectionsForKeyName:keyname andSectionList:sectionList withBlock:^(id data, NSInteger index) {
    
        [sectionedData setObject:(NSArray*)data forKey:[sectionList objectAtIndex:index]];
    
    }];
    
    return sectionedData;

}

@end
