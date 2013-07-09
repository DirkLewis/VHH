//
//  Example.h
//  Dhirkin
//
//  Created by Dirk Lewis on 11/30/11.
//  Copyright (c) 2011 Optima HCS. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Examples : NSObject

@property (nonatomic,strong) NSString *body;
@property (nonatomic,strong) NSMutableArray *table;
@property (nonatomic,strong) NSString *exampleName;

+ (NSArray*)createExamplesFromFeatureFileContents:(NSString*)featureFileContents;


@end
