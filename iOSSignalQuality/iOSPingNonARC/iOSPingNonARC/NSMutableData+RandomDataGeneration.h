//
//  NSMutableData+RandomDataGeneration.h
//  iOSPing
//
//  Created by Dirk Lewis on 5/22/12.
//  Copyright (c) 2012 Optima HCS. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSMutableData (RandomDataGeneration)
+(id)randomDataWithLength:(NSUInteger)length;
@end
