//
//  NSDictionary+JSON.h
//  ROMobileUniversal
//
//  Created by Dirk Lewis on 12/5/11.
//  Copyright Video Hoo Haa. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSDictionary( JSON )

+(NSDictionary*)dictionaryWithContentsOfJSONURLString: (NSString*)urlAddress;
+ (NSDictionary*)dictionaryWithContentsOfJSONString:(NSString*)string;
-(NSData*)toJSON;

@end
