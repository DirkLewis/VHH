//
//  Dhirkin.m
//  Dhirkin
//
//  Created by Dirk Lewis on 11/23/11.
//  Copyright (c) 2011 Optima HCS. All rights reserved.
//

#import "Dhirkin.h"
#import "Feature.h"
#import "Scenario.h"
#import "ScenarioStep.h"
#import "Constants.h"

@interface Dhirkin( Private )

- (void) createDhirkinFeatureFromContent:(NSString*)featureContents;
- (DhirkinResult) runTestStepUsingBlock:(ScenarioStep*)step testBlock:(DhirkinResult (^)(NSArray* args))block testArguments:(NSArray*)arguments;

@end

@implementation Dhirkin

@synthesize features = _features;
@synthesize featureContents = _featureContents;

- (id)init
{
    self = [super init];
    if (self) {
        // Initialization code here.
    }
    
    return self;
}

- (id) initWthFeatureFileContents:(NSString*)featureContents{
    
    self = [super init];
    if (self) {
        
        _features = [NSMutableArray array];
        _featureContents = featureContents;
        [self createDhirkinFeatureFromContent:_featureContents];
        
    }
    
    return self;
}

- (NSArray*)runTests:(NSArray*)tests{
    
    NSMutableArray *resultsArray = [NSMutableArray array];
    NSPredicate *expressionPredicate;
    //we need to make the determination which blocks to test for which steps
    
    for (Feature *feature in _features) {
        
        for (Scenario *scenario in feature.scenarios) {
            
            for (ScenarioStep *step in scenario.steps) {
                
                BOOL stepDefined = NO;
                
                for (NSDictionary* dictionary in tests) {
                    expressionPredicate = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", [dictionary valueForKey:@"Expression"]];
                    if ([expressionPredicate evaluateWithObject:step.line]) {
                        stepDefined = YES;
                        
                        if (step.arguments) {
                            step.testPassed = [self runTestStepUsingBlock:step testBlock:[dictionary valueForKey:@"Block"] testArguments:step.arguments];
                        }
                        else if (step.scenarioTable){
                            step.testPassed = [self runTestStepUsingBlock:step testBlock:[dictionary valueForKey:@"Block"] testArguments:step.scenarioTable];
                        }
                        
                        if (step.testPassed == Failed) {
                            NSString *resultString = [NSString stringWithFormat:@"%@ Step: %@ failed",feature.featureName, step.line];
                            [resultsArray addObject:resultString];
                        }
                        else if (step.testPassed == Pending){
                            NSString *resultString = [NSString stringWithFormat:@"Step: %@ :: PENDING",step.line];
                            [resultsArray addObject:resultString];
                        }
                        continue;
                    }
                    
                }
                
                if (!stepDefined) {
                    NSString *notDefinedMessage = [NSString stringWithFormat:@"Step:%@ :: NOT DEFINED",step.line];
                    [resultsArray addObject:notDefinedMessage];
                    continue;
                }
                
            }
        }
    }
    
    return  resultsArray;
}

- (DhirkinResult) runTestStepUsingBlock:(ScenarioStep*)step testBlock:(DhirkinResult (^)(NSArray* args))block testArguments:(NSArray*)arguments{
    
    return block(arguments);
    
}

- (void) createDhirkinFeatureFromContent:(NSString*)featureContents{
    
    Feature *feature = [Feature CreateFeatureFromString:featureContents];
    
    [_features addObject:feature];
}

@end
