//
//  AdvertiserManager.m
//  WAHS
//
//  Created by Dirk Lewis on 6/27/13.
//  Copyright (c) 2013 VHH. All rights reserved.
//

#import "AdvertiserManager.h"
#import <MultipeerConnectivity/MultipeerConnectivity.h>
#import "SessionManager.h"
@interface AdvertiserManager()

@end

@implementation AdvertiserManager{

    MCAdvertiserAssistant *_advertiserAssistant;
    MCPeerID *_peerID;
    
}

#pragma mark - Construction
- (instancetype)initWithPeerName:(NSString*)peerName serviceType:(NSString*)serviceType discoveryInfo:(NSDictionary*)discoveryInfo securityIdentity:(NSArray*)securityIdentity encryptionPreference:(MCEncryptionPreference)preference
{
    self = [super init];
    if (self) {
        _peerID = [[MCPeerID alloc]initWithDisplayName:peerName];
        _sessionManager = [[SessionManager alloc]initWithPeerID:_peerID securityIdentity:securityIdentity encryptionPreference:preference];
        _advertiserAssistant = [[MCAdvertiserAssistant alloc]initWithServiceType:serviceType discoveryInfo:discoveryInfo session:_sessionManager.session];
        _advertiserAssistant.delegate = self;
    }
    return self;
}

#pragma mark - Private


#pragma mark - Public
- (void)startAssistant{

    [_advertiserAssistant start];
}

- (void)stopAssistant{

    [_advertiserAssistant stop];
}

#pragma mark - Assistant Delegate
// An invitation will be presented to the user
- (void)advertiserAssitantWillPresentInvitation:(MCAdvertiserAssistant *)advertiserAssistant{

    
}

// An invitation was dismissed from screen
- (void)advertiserAssistantDidDismissInvitaiton:(MCAdvertiserAssistant *)advertiserAssistant{

    [self stopAssistant];
}

@end
