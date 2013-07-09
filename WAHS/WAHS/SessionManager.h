//
//  SessionManager.h
//  WAHS
//
//  Created by Dirk Lewis on 6/27/13.
//  Copyright (c) 2013 VHH. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <MultipeerConnectivity/MultipeerConnectivity.h>

@protocol SessionManagerDelegate;

@interface SessionManager : NSObject <MCSessionDelegate>
- (instancetype)initWithPeerID:(MCPeerID*)peerID securityIdentity:(NSArray*)securityIdentity encryptionPreference:(MCEncryptionPreference)preference;
@property (nonatomic,strong)MCSession *session;
@property (nonatomic,assign)id<SessionManagerDelegate> delegate;

- (void)sendMessageText:(NSString*)messageText;
- (void)sendActivityMessage;
@end

@protocol SessionManagerDelegate <NSObject>

@required
- (void)didReceiveTextMessage:(NSString*)textMessage fromPeerID:(MCPeerID*)peerID onDevice:(NSString*)deviceUDID;
- (void)didReceiveImage:(UIImageView*)image;
- (void)didReceiveActivity;
- (void)didChangeState:(MCSessionState)state;
- (void)didReceiveError:(NSError*)error;

@end