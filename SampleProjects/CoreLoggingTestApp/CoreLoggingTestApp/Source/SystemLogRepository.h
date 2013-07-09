//
//  SystemRepository.h
//  CoreLogging
//
//  Created by Dirk Lewis on 7/26/12.
//  Copyright (c) 2012 Optima HCS. All rights reserved.
//

#import <CoreRepositoryLibrary/CoreRepositoryLibraryHeaders.h>

@interface SystemLogRepository : Repository

+ (SystemLogRepository*)sharedSystemLogRepository;
@end
