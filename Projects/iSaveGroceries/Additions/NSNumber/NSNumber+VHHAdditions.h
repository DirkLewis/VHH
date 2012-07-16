//
//  NSNumber+VHHAdditions.h
//  ROMobileUniversal
//
//  Created by Dirk Lewis on 12/15/11.
//  Copyright Video Hoo Haa. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSNumber (VHHAdditions)

+ (NSNumber*)decimalNumberFromString:(NSString*)string;
+ (NSNumber*)integerNumberFromString:(NSString*)string;

@end
