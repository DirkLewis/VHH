//
//  NSString+ShortError.h
//  iOSPing
//
//  Created by Dirk Lewis on 5/23/12.
//  Copyright (c) 2012 Optima HCS. All rights reserved.
//

@interface NSString (ShortError)
+ (NSString *)shortErrorFromError:(NSError *)error;
@end
