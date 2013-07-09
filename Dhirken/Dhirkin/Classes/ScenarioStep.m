//
//  ScenerioStep.m
//  Dhirkin
//
//  Created by Dirk Lewis on 11/23/11.
//  Copyright (c) 2011 Optima HCS. All rights reserved.
//

#import "ScenarioStep.h"
#import "GherkinUtilities.h"
#import "TokenUtilities.h"
#import "NSMutableArray+MultiDimension.h"
#import "NSString+Dhirkin.h"

@interface ScenarioStep (Private)

+ (ScenarioStep*)createStepWithSingleLine:(NSString*)line;
+ (NSArray*)separateStepBody:(NSString*)body withStepList:(NSArray*)steps;
+ (ScenarioStep*)createStepWithMultipleLines:(NSString*)stepBody;
+ (ScenarioStep*)createStepWithSingleLine:(NSString*)line withScenarioExample:(NSDictionary*)example;

@end

@implementation ScenarioStep

@synthesize line = _line;
@synthesize testPassed = _testPassed;
@synthesize failureMessage = _failureMessage;
@synthesize stepResult = _stepResult;
@synthesize arguments = _arguments;
@synthesize scenarioTable = _scenarioTable;

+ (ScenarioStep*)createStepWithSingleLine:(NSString*)line withScenarioExample:(NSDictionary*)example{
    
    //replace argument place holders with actual values in each step
    
    ScenarioStep *singleLineStep = [[ScenarioStep alloc]init];
    singleLineStep.line = [line formatStringForExpressionParsing];
    
    if (example) {
        singleLineStep.arguments = [TokenUtilities createStepArgumentsFromTokens:[singleLineStep.line componentsSeparatedByString:@" "] withReplacementValues:example];
        
    }
    else{
        singleLineStep.arguments = [TokenUtilities createStepArgumentsFromTokens:[singleLineStep.line componentsSeparatedByString:@" "]];
    }
    singleLineStep.scenarioTable = nil;
    
    return singleLineStep;
    
}

+ (ScenarioStep*)createStepWithSingleLine:(NSString*)line{
    
    return [self createStepWithSingleLine:line withScenarioExample:nil];
    
}
+ (ScenarioStep*)createStepWithMultipleLines:(NSString*)stepBody{
    
    ScenarioStep *scenarioStep = [[ScenarioStep alloc]init];
    NSMutableArray *tableArray;
    
    NSUInteger lineCount = [stepBody countOfLinesTrimedOfWhiteSpace];
    NSUInteger rowCount = 0;
    
    NSArray* stepBodyArray = [stepBody componentsSeparatedByCharactersInSet:[NSCharacterSet newlineCharacterSet]];
    
    for (NSString *stepLine in stepBodyArray) {
        
        if ([GherkinUtilities containsGherkinStepKeyword:stepLine] ) {
            lineCount -= 1; //not part of the table
            scenarioStep.line = [stepLine formatStringForExpressionParsing];
            scenarioStep.arguments = nil;
        }
        else{
            
            if ([[stepLine stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]]length] == 0) {
                continue;
            }
            NSString *lineFormattedForTable = [[stepLine stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]]formatStringForTableDelimitedBy:@"|"];
            
            NSUInteger columnCount = [lineFormattedForTable countOfColumnsDelimitedBy:@"|"];
            
            if (!tableArray) {
                tableArray = [NSMutableArray mutableArrayWithColumns:columnCount :lineCount];
            }
            
            NSMutableArray *tempArray = [NSMutableArray array];
            [tempArray addObjectsFromArray:[lineFormattedForTable componentsSeparatedByString:@"|"]];
            
            for (int y=0; y <= [tempArray count]-1; y++) {
                NSString *tableItem = [tempArray objectAtIndex:y];
                tableItem = [tableItem stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]];
                [tableArray setObject:tableItem :y :rowCount];
            }
            
            rowCount += 1;
            
        }
        
    }
    
    scenarioStep.scenarioTable = tableArray;
    
    return scenarioStep;
}

+ (NSArray*)separateStepBody:(NSString*)body withStepList:(NSArray*)steps{
    
    int currentIndex = 0;
    NSMutableArray *stepBodies = [NSMutableArray array];
    NSRange next;
    NSRange current;
    NSRange range;
    
    for (NSString *step in steps) {
        
        current = [body rangeOfString:step];
        
        if (currentIndex +1 <= [steps count]-1) {
            next = [body rangeOfString:[steps objectAtIndex:currentIndex +1]];
            range = NSMakeRange(current.location, (next.location - current.location));
            
        }
        else{
            next =  NSMakeRange(current.location,([body length] - current.location));
            range = NSMakeRange(current.location, next.length);
            
        }
        
        NSString *stepBody = [body substringWithRange:range];
        [stepBodies addObject:stepBody];
        
        currentIndex += 1;
    }
    
    return stepBodies;
    
    
}

+ (NSArray*)createScenarioStepsForScenarioBody:(NSString*)body withBackgroundSteps:(NSArray*)steps withExampleValues:(NSDictionary*)example{
    
    //we need to find an array of all the steps and break them up.
    
    __block NSMutableArray* stepArray = [NSMutableArray array];
    NSMutableArray *tempArray = [NSMutableArray array];
    
    void (^getStepList)(NSString*, BOOL*);
    
    getStepList = ^(NSString* line, BOOL *stop){
        
        line = [line stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]];
        
        if ([line length] > 0 && [GherkinUtilities containsGherkinStepKeyword:line]) {
            
            [stepArray addObject:[GherkinUtilities stepKeywordInLine:line]];
        }
    };
    
    [body enumerateLinesUsingBlock:getStepList];
    
    NSArray* stepBodies = [self separateStepBody:body withStepList:stepArray];
    
    for (NSString *stepBody in stepBodies) {
        if ([GherkinUtilities scenarioStepContainsTable:[[stepBody componentsSeparatedByCharactersInSet:[NSCharacterSet newlineCharacterSet]] objectAtIndex:0]] && 
            [[stepBody componentsSeparatedByCharactersInSet:[NSCharacterSet newlineCharacterSet]]count]> 0) {
            
            [tempArray addObject:[self createStepWithMultipleLines:stepBody]];
        }
        else{
            if (example) {
                [tempArray addObject:[self createStepWithSingleLine:[[stepBody componentsSeparatedByCharactersInSet:[NSCharacterSet newlineCharacterSet]]objectAtIndex:0] withScenarioExample:example]];
                
            }
            else{
                [tempArray addObject:[self createStepWithSingleLine:[[stepBody componentsSeparatedByCharactersInSet:[NSCharacterSet newlineCharacterSet]]objectAtIndex:0]]];
                
            }
        }
        
    }
    
    return tempArray;
}

+ (NSArray*)createScenarioStepsForScenarioBody:(NSString*)body withExampleValues:(NSDictionary *)example{
    
    return [self createScenarioStepsForScenarioBody:body withBackgroundSteps:nil withExampleValues:example];
    
}

+ (NSArray*)createScenarioStepsForScenarioBody:(NSString*)body withBackgroundSteps:(NSArray *)steps{
    
    return [self createScenarioStepsForScenarioBody:body withBackgroundSteps:steps withExampleValues:nil];
    
}

+ (NSArray*)createScenarioStepsForScenarioBody:(NSString*)body{
    
    return [self createScenarioStepsForScenarioBody:body withBackgroundSteps:nil withExampleValues:nil];
    
}

@end
