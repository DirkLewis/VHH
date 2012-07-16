//
//  RORepositoryFactory.h
//  ROMobileUniversal
//
//  Created by Dirk Lewis on 12/12/11.
//  Copyright Video Hoo Haa. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class VHHRepository;

@interface VHHRepositoryFactory : NSObject

+ (VHHRepository*)createiSaveRepository;
+ (VHHRepository*)createSystemRepository;

@end
