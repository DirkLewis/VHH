//
//  SystemRepository.m
//  ROMobileUniversal
//
//  Created by Dirk Lewis on 12/19/11.
//  Copyright Video Hoo Haa. All rights reserved.
//

#import "SystemRepository.h"

@implementation SystemRepository

+ (SystemRepository*)sharedInstance{
    
    static dispatch_once_t onceToken;
    static SystemRepository *shared = nil;
    
    dispatch_once(&onceToken, ^{
        
        shared = (SystemRepository*)[VHHRepositoryFactory createSystemRepository];
        
    });
    
    return shared;
}

@end
