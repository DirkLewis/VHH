//
//  Repository.h
//  VHHCoreRepository
//
//  Created by Dirk Lewis on 7/2/13.
//  Copyright (c) 2013 VideoHooHaa. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ProtocolHeaders.h"

@interface Repository : NSObject <RepositoryProtocol>
@property (assign) BOOL isRepositoryOpen;
@property (assign) BOOL isRepositorySecured;

@end
