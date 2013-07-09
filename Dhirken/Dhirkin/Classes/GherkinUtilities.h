//
//  GherkinUtilities.h
//  Dhirkin
//
//  Created by Dirk Lewis on 11/23/11.
//  Copyright (c) 2011 Optima HCS. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Constants.h"

@interface GherkinUtilities : NSObject
+ (BOOL)containsGherkinStepKeyword:(NSString*)line;
+ (BOOL)scenarioStepContainsTable:(NSString*)line;
+ (NSString*)stepKeywordInLine:(NSString*)line;
+ (BOOL)containsGherkinFeatureKeyword:(NSString*)line;


@end
