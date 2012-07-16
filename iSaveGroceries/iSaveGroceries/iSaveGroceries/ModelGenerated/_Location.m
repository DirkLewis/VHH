// DO NOT EDIT. This file is machine-generated and constantly overwritten.
// Make changes to Location.m instead.

#import "_Location.h"

const struct LocationAttributes LocationAttributes = {
	.cityName = @"cityName",
	.communityID = @"communityID",
	.communityName = @"communityName",
	.country = @"country",
	.countyID = @"countyID",
	.countyName = @"countyName",
	.favoriteLocation = @"favoriteLocation",
	.stateID = @"stateID",
	.stateName = @"stateName",
	.zipCode = @"zipCode",
};

const struct LocationRelationships LocationRelationships = {
	.locationToStore = @"locationToStore",
};

const struct LocationFetchedProperties LocationFetchedProperties = {
};

@implementation LocationID
@end

@implementation _Location

+ (id)insertInManagedObjectContext:(NSManagedObjectContext*)moc_ {
	NSParameterAssert(moc_);
	return [NSEntityDescription insertNewObjectForEntityForName:@"Location" inManagedObjectContext:moc_];
}

+ (NSString*)entityName {
	return @"Location";
}

+ (NSEntityDescription*)entityInManagedObjectContext:(NSManagedObjectContext*)moc_ {
	NSParameterAssert(moc_);
	return [NSEntityDescription entityForName:@"Location" inManagedObjectContext:moc_];
}

- (LocationID*)objectID {
	return (LocationID*)[super objectID];
}

+ (NSSet *)keyPathsForValuesAffectingValueForKey:(NSString *)key {
	NSSet *keyPaths = [super keyPathsForValuesAffectingValueForKey:key];
	
	if ([key isEqualToString:@"favoriteLocationValue"]) {
		NSSet *affectingKey = [NSSet setWithObject:@"favoriteLocation"];
		keyPaths = [keyPaths setByAddingObjectsFromSet:affectingKey];
	}

	return keyPaths;
}




@dynamic cityName;






@dynamic communityID;






@dynamic communityName;






@dynamic country;






@dynamic countyID;






@dynamic countyName;






@dynamic favoriteLocation;



- (BOOL)favoriteLocationValue {
	NSNumber *result = [self favoriteLocation];
	return [result boolValue];
}

- (void)setFavoriteLocationValue:(BOOL)value_ {
	[self setFavoriteLocation:[NSNumber numberWithBool:value_]];
}

- (BOOL)primitiveFavoriteLocationValue {
	NSNumber *result = [self primitiveFavoriteLocation];
	return [result boolValue];
}

- (void)setPrimitiveFavoriteLocationValue:(BOOL)value_ {
	[self setPrimitiveFavoriteLocation:[NSNumber numberWithBool:value_]];
}





@dynamic stateID;






@dynamic stateName;






@dynamic zipCode;






@dynamic locationToStore;

	
- (NSMutableSet*)locationToStoreSet {
	[self willAccessValueForKey:@"locationToStore"];
  
	NSMutableSet *result = (NSMutableSet*)[self mutableSetValueForKey:@"locationToStore"];
  
	[self didAccessValueForKey:@"locationToStore"];
	return result;
}
	





@end
