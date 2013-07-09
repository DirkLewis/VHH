//
//  NSData+VHHCategory.h
//  VHHCoreRepository
//
//  Created by Dirk Lewis on 7/2/13.
//  Copyright (c) 2013 VideoHooHaa. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSData (VHHCategory)
- (NSData *)AES256EncryptWithKey:(NSString *)key;
- (NSData *)AES256DecryptWithKey:(NSString *)key;
- (NSString *)MD5Sum;
- (NSString *)SHA1Sum;
- (NSString *)base64EncodedString;
+ (NSData *)dataWithBase64String:(NSString *)base64String;


@end
