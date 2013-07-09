//
//  EncryptionPasswordTracker.h
//  Rehab Optima Mobile
//
//  Created by Dirk Lewis on 8/3/12.
//  Copyright (c) 2012 GiftRAP Corp. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "CoreRepositoryLibraryHeaders.h"
@interface EncryptionPasswordTracker : NSObject <PasswordProtocol>

@property (copy, nonatomic) NSString *passwordNew;
@property (copy, nonatomic) NSString *passwordOld;
@property (copy, nonatomic) NSString *password;

+ (EncryptionPasswordTracker*)sharedEncryptionPasswordTracker;
@end
