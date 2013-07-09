//
//  NSString+Dhirkin.h
//  Dhirkin
//
//  Created by Dirk Lewis on 11/29/11.
//  Copyright (c) 2011 Optima HCS. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSString (Dhirkin)

- (NSUInteger)countOfLinesTrimedOfWhiteSpace;
- (NSUInteger)countOfColumnsDelimitedBy:(NSString*)delimiter;
- (NSString*)formatStringForTableDelimitedBy:(NSString*)delimiter;
- (NSString*)formatStringForExpressionParsing;

@end
