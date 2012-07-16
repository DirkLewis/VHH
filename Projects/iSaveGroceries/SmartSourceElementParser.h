//
//  SmartSourceElementParser.h
//  iSaveGroceries
//
//  Created by Dirk on 2/11/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface SmartSourceElementParser : NSObject

+ (NSArray*)parseLocationInformation:(NSString*)locationInfo;
+ (NSArray*)parseGroceryStores:(NSString*)groceryStores;
+ (NSArray*)parseGrocerySaleItems:(NSString*)grocerySaleItems;

@end
