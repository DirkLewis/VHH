// DO NOT EDIT. This file is machine-generated and constantly overwritten.
// Make changes to Person.m instead.

#import "_Person.h"

const struct PersonAttributes PersonAttributes = {
	.address = @"address",
	.age = @"age",
	.firstName = @"firstName",
	.lastName = @"lastName",
	.moreSecrets = @"moreSecrets",
	.secrets = @"secrets",
};

const struct PersonRelationships PersonRelationships = {
	.personToToy = @"personToToy",
};

const struct PersonFetchedProperties PersonFetchedProperties = {
};

@implementation PersonID
@end

@implementation _Person

+ (id)insertInManagedObjectContext:(NSManagedObjectContext*)moc_ {
	NSParameterAssert(moc_);
	return [NSEntityDescription insertNewObjectForEntityForName:@"Person" inManagedObjectContext:moc_];
}

+ (NSString*)entityName {
	return @"Person";
}

+ (NSEntityDescription*)entityInManagedObjectContext:(NSManagedObjectContext*)moc_ {
	NSParameterAssert(moc_);
	return [NSEntityDescription entityForName:@"Person" inManagedObjectContext:moc_];
}

- (PersonID*)objectID {
	return (PersonID*)[super objectID];
}

+ (NSSet *)keyPathsForValuesAffectingValueForKey:(NSString *)key {
	NSSet *keyPaths = [super keyPathsForValuesAffectingValueForKey:key];
	
	if ([key isEqualToString:@"ageValue"]) {
		NSSet *affectingKey = [NSSet setWithObject:@"age"];
		keyPaths = [keyPaths setByAddingObjectsFromSet:affectingKey];
	}

	return keyPaths;
}




@dynamic address;






@dynamic age;



- (int16_t)ageValue {
	NSNumber *result = [self age];
	return [result shortValue];
}

- (void)setAgeValue:(int16_t)value_ {
	[self setAge:[NSNumber numberWithShort:value_]];
}

- (int16_t)primitiveAgeValue {
	NSNumber *result = [self primitiveAge];
	return [result shortValue];
}

- (void)setPrimitiveAgeValue:(int16_t)value_ {
	[self setPrimitiveAge:[NSNumber numberWithShort:value_]];
}





@dynamic firstName;






@dynamic lastName;






@dynamic moreSecrets;






@dynamic secrets;






@dynamic personToToy;

	
- (NSMutableSet*)personToToySet {
	[self willAccessValueForKey:@"personToToy"];
  
	NSMutableSet *result = (NSMutableSet*)[self mutableSetValueForKey:@"personToToy"];
  
	[self didAccessValueForKey:@"personToToy"];
	return result;
}
	






@end
