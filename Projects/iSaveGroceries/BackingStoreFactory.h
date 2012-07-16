//
//  BackingStoreFactory.h
//  ROMobileUniversal
//
//  Created by Dirk Lewis on 12/9/11.
//  Copyright Video Hoo Haa. All rights reserved.
//

#import <Foundation/Foundation.h>
@class BackingStore;

@interface BackingStoreFactory : NSObject

+ (BackingStore*)createBackingStoreForModel:(NSString*)modelName toFile:(NSString*)fileName;
+ (BackingStore*)createBackingStoreForModel:(NSString*)modelName toFile:(NSString*)fileName fromConfig:(NSString*)configuration;

+ (BOOL)deleteBackingStoreForFilename:(NSString*)filename;
@end
