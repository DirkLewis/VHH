//
//  DataEncryption.h
//  ROMobileUniversal
//
//  Created by Dirk Lewis on 3/19/12.
//  Copyright (c) 2012 Optima HCS. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface DataEncryption : NSObject

+ (id)encryptData:(id)data withPassword:(NSString*)password;
+ (id)decryptData:(NSData*)data withPassword:(NSString*)password;

@end
