//
//  NSMutableData+RandomDataGeneration.m
//  iOSPing
//
//  Created by Dirk Lewis on 5/22/12.
//  Copyright (c) 2012 Optima HCS. All rights reserved.
//

#import "NSMutableData+RandomDataGeneration.h"

@implementation NSMutableData (RandomDataGeneration)

+(id)randomDataWithLength:(NSUInteger)length
{
    NSMutableData* data=[NSMutableData dataWithLength:length];
    [[NSInputStream inputStreamWithFileAtPath:@"/dev/urandom"] read:(uint8_t*)[data mutableBytes] maxLength:length];
    return data;
}

@end
