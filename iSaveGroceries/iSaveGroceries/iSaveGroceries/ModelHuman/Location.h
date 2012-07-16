#import "_Location.h"

@interface Location : _Location {}
// Custom logic goes here.

+ (BOOL)locationExistsForZipCode:(NSString*)zipCode countyID:(NSString*)countyID;
+ (BOOL)storeLocationFromDictionary:(NSDictionary*)smartSourceLocationDictionary;
+ (NSArray*)fetchLocationsSortedByCityAndCounty;
+ (Location*)fetchLocationForZipCodeAndCountyID:(NSString*)zipCode countyID:(NSString*)countyID;
+ (NSFetchRequest*)fetchRequestForLocation;
+ (NSArray*)fetchArrayOfAllLocationsSortedByCityName;
+ (NSFetchRequest*)fetchRequestForLocationSortedByCityAndCountyName;
@end
