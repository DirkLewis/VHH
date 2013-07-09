//
//  SessionManager.m
//  WAHS
//
//  Created by Dirk Lewis on 6/27/13.
//  Copyright (c) 2013 VHH. All rights reserved.
//

#import "SessionManager.h"

@implementation SessionManager{

}

#pragma mark - Construction
- (instancetype)initWithPeerID:(MCPeerID*)peerID securityIdentity:(NSArray*)securityIdentity encryptionPreference:(MCEncryptionPreference)preference
{
    self = [super init];
    if (self) {
        _session = [[MCSession alloc]initWithPeer:peerID securityIdentity:securityIdentity encryptionPreference:preference];
        _session.delegate = self;
    }
    return self;
}

#pragma mark - Private



#pragma mark - Public
- (void)sendMessageText:(NSString *)messageText{
    NSError *error = nil;
    NSDictionary *dataDictionary = @{@"device": [[[UIDevice currentDevice]identifierForVendor]UUIDString], @"isActivity" : @NO, @"message" : messageText};
    NSData *data = [NSKeyedArchiver archivedDataWithRootObject:dataDictionary];
    NSArray *connectedPeers = [self.session connectedPeers];
    [self.session sendData:data toPeers:connectedPeers withMode:MCSessionSendDataReliable error:&error];
    
    if (error) {
        [self.delegate didReceiveError:error];
        return;
    }
}

- (void)sendActivityMessage{
    NSError *error = nil;
    NSDictionary *dataDictionary = @{@"device": [[[UIDevice currentDevice]identifierForVendor]UUIDString],@"isActivity" : @YES};
    NSData *data = [NSKeyedArchiver archivedDataWithRootObject:dataDictionary];
    NSArray *connectedPeers = [self.session connectedPeers];
    [self.session sendData:data toPeers:connectedPeers withMode:MCSessionSendDataUnreliable error:&error];
    
    if (error) {
        [self.delegate didReceiveError:error];
        return;
    }
}

#pragma mark - Session Delegate
// Remote peer changed state
- (void)session:(MCSession *)session peer:(MCPeerID *)peerID didChangeState:(MCSessionState)state{
    [self.delegate didChangeState:state];
}

// Received data from remote peer
- (void)session:(MCSession *)session didReceiveData:(NSData *)data fromPeer:(MCPeerID *)peerID{

    NSDictionary *dataDictionary = [NSKeyedUnarchiver unarchiveObjectWithData:data];
    if ([[dataDictionary valueForKey:@"isActivity"]boolValue]) {
        dispatch_async(dispatch_get_main_queue(), ^{
            [self.delegate didReceiveActivity];
        });
    }
    else{
        
        dispatch_async(dispatch_get_main_queue(), ^{
            [self.delegate didReceiveTextMessage:[dataDictionary valueForKey:@"message"] fromPeerID:peerID onDevice:[dataDictionary valueForKey:@"device"]];

        });
    }
}

// Received a byte stream from remote peer
- (void)session:(MCSession *)session didReceiveStream:(NSInputStream *)stream withName:(NSString *)streamName fromPeer:(MCPeerID *)peerID{

}

// Start receiving a resource from remote peer
- (void)session:(MCSession *)session didStartReceivingResourceWithName:(NSString *)resourceName fromPeer:(MCPeerID *)peerID withProgress:(NSProgress *)progress{

}

// Finished receiving a resource from remote peer and saved the content in a temporary location - the app is responsible for moving the file to a permanent location within its sandbox
- (void)session:(MCSession *)session didFinishReceivingResourceWithName:(NSString *)resourceName fromPeer:(MCPeerID *)peerID atURL:(NSURL *)localURL withError:(NSError *)error{

}


@end
