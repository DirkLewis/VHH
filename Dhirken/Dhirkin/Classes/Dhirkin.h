//
//  Dhirkin.h
//  Dhirkin
//
//  Created by Dirk Lewis on 11/23/11.
//  Copyright (c) 2011 Optima HCS. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Constants.h"
@class DhirkinFeature;

@interface Dhirkin : NSObject

@property (nonatomic,strong) NSString *featureContents;
@property (nonatomic,strong) NSMutableArray *features;

- (id) initWthFeatureFileContents:(NSString*)featureContents;
- (NSArray*)runTests:(NSArray*)tests;
@end
