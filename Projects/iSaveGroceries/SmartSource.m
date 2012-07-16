//
//  SmartSource.m
//  iSaveGroceries
//
//  Created by Dirk on 2/11/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "SmartSource.h"

@implementation SmartSource

+ (void)clearCookiesForURL:(NSURL*)url{

    NSHTTPCookieStorage *cookieStorage = [NSHTTPCookieStorage sharedHTTPCookieStorage];
    for (NSHTTPCookie *each in [[cookieStorage cookiesForURL:url] copy]) {
        if ([each.name isEqualToStringCaseInsensitive:@"MSS_MGD_GUEST_ZIP"] || [each.name isEqualToStringCaseInsensitive:@"MSS_MGD_COUNTYID"] || [each.name  isEqualToStringCaseInsensitive:@"MSS_GUEST_USER_STORES"]) {
            [cookieStorage deleteCookie:each];
        }
    }
    NSLog(@"%@", [cookieStorage cookiesForURL:url]);

    

}

+ (void)requestSaleItemsByGroceryStore:(GroceryStore*)groceryStore results:(SmartSourceResultsBlock)block{

    NSString *escapedGroceryStore = [groceryStore.groceryStoreName stringByEscapingReservedURLCharacters];
    NSURL *url = [NSURL URLWithString:[NSString stringWithFormat:@"http://smartsource.mygrocerydeals.com/index.cfm?fuseaction=endeca.dspAllCategories&GUEST_USER_STORES=%@&perPage=500",escapedGroceryStore]];
        
    NSURLRequest *request = [NSURLRequest requestWithURL:url];
  
    
    AFHTTPRequestOperation *operation = [[AFHTTPRequestOperation alloc] initWithRequest:request];
    
    [operation setCompletionBlockWithSuccess:^(AFHTTPRequestOperation *operation, id responseObject) {
        
        block(responseObject);
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        
        NSLog(@"fail");
        
    }];
    
    NSOperationQueue *queue = [[NSOperationQueue alloc]init];
    [queue addOperation:operation];
    
}

+ (void)requestPostalcodeData:(NSString*)zipCode results:(SmartSourceResultsBlock)block{
    
    NSURL *url = [NSURL URLWithString:[NSString stringWithFormat:@"http://smartsource.mygrocerydeals.com/index.cfm?fuseaction=usr.getLocationInfoFromZip&strpostalcode=%@&_=",zipCode]];
    //[SmartSource clearCookiesForURL:url];

    NSURLRequest *request = [NSURLRequest requestWithURL:url];
    
    
    AFHTTPRequestOperation *operation = [[AFHTTPRequestOperation alloc] initWithRequest:request];
    
    [operation setCompletionBlockWithSuccess:^(AFHTTPRequestOperation *operation, id responseObject) {
        
        block(responseObject);
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        
        NSLog(@"fail");
        
    }];
    
    NSOperationQueue *queue = [[NSOperationQueue alloc]init];
    [queue addOperation:operation];

}


+ (void)requestGroceryStoreDataByLocation:(Location*)location results:(SmartSourceResultsBlock)block{


    NSURL *url = [NSURL URLWithString:[NSString stringWithFormat:@"http://smartsource.mygrocerydeals.com/index.cfm?fuseaction=usr.dspSetGuestStores&countyId=%@&zip=%@&all_stores=true",location.countyID, location.zipCode]];
    //[SmartSource clearCookiesForURL:url];

    NSURLRequest *request = [NSURLRequest requestWithURL:url];
    
    AFHTTPRequestOperation *operation = [[AFHTTPRequestOperation alloc] initWithRequest:request];
    
    [operation setCompletionBlockWithSuccess:^(AFHTTPRequestOperation *operation, id responseObject) {
        
        NSLog(@"success");
        
        NSHTTPURLResponse *response = [operation response];
        
        NSPredicate *predicate = [NSPredicate predicateWithBlock:^BOOL(id evaluatedObject, NSDictionary *bindings) {
            
            NSHTTPCookie *cookie = (NSHTTPCookie*)evaluatedObject;
            
            if ([[cookie name] isEqualToString:@"MSS_GUEST_USER_STORES"]) {
                return YES;

            }
            return NO;
            
        }];
        
        NSArray *all = [[NSHTTPCookie cookiesWithResponseHeaderFields:[response allHeaderFields] forURL:url] filteredArrayUsingPredicate:predicate];
        
        if (all && [all count]>0) {
            
            NSHTTPCookie *cookie = [all objectAtIndex:0];
            
            if (cookie) {
                NSString *storeList = cookie.value;
                
                block([SmartSourceElementParser parseGroceryStores:storeList]);
            }
            else{
                block(nil);
            }  
        }
        else{
            block(nil);
        }


        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        
        NSLog(@"fail");
        
    }];
    
    
    NSOperationQueue *queue = [[NSOperationQueue alloc]init];
    [queue addOperation:operation];

}

@end
