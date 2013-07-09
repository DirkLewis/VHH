//
//  NSData+ROAdditions.h
//  ROMobileUniversal
//
//  Created by Dirk Lewis on 12/14/11.
//  Copyright (c) 2011 Optima HCS. All rights reserved.
//  Centralized from SSToolkit NSData additions
//

#import <Foundation/Foundation.h>

@interface NSData (ROAdditions)

- (NSData *)AES256EncryptWithKey:(NSString *)key;
- (NSData *)AES256DecryptWithKey:(NSString *)key;

///--------------
/// @name Hashing
///--------------

/**
 Returns a string of the MD5 sum of the receiver.
 
 @return The string of the MD5 sum of the receiver.
 */
- (NSString *)MD5Sum;

/**
 Returns a string of the SHA1 sum of the receiver.
 
 @return The string of the SHA1 sum of the receiver.
 */
- (NSString *)SHA1Sum;


///-----------------------------------
/// @name Base64 Encoding and Decoding
///-----------------------------------

/**
 Returns a string representation of the receiver Base64 encoded.
 
 @return A Base64 encoded string
 */
- (NSString *)base64EncodedString;

/**
 Returns a new data contained in the Base64 encoded string.
 
 @param base64String A Base64 encoded string
 
 @return Data contained in `base64String`
 */
+ (NSData *)dataWithBase64String:(NSString *)base64String;
@end
