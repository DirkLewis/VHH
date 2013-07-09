//
//  Repository.h
//  CoreDataRepositoryFramework
//
//  Created by Dirk Lewis on 6/18/12.
//  Copyright (c) 2012 Optima HCS. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>
#import "BackingstoreProtocol.h"
#import "RepositoryProtocols.h"

@interface Repository : NSObject <RepositoryProtocol>

- (id)initWithBackingStore:(id<BackingstoreProtocol>)backingStore securityStrategy:(id<RepositorySecurityStrategyProtocol>)securityStrategy;
+ (Repository*)repository:(id<BackingstoreProtocol>)backingstore securityStrategy:(id<RepositorySecurityStrategyProtocol>)securityStrategy;

@end
