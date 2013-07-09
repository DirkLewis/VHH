//
//  GherkinUtilities.m
//  Dhirkin
//
//  Created by Dirk Lewis on 11/23/11.
//  Copyright (c) 2011 Optima HCS. All rights reserved.
//

#import "GherkinUtilities.h"
#import "Constants.h"

@implementation GherkinUtilities

+ (BOOL)containsGherkinFeatureKeyword:(NSString*)line{

    NSRange featureRange = [line rangeOfString:@"Feature:"];
    NSRange tagRange = [line rangeOfString:@"@"];
    NSRange scenarioRange = [line rangeOfString:@"Scenario:"];
    NSRange scenarioOutlineRange = [line rangeOfString:@"Scenario Outline:"];
    NSRange examplesRange = [line rangeOfString:@"Examples"];
    
    if (featureRange.location != NSNotFound | tagRange.location != NSNotFound | scenarioRange.location != NSNotFound | scenarioOutlineRange.location != NSNotFound | examplesRange.location != NSNotFound) {
        return YES;
    }
    else{
        return NO;
    }

}

+ (BOOL)containsGherkinStepKeyword:(NSString*)line{
    
    NSRange givenRange = [line rangeOfString:@"Given"];
    NSRange whenRange = [line rangeOfString:@"When"];
    NSRange thenRange = [line rangeOfString:@"Then"];
    NSRange andRange = [line rangeOfString:@"And"];
    NSRange butRange = [line rangeOfString:@"But"];
    NSRange starRange = [line rangeOfString:@"*"];
    
    if (givenRange.location != NSNotFound | whenRange.location != NSNotFound | thenRange.location != NSNotFound | andRange.location != NSNotFound | butRange.location != NSNotFound | starRange.location != NSNotFound) {
        return YES;
    }
    else{
        return NO;
    }
    
}

+ (BOOL)scenarioStepContainsTable:(NSString*)line{

    return [line rangeOfString:@":"].location != NSNotFound;

}

+ (NSString*)stepKeywordInLine:(NSString*)line{
    
    NSRange givenRange = [line rangeOfString:@"Given"];
    NSRange whenRange = [line rangeOfString:@"When"];
    NSRange thenRange = [line rangeOfString:@"Then"];
    NSRange andRange = [line rangeOfString:@"And"];
    NSRange butRange = [line rangeOfString:@"But"];
    NSRange starRange = [line rangeOfString:@"*"];
    
    if (givenRange.location != NSNotFound) {
        return @"Given";
    }
    
    if (whenRange.location != NSNotFound) {
        return @"When";
    }
    
    if (thenRange.location != NSNotFound) {
        return @"Then";
    }
    
    if (andRange.location != NSNotFound) {
        return @"And";
    }
    
    if (butRange.location != NSNotFound) {
        return @"But";
    }
    
    if (starRange.location != NSNotFound) {
        return @"Star";
    }
  
    return @"";
    
}

@end
