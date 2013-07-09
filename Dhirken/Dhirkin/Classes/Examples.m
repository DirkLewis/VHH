//
//  Example.m
//  Dhirkin
//
//  Created by Dirk Lewis on 11/30/11.
//  Copyright (c) 2011 Optima HCS. All rights reserved.
//

#import "Examples.h"
#import "GherkinUtilities.h"
#import "TokenUtilities.h"
#import "NSString+Dhirkin.h"
#import "NSMutableArray+MultiDimension.h"

@interface Examples ( Private ) 

+ (NSMutableArray*)createExamplesTableArrayFromBody:(NSString*)body;

@end


@implementation Examples
@synthesize exampleName = _exampleName;
@synthesize table = _table;
@synthesize body = _body;

+ (NSMutableArray*)createExamplesTableArrayFromBody:(NSString*)body{
   
    NSMutableArray *tableArray;
    
    NSUInteger lineCount = [body countOfLinesTrimedOfWhiteSpace];
    NSUInteger rowCount = 0;
    
    NSArray* examplesBodyArray = [body componentsSeparatedByCharactersInSet:[NSCharacterSet newlineCharacterSet]];
    
    for (NSString *exampleLine in examplesBodyArray) {
        
        if ([GherkinUtilities containsGherkinFeatureKeyword:exampleLine] ) {
            lineCount -= 1; //not part of the table
        }
        else{
            
            if ([[exampleLine stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]]length] == 0) {
                continue;
            }
            NSString *lineFormattedForTable = [[exampleLine stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]]formatStringForTableDelimitedBy:@"|"];
            
            NSUInteger columnCount = [lineFormattedForTable countOfColumnsDelimitedBy:@"|"];
            
            if (!tableArray) {
                tableArray = [NSMutableArray mutableArrayWithColumns:columnCount :lineCount];
            }
            
            NSMutableArray *tempArray = [[NSMutableArray alloc]init];
            ;
            [tempArray addObjectsFromArray:[lineFormattedForTable componentsSeparatedByString:@"|"]];
            
            for (int y=0; y <= [tempArray count]-1; y++) {
                NSString *tableItem = [tempArray objectAtIndex:y];
                tableItem = [tableItem stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]];
                [tableArray setObject:tableItem :y :rowCount];
            }
            
            rowCount += 1;
        }
    }
        
    return tableArray;

}

+ (NSArray*)createExamplesFromFeatureFileContents:(NSString*)featureFileContents{

    Examples *examples;

    NSRange firstExamplesRange = [featureFileContents rangeOfString:@"Examples:"];

    if (firstExamplesRange.location == NSNotFound) {
        return nil;
    }
    
    NSMutableArray *tempArray = [[NSMutableArray alloc]init];
    NSRange examplesBodyRange =  NSMakeRange(firstExamplesRange.location,([featureFileContents length] - firstExamplesRange.location));
    NSString *examplesBody = [featureFileContents substringWithRange:examplesBodyRange];
    
    NSScanner *scanner = [NSScanner scannerWithString:examplesBody];
    
    NSString *exampleBody;
    
    while ([scanner isAtEnd] == NO) {
        
        [scanner scanString:@"Examples:" intoString:NULL];
        [scanner scanUpToString:@"Examples:" intoString:&exampleBody];
        examples = [[Examples alloc]init];
        
        examples.body = exampleBody;
        
        examples.exampleName = [[exampleBody componentsSeparatedByCharactersInSet:[NSCharacterSet newlineCharacterSet]]objectAtIndex:0];
        
        examples.table = [Examples createExamplesTableArrayFromBody:exampleBody];
        
        [tempArray addObject:examples];
    }
    
    return tempArray;
}

@end
