//
//  MessageViewController.m
//  WAHS
//
//  Created by Dirk Lewis on 6/27/13.
//  Copyright (c) 2013 VHH. All rights reserved.
//

#import "MessageViewController.h"
#import "AdvertiserManager.h"
#import "BrowserManager.h"
#import "SessionManager.h"

@interface MessageViewController ()

@end

@implementation MessageViewController{

    AdvertiserManager *_advertiserManager;
    BrowserManager *_browserManager;
    NSMutableArray *_messageArray;
}

#pragma mark - Construction

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
    //_advertiserManager = [[AdvertiserManager alloc]initWithPeerName:@"DirkL" serviceType:@"WAHS-Session" discoveryInfo:nil securityIdentity:nil encryptionPreference:MCEncryptionNone];
   // _advertiserManager.sessionManager.delegate = self;
   // [_advertiserManager startAssistant];
    _messageArray = [NSMutableArray array];
    self.messageTableView.dataSource = self;
    self.messageTableView.delegate = self;
    
}

- (void)viewWillAppear:(BOOL)animated{

    [super viewWillAppear:animated];

}

- (void)viewDidAppear:(BOOL)animated{

    [super viewDidAppear:animated];
    _browserManager = [[BrowserManager alloc]initWithPeerName:@"Dirkl" serviceType:@"WAHS-Session" securityIdentity:nil encryptionPreference:MCEncryptionNone];
    _browserManager.sessionManager.delegate = self;
    [self.navigationController presentViewController:[_browserManager browserViewController] animated:YES completion:^{
    }];


}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


#pragma mark - Private
- (NSDictionary*)buildMessageDictionaryWithMessageText:(NSString*)messageText peerID:(MCPeerID*)peerId device:(NSString*)deviceUUID{

    return @{@"message" : messageText, @"peerID" : peerId, @"device" : deviceUUID};
}

#pragma mark - Public

#pragma mark - Textfield Delegate

- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string{
    
    [_browserManager.sessionManager sendActivityMessage];
    return YES;
}

#pragma mark - SessionManager Delegate

- (void)didReceiveTextMessage:(NSString*)textMessage fromPeerID:(MCPeerID*)peerID onDevice:(NSString*)deviceUDID{
    [_messageArray addObject:[self buildMessageDictionaryWithMessageText:textMessage peerID:peerID device:deviceUDID]];

    [self.messageTableView reloadData];
    NSIndexPath *indexPath = [NSIndexPath indexPathForRow:([_messageArray count]-1) inSection:0];
    [self.messageTableView scrollToRowAtIndexPath:indexPath atScrollPosition:UITableViewScrollPositionBottom animated:YES];
    
}
- (void)didReceiveImage:(UIImageView*)image{

}
- (void)didReceiveActivity{

}
- (void)didChangeState:(MCSessionState)state{

}
- (void)didReceiveError:(NSError *)error{

}
#pragma mark - Datasource Delegate
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    // Return the number of sections.
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    // Return the number of rows in the section.
    NSLog(@"count:%i",[_messageArray count]);
    return [_messageArray count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"textcell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier forIndexPath:indexPath];
    
    // Configure the cell...
    cell.textLabel.text = [(NSDictionary*)[_messageArray objectAtIndex:indexPath.row]valueForKey:@"message"];
    return cell;
}

/*
 // Override to support conditional editing of the table view.
 - (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
 {
 // Return NO if you do not want the specified item to be editable.
 return YES;
 }
 */

/*
 // Override to support editing the table view.
 - (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
 {
 if (editingStyle == UITableViewCellEditingStyleDelete) {
 // Delete the row from the data source
 [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
 }
 else if (editingStyle == UITableViewCellEditingStyleInsert) {
 // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
 }
 }
 */

/*
 // Override to support rearranging the table view.
 - (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath
 {
 }
 */

/*
 // Override to support conditional rearranging of the table view.
 - (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath
 {
 // Return NO if you do not want the item to be re-orderable.
 return YES;
 }
 */

/*
 #pragma mark - Navigation
 
 // In a story board-based application, you will often want to do a little preparation before navigation
 - (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
 {
 // Get the new view controller using [segue destinationViewController].
 // Pass the selected object to the new view controller.
 }
 
 */

#pragma mark - Tableview Delegate

#pragma mark - actions
- (IBAction)touchSendButton:(id)sender {
    [_browserManager.sessionManager sendMessageText:self.messageTextField.text];
//    [_messageArray addObject:@{@"message": @"this is it"}];
//    [self.messageTableView reloadData];
}
@end
