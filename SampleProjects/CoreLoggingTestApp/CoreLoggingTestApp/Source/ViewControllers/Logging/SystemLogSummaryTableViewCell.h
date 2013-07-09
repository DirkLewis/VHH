//
//  SystemLogSummaryTableViewCell.h
//  ROMobileUniversal
//
//  Created by JoseB on 2/24/12.
//  Copyright (c) 2012 Optima HCS. All rights reserved.
//

#import <FlexibleTableLibrary/FlexibleTableViewCell.h>

@interface SystemLogSummaryTableViewCell : FlexibleTableViewCell

@property (strong, nonatomic) NSArray *logEntries;
@property (strong, nonatomic) NSString *logType;

@property (strong, nonatomic) IBOutlet UILabel *logTypeTitleLabel;
@property (strong, nonatomic) IBOutlet UILabel *errorCountLabel;
@property (strong, nonatomic) IBOutlet UILabel *warningCountLabel;
@property (strong, nonatomic) IBOutlet UILabel *infoCountLabel;
@property (strong, nonatomic) IBOutlet UILabel *logCountLabel;
@property (strong, nonatomic) IBOutlet UILabel *verboseCountLabel;

@end
