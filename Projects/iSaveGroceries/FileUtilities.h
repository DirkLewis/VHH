//
//  FileUtilities.h
//  ROMobileUniversal
//
//  Created by Dirk Lewis on 12/12/11.
//  Copyright Video Hoo Haa. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface FileUtilities : NSObject

+ (BOOL)validateAndOrCreateDocumentDirectoryForSaving;
+ (NSURL*)applicationDocumentsDirectoryURL;
+ (NSString*)applicationDocumentsDirectoryStringPath;

@end
