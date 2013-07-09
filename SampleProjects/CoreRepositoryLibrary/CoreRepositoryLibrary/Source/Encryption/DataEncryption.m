//
//  DataEncryption.m
//  ROMobileUniversal
//
//  Created by Dirk Lewis on 3/19/12.
//  Copyright (c) 2012 Optima HCS. All rights reserved.
//

#import "DataEncryption.h"
#import "NSData+Additions.h"

@implementation DataEncryption

+ (id)encryptData:(id)data withPassword:(NSString*)password{
    
    NSData *retVal;
    NSData *encryptedData = [data AES256EncryptWithKey:password]; //[[inputString dataUsingEncoding:NSUTF8StringEncoding] AES256EncryptWithKey:userPassword];
    retVal = encryptedData;
	return retVal;
}
+ (id)decryptData:(NSData*)data withPassword:(NSString*)password{
    
    NSData *retVal;
	NSData *inData = (NSData *)data;   
    NSData *outData = [inData AES256DecryptWithKey:password];
    retVal = outData;
    
    
    return retVal;
    
}
@end
