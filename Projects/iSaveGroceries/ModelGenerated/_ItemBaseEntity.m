// DO NOT EDIT. This file is machine-generated and constantly overwritten.
// Make changes to ItemBaseEntity.m instead.

#import "_ItemBaseEntity.h"

const struct ItemBaseEntityAttributes ItemBaseEntityAttributes = {
	.createdDate = @"createdDate",
	.isFavorite = @"isFavorite",
};

const struct ItemBaseEntityRelationships ItemBaseEntityRelationships = {
};

const struct ItemBaseEntityFetchedProperties ItemBaseEntityFetchedProperties = {
};

@implementation ItemBaseEntityID
@end

@implementation _ItemBaseEntity

+ (id)insertInManagedObjectContext:(NSManagedObjectContext*)moc_ {
	NSParameterAssert(moc_);
	return [NSEntityDescription insertNewObjectForEntityForName:@"ItemBaseEntity" inManagedObjectContext:moc_];
}

+ (NSString*)entityName {
	return @"ItemBaseEntity";
}

+ (NSEntityDescription*)entityInManagedObjectContext:(NSManagedObjectContext*)moc_ {
	NSParameterAssert(moc_);
	return [NSEntityDescription entityForName:@"ItemBaseEntity" inManagedObjectContext:moc_];
}

- (ItemBaseEntityID*)objectID {
	return (ItemBaseEntityID*)[super objectID];
}

+ (NSSet *)keyPathsForValuesAffectingValueForKey:(NSString *)key {
	NSSet *keyPaths = [super keyPathsForValuesAffectingValueForKey:key];
	
	if ([key isEqualToString:@"isFavoriteValue"]) {
		NSSet *affectingKey = [NSSet setWithObject:@"isFavorite"];
		keyPaths = [keyPaths setByAddingObjectsFromSet:affectingKey];
	}

	return keyPaths;
}




@dynamic createdDate;






@dynamic isFavorite;



- (BOOL)isFavoriteValue {
	NSNumber *result = [self isFavorite];
	return [result boolValue];
}

- (void)setIsFavoriteValue:(BOOL)value_ {
	[self setIsFavorite:[NSNumber numberWithBool:value_]];
}

- (BOOL)primitiveIsFavoriteValue {
	NSNumber *result = [self primitiveIsFavorite];
	return [result boolValue];
}

- (void)setPrimitiveIsFavoriteValue:(BOOL)value_ {
	[self setPrimitiveIsFavorite:[NSNumber numberWithBool:value_]];
}









@end
