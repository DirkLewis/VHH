//
//  NSDictionary+Location.h
//  iSaveGroceries
//
//  Created by Dirk on 2/11/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSDictionary (Location)
- (NSString*)zipCodeFromLocation;
- (NSString*)stateFromLocation;
- (NSString*)countryFromLocation;
@end
