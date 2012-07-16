//
//  RehabRepository.h
//  ROMobileUniversal
//
//  Created by Dirk Lewis on 12/19/11.
//  Copyright Video Hoo Haa. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface iSaveRepository : VHHRepository
+ (iSaveRepository*)sharedInstance;
+ (iSaveRepository*)repository;

@end
