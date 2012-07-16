// DO NOT EDIT. This file is machine-generated and constantly overwritten.
// Make changes to GroceryStore.m instead.

#import "_GroceryStore.h"

const struct GroceryStoreAttributes GroceryStoreAttributes = {
	.favoriteStore = @"favoriteStore",
	.groceryStoreName = @"groceryStoreName",
	.lastUpdated = @"lastUpdated",
	.numberOfSaleItems = @"numberOfSaleItems",
};

const struct GroceryStoreRelationships GroceryStoreRelationships = {
	.storeToLocation = @"storeToLocation",
	.storeToSaleItem = @"storeToSaleItem",
};

const struct GroceryStoreFetchedProperties GroceryStoreFetchedProperties = {
};

@implementation GroceryStoreID
@end

@implementation _GroceryStore

+ (id)insertInManagedObjectContext:(NSManagedObjectContext*)moc_ {
	NSParameterAssert(moc_);
	return [NSEntityDescription insertNewObjectForEntityForName:@"GroceryStore" inManagedObjectContext:moc_];
}

+ (NSString*)entityName {
	return @"GroceryStore";
}

+ (NSEntityDescription*)entityInManagedObjectContext:(NSManagedObjectContext*)moc_ {
	NSParameterAssert(moc_);
	return [NSEntityDescription entityForName:@"GroceryStore" inManagedObjectContext:moc_];
}

- (GroceryStoreID*)objectID {
	return (GroceryStoreID*)[super objectID];
}

+ (NSSet *)keyPathsForValuesAffectingValueForKey:(NSString *)key {
	NSSet *keyPaths = [super keyPathsForValuesAffectingValueForKey:key];
	
	if ([key isEqualToString:@"favoriteStoreValue"]) {
		NSSet *affectingKey = [NSSet setWithObject:@"favoriteStore"];
		keyPaths = [keyPaths setByAddingObjectsFromSet:affectingKey];
	}
	if ([key isEqualToString:@"numberOfSaleItemsValue"]) {
		NSSet *affectingKey = [NSSet setWithObject:@"numberOfSaleItems"];
		keyPaths = [keyPaths setByAddingObjectsFromSet:affectingKey];
	}

	return keyPaths;
}




@dynamic favoriteStore;



- (BOOL)favoriteStoreValue {
	NSNumber *result = [self favoriteStore];
	return [result boolValue];
}

- (void)setFavoriteStoreValue:(BOOL)value_ {
	[self setFavoriteStore:[NSNumber numberWithBool:value_]];
}

- (BOOL)primitiveFavoriteStoreValue {
	NSNumber *result = [self primitiveFavoriteStore];
	return [result boolValue];
}

- (void)setPrimitiveFavoriteStoreValue:(BOOL)value_ {
	[self setPrimitiveFavoriteStore:[NSNumber numberWithBool:value_]];
}





@dynamic groceryStoreName;






@dynamic lastUpdated;






@dynamic numberOfSaleItems;



- (short)numberOfSaleItemsValue {
	NSNumber *result = [self numberOfSaleItems];
	return [result shortValue];
}

- (void)setNumberOfSaleItemsValue:(short)value_ {
	[self setNumberOfSaleItems:[NSNumber numberWithShort:value_]];
}

- (short)primitiveNumberOfSaleItemsValue {
	NSNumber *result = [self primitiveNumberOfSaleItems];
	return [result shortValue];
}

- (void)setPrimitiveNumberOfSaleItemsValue:(short)value_ {
	[self setPrimitiveNumberOfSaleItems:[NSNumber numberWithShort:value_]];
}





@dynamic storeToLocation;

	

@dynamic storeToSaleItem;

	
- (NSMutableSet*)storeToSaleItemSet {
	[self willAccessValueForKey:@"storeToSaleItem"];
  
	NSMutableSet *result = (NSMutableSet*)[self mutableSetValueForKey:@"storeToSaleItem"];
  
	[self didAccessValueForKey:@"storeToSaleItem"];
	return result;
}
	





@end
