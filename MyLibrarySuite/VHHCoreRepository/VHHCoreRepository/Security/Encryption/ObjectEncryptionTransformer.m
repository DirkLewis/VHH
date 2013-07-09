//
//  UIImageEncryptionTransformer.m
//  Rehab Optima Mobile
//
//  Created by Dirk Lewis on 7/24/12.
//  Copyright (c) 2012 GiftRAP Corp. All rights reserved.
//

#import "ObjectEncryptionTransformer.h"
//#import "NSString+ROAdditions.h"
#import "EncryptionPasswordTracker.h"
#import "NSData+VHHCategory.h"
#import "EncryptionPasswordTracker.h"

@implementation ObjectEncryptionTransformer

+ (Class)transformedValueClass
{
	return [NSData class];
}

+ (BOOL)allowsReverseTransformation { return YES; }

- (id)transformedValue:(id)value{
    
    NSDictionary *storageDictionary = [NSDictionary dictionaryWithObject:value forKey:@"Data"];
    NSMutableData *dictionaryData = [[NSMutableData alloc]init];
    
    NSKeyedArchiver *archiver = [[NSKeyedArchiver alloc]initForWritingWithMutableData:dictionaryData];
    [archiver encodeObject:storageDictionary forKey:@"Storage"];
    [archiver finishEncoding];
    
	NSString *userPassword = [EncryptionPasswordTracker sharedEncryptionPasswordTracker].password;
    NSData *encryptedData = [dictionaryData AES256EncryptWithKey:userPassword];
    
	return encryptedData;
}

- (id)reverseTransformedValue:(id)value{
    
	NSString *userPassword = [EncryptionPasswordTracker sharedEncryptionPasswordTracker].password;
	NSLog(@"%@",userPassword);
    NSData *outData = [value AES256DecryptWithKey:userPassword];
    @try {
        NSKeyedUnarchiver *unarchiver = [[NSKeyedUnarchiver alloc] initForReadingWithData:outData];
        NSDictionary *storageDictionary = [unarchiver decodeObjectForKey:@"Storage"];
        [unarchiver finishDecoding];
        return [storageDictionary objectForKey:@"Data"];;
    }
    @catch (NSException *exception) {
        return nil;
    }

}

@end
