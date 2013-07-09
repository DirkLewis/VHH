// DO NOT EDIT. This file is machine-generated and constantly overwritten.
// Make changes to Person.m instead.

#import "_Person.h"

const struct PersonAttributes PersonAttributes = {
	.firstName = @"firstName",
	.lastName = @"lastName",
};

const struct PersonRelationships PersonRelationships = {
	.personToAddress = @"personToAddress",
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
	

	return keyPaths;
}




@dynamic firstName;






@dynamic lastName;






@dynamic personToAddress;

	
- (NSMutableSet*)personToAddressSet {
	[self willAccessValueForKey:@"personToAddress"];
  
	NSMutableSet *result = (NSMutableSet*)[self mutableSetValueForKey:@"personToAddress"];
  
	[self didAccessValueForKey:@"personToAddress"];
	return result;
}
	






@end
