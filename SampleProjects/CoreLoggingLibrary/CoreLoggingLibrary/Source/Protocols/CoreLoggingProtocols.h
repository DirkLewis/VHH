//
//  CoreLoggingProtocols.h
//  CoreLoggingLibrary
//
//  Created by Dirk Lewis on 7/27/12.
//  Copyright (c) 2012 Optima HCS. All rights reserved.
//

#import <Foundation/Foundation.h>
//#import <CoreRepository/RepositoryProtocols.h>

@protocol CoreLoggingDataManagementProtocol <NSObject>

- (void)messageToLog:(NSString*)message messageContext:(NSNumber*)messageContext logLevel:(NSNumber*)logLevel timeStamp:(NSDate*)timeStamp;
- (void)deleteMessagesOlderThan:(NSDate*)maxDate;
- (void)save;

@end
