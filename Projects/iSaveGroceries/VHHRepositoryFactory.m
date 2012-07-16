//
//  RORepositoryFactory.m
//  ROMobileUniversal
//
//  Created by Dirk Lewis on 12/12/11.
//  Copyright Video Hoo Haa. All rights reserved.
//

#import "VHHRepository.h"
#import "VHHRepositoryFactory.h"
#import "BackingStore.h"
#import "BackingStoreFactory.h"

@implementation VHHRepositoryFactory


+ (VHHRepository*)createiSaveRepository{
    
    NSString *modelName = @"Model";
    BackingStore *backingStore = [BackingStoreFactory createBackingStoreForModel:modelName toFile:@"save.sqlite" fromConfig:nil];    
    return [VHHRepository repository:backingStore];

}

+ (VHHRepository*)createSystemRepository{
    
    NSString *modelName = @"Model";
    BackingStore *backingStore = [BackingStoreFactory createBackingStoreForModel:modelName toFile:@"System.sqlite" fromConfig:@"System"];    
    return [VHHRepository repository:backingStore];
}


@end
