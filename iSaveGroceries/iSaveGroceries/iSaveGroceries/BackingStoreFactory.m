//
//  BackingStoreFactory.m
//  ROMobileUniversal
//
//  Created by Dirk Lewis on 12/9/11.
//  Copyright Video Hoo Haa. All rights reserved.
//

#import "BackingStoreFactory.h"
#import "BackingStore.h"

@implementation BackingStoreFactory

+ (BackingStore*)createBackingStoreForModel:(NSString*)modelName toFile:(NSString*)fileName{
    
    BackingStore *backingStore = [BackingStoreFactory createBackingStoreForModel:modelName toFile:fileName fromConfig:nil];
    
    return backingStore;

}

+ (BackingStore*)createBackingStoreForModel:(NSString*)modelName toFile:(NSString*)fileName fromConfig:(NSString*)configuration{

    BackingStore *backingStore = [[BackingStore alloc] initWithModelName:modelName toFile:fileName fromConfiguration:configuration];
    return backingStore;

}

+ (BOOL)deleteBackingStoreForFilename:(NSString*)filename{


    return NO;
}
@end
