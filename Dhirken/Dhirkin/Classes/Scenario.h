//
//  Scenerio.h
//  Dhirkin
//
//  Created by Dirk Lewis on 11/23/11.
//  Copyright (c) 2011 Optima HCS. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Scenario : NSObject

@property (nonatomic,strong) NSString *body;
@property (nonatomic,strong) NSArray *steps;

+ (NSArray*) createScenariosFromFeatureFileContents:(NSString*)featureFileContents;
+ (NSArray*) createScenariosFromFeatureFileContents:(NSString*)featureFileContents withBackgroundSteps:(NSArray*)steps;

+ (Scenario*) createBackgroundScenarioFromFeatureFileContents:(NSString*)featureFileContents;

@end
