//
//  Scenerio.m
//  Dhirkin
//
//  Created by Dirk Lewis on 11/23/11.
//  Copyright (c) 2011 Optima HCS. All rights reserved.
//

#import "Scenario.h"
#import "ScenarioStep.h"
#import "GherkinUtilities.h"
#import "TokenUtilities.h"
#import "NSMutableArray+MultiDimension.h"
#import "NSString+Dhirkin.h"
#import "Examples.h"
@interface Scenario ( Private )


@end

@implementation Scenario

@synthesize body = _body;
@synthesize steps = _steps;

+ (NSArray*) createScenariosFromFeatureFileContents:(NSString*)featureFileContents withBackgroundSteps:(NSArray*)steps{
    
    Scenario *scenario;
    
    NSArray *examplesArray = [Examples createExamplesFromFeatureFileContents:featureFileContents];
    
    
    NSMutableArray *tempArray = [NSMutableArray array];
    NSRange firstScenarioRange = [featureFileContents rangeOfString:@"Scenario:"];
    NSRange scenarioBodyRange =  NSMakeRange(firstScenarioRange.location,([featureFileContents length] - firstScenarioRange.location));
    NSString *scenariosBody = [featureFileContents substringWithRange:scenarioBodyRange];
    
    NSScanner *scanner = [NSScanner scannerWithString:scenariosBody];
    
    NSString *scenarioBody;
    
    while ([scanner isAtEnd] == NO) {
        
        if (examplesArray) {
            
            for (Examples *examples in examplesArray) {
                
                NSUInteger columnCount = [examples.table columnCount];
                NSUInteger rowCount = [examples.table rowCount];
                
                for (int i = 1; i <= rowCount-1; i++) {
                    //for each row in the example table we need to create a scenario
                    NSMutableDictionary *scenarioExamples = [[NSMutableDictionary alloc]init];
                    
                    for (int y = 0; y <= columnCount-1; y++) {
                        [scenarioExamples setObject:[examples.table objectInMutableTable:y :i] forKey:[examples.table objectInMutableTable:y :0]];                        
                    }
                    
                    [scanner scanString:@"Scenario:" intoString:NULL];
                    [scanner scanUpToString:@"Scenario:" intoString:&scenarioBody];
                    
                    scenario = [[Scenario alloc]init];
                    
                    scenario.body = scenarioBody;
                    
                    if (steps) {
                        scenario.steps = [ScenarioStep createScenarioStepsForScenarioBody:scenarioBody withBackgroundSteps:steps withExampleValues:scenarioExamples];
                    }
                    else{
                        scenario.steps = [ScenarioStep createScenarioStepsForScenarioBody:scenarioBody withExampleValues:scenarioExamples];
                    }
                    
                    [tempArray addObject:scenario];
                    
                }
            }
            
        }
        else{
            
            [scanner scanString:@"Scenario:" intoString:NULL];
            [scanner scanUpToString:@"Scenario:" intoString:&scenarioBody];
            
            scenario = [[Scenario alloc]init];
            
            scenario.body = scenarioBody;
            
            if (steps) {
                scenario.steps = [ScenarioStep createScenarioStepsForScenarioBody:scenarioBody withBackgroundSteps:steps];
            }
            else{
                scenario.steps = [ScenarioStep createScenarioStepsForScenarioBody:scenarioBody];
            }
            
            [tempArray addObject:scenario];
        }
    }
    
    return tempArray;
}

+ (NSArray*) createScenariosFromFeatureFileContents:(NSString*)featureFileContents{    
    
    return [self createScenariosFromFeatureFileContents:featureFileContents withBackgroundSteps:nil];    
}

+ (Scenario*) createBackgroundScenarioFromFeatureFileContents:(NSString*)featureFileContents{
    
    Scenario *scenario;
    
    NSRange backgroundRange = [featureFileContents rangeOfString:@"Background:"];
    NSRange scenarioRange = [featureFileContents rangeOfString:@"Scenario:"];
    NSRange range;
    
    if (backgroundRange.location != NSNotFound) {
        
        if(scenarioRange.location != NSNotFound){
            range = NSMakeRange(backgroundRange.location, (scenarioRange.location - backgroundRange.location));
            NSString *backgroundBody = [featureFileContents substringWithRange:range];
            scenario = [[Scenario alloc]init];
            scenario.body = backgroundBody; 
            scenario.steps = scenario.steps = [ScenarioStep createScenarioStepsForScenarioBody:backgroundBody];
        }
    }
    
    
    return scenario;
    
}
@end
