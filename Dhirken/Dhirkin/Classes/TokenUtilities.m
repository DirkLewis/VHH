//
//  TokenUtilities.m
//  Dhirkin
//
//  Created by Dirk Lewis on 11/23/11.
//  Copyright (c) 2011 Optima HCS. All rights reserved.
//

#import "TokenUtilities.h"

@implementation TokenUtilities

+ (NSArray*)tokensFromString:(NSString*)tokenString{
    
    NSMutableArray *tempArray = [NSMutableArray array];
    
    CFStringRef string = (__bridge CFStringRef)tokenString; // Get string from somewhere
    CFLocaleRef locale = CFLocaleCopyCurrent();
    
    CFStringTokenizerRef tokenizer = CFStringTokenizerCreate(kCFAllocatorDefault, string, CFRangeMake(0, CFStringGetLength(string)), kCFStringTokenizerUnitWord, locale);
    
    CFStringTokenizerTokenType tokenType = kCFStringTokenizerTokenNone;
    unsigned tokensFound = 0;
    
    while(kCFStringTokenizerTokenNone != (tokenType = CFStringTokenizerAdvanceToNextToken(tokenizer))) {
        CFRange tokenRange = CFStringTokenizerGetCurrentTokenRange(tokenizer);
        CFStringRef tokenValue = CFStringCreateWithSubstring(kCFAllocatorDefault, string, tokenRange);
        [tempArray addObject:(__bridge NSString*)tokenValue];
        CFRelease(tokenValue);
        ++tokensFound;
    }
    
    // Clean up
    CFRelease(tokenizer);
    CFRelease(locale);
    
    return tempArray;
    
}

+ (NSArray*)createStepArgumentsFromTokens:(NSArray*)tokens{
    
    return [self createStepArgumentsFromTokens:tokens withReplacementValues:nil];
    
}

+ (NSArray*)createStepArgumentsFromTokens:(NSArray*)tokens withReplacementValues:(NSDictionary*)replacementValues{
    
    NSMutableArray *tempArray = [NSMutableArray array];
    
    for (NSString *token in tokens) {
        
        NSNumber *number = [[[NSNumberFormatter alloc]init]numberFromString:token];
        if (number) {
            [tempArray addObject:number];
            continue;
        }
        
        NSRange rangeSingleQuote = [token rangeOfString:@"'"];
        if (rangeSingleQuote.location != NSNotFound) {
            NSString *tempString = [token stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]];
            [tempArray addObject:tempString];
            continue;
        }
        
        NSRange rangeAngleBracket = [token rangeOfString:@"<"];
        if (rangeAngleBracket.location != NSNotFound) {
            NSString *tempString = [[token stringByReplacingOccurrencesOfString:@"<" withString:@""] stringByReplacingOccurrencesOfString:@">" withString:@""];
            tempString = [replacementValues objectForKey:tempString];
            [tempArray addObject:tempString];
            continue;
        }
    }
    return tempArray;
}

@end
