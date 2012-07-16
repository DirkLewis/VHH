//
//  GeoLocator.m
//  iSaveGroceries
//
//  Created by Dirk on 2/11/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "GeoLocator.h"

@implementation GeoLocator

+ (void)requestReverseGeoCodeForLocation:(CLLocation*)location results:(GeoDataResultsBlock)block {
    
    NSString *url = [NSString stringWithFormat:@"http://maps.google.com/maps/geo?q=%f,%f&output=json", location.coordinate.latitude,location.coordinate.longitude];
    
    NSURLRequest *request = [NSURLRequest requestWithURL:[NSURL URLWithString:url]];
    AFJSONRequestOperation *operation = [AFJSONRequestOperation JSONRequestOperationWithRequest:request success:^(NSURLRequest *request, NSHTTPURLResponse *response, id JSON) {
    
        NSDictionary *results = JSON;
        
        block(results);
        
    } failure:^(NSURLRequest *request, NSHTTPURLResponse *response, NSError *error, id JSON) {
        NSLog(@"fail");
    }];
    

    NSOperationQueue *queue = [[NSOperationQueue alloc]init];
    [queue addOperation:operation];

}

@end
