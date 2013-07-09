//
//  TokenUtilities.h
//  Dhirkin
//
//  Created by Dirk Lewis on 11/23/11.
//  Copyright (c) 2011 Optima HCS. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface TokenUtilities : NSObject
+ (NSArray*)tokensFromString:(NSString*)tokenString;
+ (NSArray*)createStepArgumentsFromTokens:(NSArray*)tokens;
+ (NSArray*)createStepArgumentsFromTokens:(NSArray*)tokens withReplacementValues:(NSDictionary*)replacementValues;
@end
