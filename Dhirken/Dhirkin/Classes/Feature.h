//
//  Feature.h
//  Dhirkin
//
//  Created by Dirk Lewis on 11/23/11.
//  Copyright (c) 2011 Optima HCS. All rights reserved.
//

#import <Foundation/Foundation.h>
@class Scenario;
@interface Feature : NSObject

@property (nonatomic, strong) NSString *tag;
@property (nonatomic, strong) NSString *body;
@property (nonatomic, strong) Scenario *background;
@property (nonatomic, strong) NSArray *scenarios;
@property (nonatomic, strong) NSString *statusMessage;
@property (nonatomic, strong) NSString *featureName;
@property (nonatomic, strong) NSArray *examples;

@property (assign) BOOL isTestable;

+ (Feature*) CreateFeatureFromString:(NSString*)featureFileContents;

@end
