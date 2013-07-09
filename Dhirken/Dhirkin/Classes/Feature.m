//
//  Feature.m
//  Dhirkin
//
//  Created by Dirk Lewis on 11/23/11.
//  Copyright (c) 2011 Optima HCS. All rights reserved.
//

#import "Feature.h"
#import "Scenario.h"
#import "Examples.h"
#import "NSMutableArray+MultiDimension.h"
#import "NSString+Dhirkin.h"

@implementation Feature

@synthesize tag = _tag;
@synthesize body = _body; 
@synthesize background = _background;
@synthesize scenarios = _scenarios;
@synthesize statusMessage = _statusMessage;
@synthesize isTestable = _isTestable;
@synthesize featureName = _featureName;
@synthesize examples = _examples;

- (id)init {
    self = [super init];
    if (self) {
        
    }
    return self;
}


+ (Feature*) CreateFeatureFromString:(NSString*)featureFileContents{

    Feature *feature = [[Feature alloc]init];
        
    NSRange featureRange = [featureFileContents rangeOfString:@"Feature:"];
    NSRange backgroundRange = [featureFileContents rangeOfString:@"Background:"];
    NSRange scenarioRange = [featureFileContents rangeOfString:@"Scenario:"];
    NSRange range;

    if (featureRange.location == NSNotFound) {
        [NSException raise:@"Incomplete Feature" format:@"MISSING FEATURE!"];
        
    }else if(scenarioRange.location == NSNotFound){
        [NSException raise:@"Incomplete Feature" format:@"MISSING SCENARIO!"];
    }
    else{
    
        if (backgroundRange.location != NSNotFound) {
            range = NSMakeRange(featureRange.location, (backgroundRange.location - featureRange.location));
        }
        else if(scenarioRange.location != NSNotFound){
            range = NSMakeRange(featureRange.location, (scenarioRange.location - featureRange.location));
        }
    }

    feature.featureName = [[[featureFileContents substringWithRange:range] componentsSeparatedByString:@"\n"]objectAtIndex:0];
    feature.body = [featureFileContents substringWithRange:range];
    feature.background =  [Scenario createBackgroundScenarioFromFeatureFileContents:featureFileContents];
    
    if (feature.background) {
        feature.scenarios = [Scenario createScenariosFromFeatureFileContents:featureFileContents withBackgroundSteps:feature.background.steps];
    }
    else{
        feature.scenarios = [Scenario createScenariosFromFeatureFileContents:featureFileContents];
    }
    
    return feature;
}


@end
