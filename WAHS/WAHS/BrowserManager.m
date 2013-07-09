//
//  BrowserManager.m
//  WAHS
//
//  Created by Dirk Lewis on 6/27/13.
//  Copyright (c) 2013 VHH. All rights reserved.
//

#import "BrowserManager.h"
#import <MultipeerConnectivity/MultipeerConnectivity.h>
#import "SessionManager.h"
@interface BrowserManager()

@end

@implementation BrowserManager{

    MCPeerID *_peerID;
    MCBrowserViewController *_browerVC;

}


#pragma mark - Construction
- (instancetype)initWithPeerName:(NSString*)peerName serviceType:(NSString*)serviceType securityIdentity:(NSArray*)securityIdentity encryptionPreference:(MCEncryptionPreference)preference
{ 
    self = [super init];
    if (self) {
        _peerID = [[MCPeerID alloc]initWithDisplayName:peerName];
        _sessionManager = [[SessionManager alloc]initWithPeerID:_peerID securityIdentity:securityIdentity encryptionPreference:preference];
        _browerVC = [[MCBrowserViewController alloc]initWithServiceType:serviceType session:_sessionManager.session];
        _browerVC.delegate = self;
    }
    return self;
}

#pragma mark - Private

#pragma mark - Public
- (MCBrowserViewController*)browserViewController{
    return _browerVC;
}

#pragma mark - Browser Delegate
// Notifies the delegate, when the user taps the done button
- (void)browserViewControllerDidFinish:(MCBrowserViewController *)browserViewController{
    
    [browserViewController dismissViewControllerAnimated:YES completion:nil];

}

// Notifies delegate that the user taps the cancel button.
- (void)browserViewControllerWasCancelled:(MCBrowserViewController *)browserViewController{
    
    [browserViewController dismissViewControllerAnimated:YES completion:nil];
}

// Notifies delegate that a peer was found; discoveryInfo can be used to determine whether the peer should be presented to the user, and the delegate should return a YES if the peer should be presented; this method is optional, if not implemented every nearby peer will be presented to the user.
- (BOOL)browserViewController:(MCBrowserViewController *)browserViewController shouldPresentNearbyPeer:(MCPeerID *)peerID withDiscoveryInfo:(NSDictionary *)info{

    return YES;
}

@end
