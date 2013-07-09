//
//  FieldLevelSecurityStrategy.h
//  VHHCoreRepository
//
//  Created by Dirk Lewis on 7/2/13.
//  Copyright (c) 2013 VideoHooHaa. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ProtocolHeaders.h"

@interface FieldLevelSecurityStrategy : NSObject <RepositorySecurityStrategyProtocol>
@property (weak, nonatomic)id<PasswordProtocol> passwordTracker;
@end
