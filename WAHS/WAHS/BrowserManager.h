//
//  BrowserManager.h
//  WAHS
//
//  Created by Dirk Lewis on 6/27/13.
//  Copyright (c) 2013 VHH. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <MultipeerConnectivity/MultipeerConnectivity.h>

@class SessionManager;

@interface BrowserManager : NSObject <MCBrowserViewControllerDelegate>
- (instancetype)initWithPeerName:(NSString*)peerName serviceType:(NSString*)serviceType securityIdentity:(NSArray*)securityIdentity encryptionPreference:(MCEncryptionPreference)preference;
- (MCBrowserViewController*)browserViewController;
@property (nonatomic,strong)SessionManager *sessionManager;

@end
