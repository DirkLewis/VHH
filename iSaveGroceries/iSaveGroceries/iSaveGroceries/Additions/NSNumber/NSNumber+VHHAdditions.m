//
//  NSNumber+VHHAdditions.m
//  ROMobileUniversal
//
//  Created by Dirk Lewis on 12/15/11.
//  Copyright Video Hoo Haa. All rights reserved.
//

#import "NSNumber+VHHAdditions.h"

@implementation NSNumber (VHHAdditions)
+ (NSNumber*)decimalNumberFromString:(NSString*)string{

    NSNumberFormatter *formatter = [[NSNumberFormatter alloc] init];
    
    [formatter setNumberStyle:NSNumberFormatterDecimalStyle];
    NSNumber *number = [formatter numberFromString:string];
    return number;
}

+ (NSNumber*)integerNumberFromString:(NSString*)string{

    NSNumberFormatter *formatter = [[NSNumberFormatter alloc] init];
    [formatter setNumberStyle:NSNumberFormatterNoStyle];
    NSNumber *number = [formatter numberFromString:string];
    return number;
}
@end
