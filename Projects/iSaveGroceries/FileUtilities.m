//
//  FileUtilities.m
//  ROMobileUniversal
//
//  Created by Dirk Lewis on 12/12/11.
//  Copyright Video Hoo Haa. All rights reserved.
//

#import "FileUtilities.h"

@implementation FileUtilities

#pragma mark - Shared Methods

+ (BOOL)validateAndOrCreateDocumentDirectoryForSaving
{

    BOOL isDir;
    
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    
    if ([paths count] == 1) {
        
        NSFileManager *fileManager = [[NSFileManager alloc] init];
        
        if (!([fileManager fileExistsAtPath:[paths objectAtIndex:0] isDirectory:&isDir] && isDir)) {
            
            NSError *error = nil;
            
            [[NSFileManager defaultManager] createDirectoryAtPath:[paths objectAtIndex:0] withIntermediateDirectories:YES attributes:nil error:&error];
            
            if (error) {
#warning TODO: Log directory creation error
                return NO;
            }
            else{
                // directory exists for saving
                return YES;
            }
        }
        else{
        
            //directory exists for saving
            return YES;
        
        }
    }
    
#warning  TODO: log too many paths returned error
    return NO;
}

+ (NSURL*)applicationDocumentsDirectoryURL
{
    return [[[NSFileManager defaultManager] URLsForDirectory:NSDocumentDirectory inDomains:NSUserDomainMask] lastObject];
}

+ (NSString*)applicationDocumentsDirectoryStringPath
{
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);

    if ([paths count] == 1) {
        return [paths objectAtIndex:0];
    }
    else{
    
#warning TODO: add error logging
    }
    
    return @"PATH NOT FOUND";
}

@end
