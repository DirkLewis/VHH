//
//  SystemLogSummaryTableViewCell.m
//  ROMobileUniversal
//
//  Created by JoseB on 2/24/12.
//  Copyright (c) 2012 Optima HCS. All rights reserved.
//

#import "SystemLogSummaryTableViewCell.h"
#import "LoggingDefinition.h"
@implementation SystemLogSummaryTableViewCell

+ (CGFloat)rowHeight{
    return 55;
}

+ (CGFloat)rowExpandedHeight{
    return 100;
}

+ (BOOL) isHeaderFooter{
    return NO;
}

- (void)configureForData:(id)dataObject tableView:(UITableView *)tableView indexPath:(NSIndexPath *)indexPath{

    NSDictionary *logDictionary = (NSDictionary*)dataObject;
    self.logEntries = (NSArray*)[logDictionary objectForKey:@"logEntries"];
    self.logType = [logDictionary valueForKey:@"title"];
    self.logTypeTitleLabel.text = [NSString stringWithFormat:@"%@", self.logType];
    self.logCountLabel.text = [NSString stringWithFormat:@"%i", [self.logEntries count]];

    NSArray *errors = [self.logEntries filteredArrayUsingPredicate:[NSPredicate predicateWithFormat:@"level IN {%i, %i, %i, %i}", LOG_FLAG_AUTH_ERROR,LOG_FLAG_DOCUMENT_ERROR,LOG_FLAG_ACCESS_ERROR,LOG_FLAG_SYSTEM_ERROR]];
    self.errorCountLabel.text = [NSString stringWithFormat:@"Errors: %i", [errors count]];
    
    NSArray *warnings = [self.logEntries filteredArrayUsingPredicate:[NSPredicate predicateWithFormat:@"level IN {%i, %i, %i, %i}",LOG_FLAG_AUTH_WARN,LOG_FLAG_DOCUMENT_WARN,LOG_FLAG_ACCESS_WARN,LOG_FLAG_SYSTEM_WARN]];
    self.warningCountLabel.text = [NSString stringWithFormat:@"Warnings: %i", [warnings count]];
    
    NSArray *info = [self.logEntries filteredArrayUsingPredicate:[NSPredicate predicateWithFormat:@"level IN {%i, %i, %i, %i}",LOG_FLAG_AUTH_INFO,LOG_FLAG_DOCUMENT_INFO,LOG_FLAG_ACCESS_INFO,LOG_FLAG_SYSTEM_INFO]];
    self.infoCountLabel.text = [NSString stringWithFormat:@"Information: %i", [info count]];
    
    NSArray *verbose = [self.logEntries filteredArrayUsingPredicate:[NSPredicate predicateWithFormat:@"level IN {%i, %i, %i, %i}",LOG_FLAG_AUTH_VERBOSE,LOG_FLAG_DOCUMENT_VERBOSE,LOG_FLAG_ACCESS_VERBOSE,LOG_FLAG_SYSTEM_VERBOSE]];
    self.verboseCountLabel.text = [NSString stringWithFormat:@"Verbose: %i", [verbose count]];
    
}

//+ (NSString *)reuseIdentifier{
//    return @"SystemLogSummaryCell";
//}

@end
