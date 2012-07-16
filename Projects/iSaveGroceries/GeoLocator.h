//
//  GeoLocator.h
//  iSaveGroceries
//
//  Created by Dirk on 2/11/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface GeoLocator : NSObject

+ (void)requestReverseGeoCodeForLocation:(CLLocation*)location results:(GeoDataResultsBlock)block;

@end
