//
//  NSDictionary+JSON.m
//  ROMobileUniversal
//
//  Created by Dirk Lewis on 12/5/11.
//  Copyright Video Hoo Haa. All rights reserved.
//

#import "NSDictionary+JSON.h"

@implementation NSDictionary( JSON )
+(NSDictionary*)dictionaryWithContentsOfJSONURLString:(NSString*)urlAddress
{
    NSData* data = [NSData dataWithContentsOfURL:
                    [NSURL URLWithString: urlAddress] ];
    __autoreleasing NSError *error = nil;
    id result = [NSJSONSerialization JSONObjectWithData:data 
                                                options:kNilOptions error:&error];
    if (error != nil) return nil;
    return result;
}

+ (NSDictionary*)dictionaryWithContentsOfJSONString:(NSString*)string{

    __autoreleasing NSError *error = nil;
    NSData *data = [string dataUsingEncoding:NSUTF8StringEncoding];
    
    id result = [NSJSONSerialization JSONObjectWithData:data options:kNilOptions error:&error];
    
    if (error) {
        return nil;
    }
    
    return result;
}

-(NSData*)toJSON
{
    NSError* error = nil;
    id result = [NSJSONSerialization dataWithJSONObject:self 
                                                options:kNilOptions error:&error];
    if (error != nil) return nil;
    return result;    
}
@end
