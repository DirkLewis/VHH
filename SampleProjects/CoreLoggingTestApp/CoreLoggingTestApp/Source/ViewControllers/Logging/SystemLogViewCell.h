//
//  SystemLogViewCell.h
//  ROMobileUniversal
//
//  Created by JoseB on 2/23/12.
//  Copyright (c) 2012 Optima HCS. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <FlexibleTableLibrary/FlexibleTableViewCell.h>
#import "SystemLogEntry.h"


@interface SystemLogViewCell : FlexibleTableViewCell

@property (strong, nonatomic) IBOutlet UILabel *timestampLabel;
@property (strong, nonatomic) IBOutlet UITextView *messageText;

@end
