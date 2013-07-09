//
//  AdvertiserManager.h
//  WAHS
//
//  Created by Dirk Lewis on 6/27/13.
//  Copyright (c) 2013 VHH. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <MultipeerConnectivity/MultipeerConnectivity.h>

@class SessionManager;

@interface AdvertiserManager : NSObject <MCAdvertiserAssistantDelegate>

- (instancetype)initWithPeerName:(NSString*)peerName serviceType:(NSString*)serviceType discoveryInfo:(NSDictionary*)discoveryInfo securityIdentity:(NSArray*)securityIdentity encryptionPreference:(MCEncryptionPreference)preference;
- (void)startAssistant;
- (void)stopAssistant;
@property (nonatomic,strong)SessionManager *sessionManager;
@end
