//
//  NSString+Dhirkin.m
//  Dhirkin
//
//  Created by Dirk Lewis on 11/29/11.
//  Copyright (c) 2011 Optima HCS. All rights reserved.
//

#import "NSString+Dhirkin.h"

@implementation NSString (Dhirkin)

- (NSUInteger)countOfLinesTrimedOfWhiteSpace{

    NSArray *stringCountArray = [self componentsSeparatedByCharactersInSet:[NSCharacterSet newlineCharacterSet]];
    NSUInteger lineCount = 0;
    for (NSString *line in stringCountArray) {
        if ([[line stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]]length] > 0) {
            lineCount += 1;
        }
    }
    
    return lineCount;
}

- (NSUInteger)countOfColumnsDelimitedBy:(NSString*)delimiter{

    NSString *lineFormattedForTable;
    if ([[self substringWithRange:NSMakeRange(0, 1)]isEqualToString:delimiter]) {
        lineFormattedForTable = [[self substringToIndex:[self length]-1] substringFromIndex:1];
    }
    else{
        lineFormattedForTable = self;
    }
    
    return [[lineFormattedForTable componentsSeparatedByString:@"|"]count];

}

- (NSString*)formatStringForTableDelimitedBy:(NSString*)delimiter{

    NSString *lineFormattedForTable;
    if ([[self substringWithRange:NSMakeRange(0, 1)]isEqualToString:delimiter]) {
        lineFormattedForTable = [[self substringToIndex:[self length]-1] substringFromIndex:1];
    }
    else{
        lineFormattedForTable = self;
    }

    return lineFormattedForTable;
}

- (NSString*)formatStringForExpressionParsing{

    NSString *tempString = [self stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]];
    tempString = [tempString stringByTrimmingCharactersInSet:[NSCharacterSet newlineCharacterSet]];
    
    return tempString;

}
@end
