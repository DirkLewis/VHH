//
//  ScenerioStep.h
//  Dhirkin
//
//  Created by Dirk Lewis on 11/23/11.
//  Copyright (c) 2011 Optima HCS. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Constants.h"


@interface ScenarioStep : NSObject
@property (nonatomic, strong) NSString *line;
@property (assign) BOOL testPassed;
@property (nonatomic, strong) NSString *failureMessage;
@property (assign) DhirkinResult stepResult;
@property (nonatomic, strong) NSArray *arguments;
@property (nonatomic, strong) NSMutableArray *scenarioTable;

+ (NSArray*)createScenarioStepsForScenarioBody:(NSString*)body;
+ (NSArray*)createScenarioStepsForScenarioBody:(NSString*)body withBackgroundSteps:(NSArray*)steps withExampleValues:(NSDictionary*)example;
+ (NSArray*)createScenarioStepsForScenarioBody:(NSString*)body withExampleValues:(NSDictionary *)example;
+ (NSArray*)createScenarioStepsForScenarioBody:(NSString*)body withBackgroundSteps:(NSArray *)steps;
@end
