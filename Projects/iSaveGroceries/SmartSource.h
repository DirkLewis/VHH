//
//  SmartSource.h
//  iSaveGroceries
//
//  Created by Dirk on 2/11/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface SmartSource : NSObject
+ (void)clearCookiesForURL:(NSURL*)url;
+ (void)requestPostalcodeData:(NSString*)zipCode results:(SmartSourceResultsBlock)block;
+ (void)requestGroceryStoreDataByLocation:(Location*)location results:(SmartSourceResultsBlock)block;
+ (void)requestSaleItemsByGroceryStore:(GroceryStore*)groceryStore results:(SmartSourceResultsBlock)block;
@end
