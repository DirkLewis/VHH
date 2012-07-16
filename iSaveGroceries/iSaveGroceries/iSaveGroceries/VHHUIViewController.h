//
//  ROUIViewController.h
//  ROMobileUniversal
//
//  Created by Dirk Lewis on 1/23/12.
//  Copyright Video Hoo Haa All rights reserved.
//


@interface VHHUIViewController : UIViewController <UIAlertViewDelegate>

- (void)showHUDWithText:(NSString*)text;
- (void)hideHUDWithText:(NSString*)text;

- (void)startObservingNotifications;
- (void)stopObservingNotifications;

@end
