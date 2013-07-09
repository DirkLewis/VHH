//
//  FieldLevelSecurityStrategy.h
//  CoreDataRepositoryFramework
//
//  Created by Dirk Lewis on 7/18/12.
//  Copyright (c) 2012 Optima HCS. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "RepositoryProtocols.h"
@interface FieldLevelSecurityStrategy : NSObject <RepositorySecurityStrategyProtocol>

@property (weak, nonatomic)id<PasswordProtocol> passwordTracker;
@end
