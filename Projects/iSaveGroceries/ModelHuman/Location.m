#import "Location.h"

@implementation Location

// Custom logic goes here.
+ (NSArray *)sortDescriptorsForLocation{
    
	return [NSArray arrayWithObjects:[[NSSortDescriptor alloc] initWithKey:@"cityName" ascending:YES],[[NSSortDescriptor alloc] initWithKey:@"countyName" ascending:YES],nil];
    
}

+ (BOOL)storeLocationFromDictionary:(NSDictionary*)smartSourceLocationDictionary{
    
    if (![Location locationExistsForZipCode:[smartSourceLocationDictionary valueForKey:@"ZipCode"] countyID:[smartSourceLocationDictionary valueForKey:@"CountyID"]]) {
        Location *newLocation = [[iSaveRepository sharedInstance] insertNewEntityNamed:[Location className]];
        newLocation.zipCode = [smartSourceLocationDictionary valueForKey:@"ZipCode"];
        newLocation.countyID = [smartSourceLocationDictionary valueForKey:@"CountyID"];
        newLocation.countyName = [smartSourceLocationDictionary valueForKey:@"CountyName"];
        newLocation.country = [smartSourceLocationDictionary valueForKey:@"CountryName"];
        newLocation.communityID = [smartSourceLocationDictionary valueForKey:@"CommunityID"];
        newLocation.communityName = [smartSourceLocationDictionary valueForKey:@"CommunityName"];
        newLocation.stateID = [smartSourceLocationDictionary valueForKey:@"StateID"];
        newLocation.stateName = [smartSourceLocationDictionary valueForKey:@"StateName"];
        newLocation.cityName = [smartSourceLocationDictionary valueForKey:@"CityName"];
        
    }
    
    return [[iSaveRepository sharedInstance] save];
    
}

+ (Location*)fetchLocationForZipCodeAndCountyID:(NSString*)zipCode countyID:(NSString*)countyID{
    
    NSFetchRequest *fetchRequest = [self fetchRequestForLocation];
    
    NSPredicate *filter = [NSPredicate predicateWithFormat:@"zipCode == %@ && countyID == %@",zipCode,countyID];
    [fetchRequest setPredicate:filter];
    
    NSArray *fetchResults = [[iSaveRepository sharedInstance] resultsForRequest:fetchRequest];
    
    if ([fetchResults count] == 0) {
        return nil;
    }
    else if([fetchResults count] > 0){
        return [fetchResults objectAtIndex:0];
    }
    else{
        [NSException raise:@"Invalid Data" format:@"Duplicate entries in database found for zip:%@, county:%@",zipCode,countyID];
    }
    return nil;
    
}

+ (NSFetchRequest*)fetchRequestForLocationSortedByCityAndCountyName{
    
    NSFetchRequest *fetchRequest = [Location fetchRequestForLocation];
    [fetchRequest setFetchBatchSize:20];
    [fetchRequest setSortDescriptors:[Location sortDescriptorsForLocation]];
    return fetchRequest;
    
}

+ (NSFetchRequest*)fetchRequestForLocation{
    
    return [[iSaveRepository sharedInstance] fetchRequestForEntityNamed:[Location className]];
    
}

+ (BOOL)locationExistsForZipCode:(NSString*)zipCode countyID:(NSString*)countyID{
    
    if ([self fetchLocationForZipCodeAndCountyID:zipCode countyID:countyID]) {
        return YES;
    }
    
    return NO;;
}

+ (NSArray*)fetchArrayOfAllLocationsSortedByCityName{
    
    NSFetchRequest *fetchRequest = [Location fetchRequestForLocationSortedByCityAndCountyName];
    
    NSArray *fetchResults = [[iSaveRepository sharedInstance] resultsForRequest:fetchRequest];
    
    return fetchResults;
    
}

+ (NSArray*)fetchLocationsSortedByCityAndCounty{

    return nil;
}

@end
