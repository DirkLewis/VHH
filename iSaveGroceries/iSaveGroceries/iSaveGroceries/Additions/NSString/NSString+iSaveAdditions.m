//
//  NSString+iSaveAdditions.m
//  iSaveGroceries
//
//  Created by Dirk on 2/19/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "NSString+iSaveAdditions.h"
#import "NSString+VHHAdditions.h"

@implementation NSString (iSaveAdditions)

- (NSString*)reformatCategory{

    return [NSString replaceStringOccurance:self targetCharacter:@"Category: " replacementCharacter:@""];

}
- (NSString*)reformatSalePrice{

    return [NSString replaceStringOccurance:self targetCharacter:@"for    " replacementCharacter:@"for "];

}

@end
