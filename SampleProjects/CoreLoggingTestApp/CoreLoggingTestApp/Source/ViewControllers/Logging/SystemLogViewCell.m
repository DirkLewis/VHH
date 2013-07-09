//
//  SystemLogViewCell.m
//  ROMobileUniversal
//
//  Created by JoseB on 2/23/12.
//  Copyright (c) 2012 Optima HCS. All rights reserved.
//

#import "SystemLogViewCell.h"
#import "GeneralStyleSheet.h"
#import "SSBadgeView.h"
#import "SSLabel.h"
#import "LoggingDefinition.h"
#import "LoggingController.h"
@implementation SystemLogViewCell: FlexibleTableViewCell

@synthesize timestampLabel = _timestampLabel;
@synthesize messageText = _messageText;

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
    }
    return self;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

+ (CGFloat)rowHeight{
    return 44;
}

+ (CGFloat)rowExpandedHeight{
    return 200;
}

+ (BOOL) isHeaderFooter{
    return NO;
}

- (void)configureForData:(id)dataObject tableView:(UITableView *)tableView indexPath:(NSIndexPath *)indexPath{
 
    SystemLogEntry *logEntry = (SystemLogEntry*)dataObject;
    
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateStyle:NSDateFormatterShortStyle];
    [formatter setTimeStyle:NSDateFormatterShortStyle];
    NSString *dateString = [formatter stringFromDate:logEntry.timestamp];
    self.timestampLabel.text = dateString;
    self.messageText.text = logEntry.message;
    self.messageText.backgroundColor = [UIColor clearColor];
    NSArray *contextArray = [LoggingController logEntryContextArrayForNumber:logEntry.context];
    
    SSBadgeView *badge = [GeneralStyleSheet basicBadgeView];
    
    switch ([[contextArray objectAtIndex:1]intValue]) {
        case ROLogError:
           // self.contentView.backgroundColor =  [ROStyleSheet defaultBackgroundColorForErrorCondition];
            self.textLabel.backgroundColor = [UIColor clearColor];
            badge.badgeColor = [GeneralStyleSheet defaultBackgroundColorForErrorCondition];
            badge.backgroundColor = [UIColor clearColor];
            badge.textLabel.text = @"E";
            [self setAccessoryView:badge];
            break;
        case ROLogWarning:
          //  self.contentView.backgroundColor =  [ROStyleSheet defaultBackgroundColorForWarningCondition];
            self.textLabel.backgroundColor = [UIColor clearColor];
            badge.badgeColor = [GeneralStyleSheet defaultBackgroundColorForWarningCondition];
            badge.backgroundColor = [UIColor clearColor];
            badge.textLabel.text = @"W";
            [self setAccessoryView:badge];
            break;
        case ROLogInformation:
          //  self.contentView.backgroundColor =  [ROStyleSheet defaultBackgroundColorForInformationCondition];
            self.textLabel.backgroundColor = [UIColor clearColor];
            badge.badgeColor = [GeneralStyleSheet defaultBackgroundColorForInformationCondition];
            badge.backgroundColor = [UIColor clearColor];
            badge.textLabel.text = @"I";
            [self setAccessoryView:badge];
            break;
        case ROLogVerbose:
           // self.contentView.backgroundColor =  [ROStyleSheet defaultBackgroundColorForVerboseCondition];
            self.textLabel.backgroundColor = [UIColor clearColor];
            badge.badgeColor = [GeneralStyleSheet defaultBackgroundColorForVerboseCondition];
            badge.backgroundColor = [UIColor clearColor];
            badge.textLabel.text = @"V";
            [self setAccessoryView:badge];
            break;
        case ROLogPerformance:
           // self.contentView.backgroundColor =  [ROStyleSheet defaultBackgroundColorForPerformanceEntry];
            self.textLabel.backgroundColor = [UIColor clearColor];
            badge.badgeColor = [GeneralStyleSheet defaultBackgroundColorForPerformanceEntry];
            badge.backgroundColor = [UIColor clearColor];
            badge.textLabel.text = @"P";
            [self setAccessoryView:badge];
            break;    
        default:
            break;
    }
 
    
    
}
@end
