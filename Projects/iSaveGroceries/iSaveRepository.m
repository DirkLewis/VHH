//
//  RehabRepository.m
//  ROMobileUniversal
//
//  Created by Dirk Lewis on 12/19/11.
//  Copyright Video Hoo Haa. All rights reserved.
//

#import "iSaveRepository.h"
@implementation iSaveRepository

+ (iSaveRepository*)sharedInstance{
    
    static dispatch_once_t onceToken;
    static iSaveRepository *shared = nil;
    
    dispatch_once(&onceToken, ^{
        
        shared = (iSaveRepository*)[VHHRepositoryFactory createiSaveRepository];
        
    });
    
    return shared;
}

+ (iSaveRepository*)repository{
    return (iSaveRepository*)[VHHRepositoryFactory createiSaveRepository];
}
@end
