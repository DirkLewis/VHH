// DO NOT EDIT. This file is machine-generated and constantly overwritten.
// Make changes to Address.m instead.

#import "_Address.h"

const struct AddressAttributes AddressAttributes = {
	.city = @"city",
	.state = @"state",
	.street = @"street",
	.streetNumber = @"streetNumber",
	.zip = @"zip",
};

const struct AddressRelationships AddressRelationships = {
	.addressToPerson = @"addressToPerson",
};

const struct AddressFetchedProperties AddressFetchedProperties = {
};

@implementation AddressID
@end

@implementation _Address

+ (id)insertInManagedObjectContext:(NSManagedObjectContext*)moc_ {
	NSParameterAssert(moc_);
	return [NSEntityDescription insertNewObjectForEntityForName:@"Address" inManagedObjectContext:moc_];
}

+ (NSString*)entityName {
	return @"Address";
}

+ (NSEntityDescription*)entityInManagedObjectContext:(NSManagedObjectContext*)moc_ {
	NSParameterAssert(moc_);
	return [NSEntityDescription entityForName:@"Address" inManagedObjectContext:moc_];
}

- (AddressID*)objectID {
	return (AddressID*)[super objectID];
}

+ (NSSet *)keyPathsForValuesAffectingValueForKey:(NSString *)key {
	NSSet *keyPaths = [super keyPathsForValuesAffectingValueForKey:key];
	

	return keyPaths;
}




@dynamic city;






@dynamic state;






@dynamic street;






@dynamic streetNumber;






@dynamic zip;






@dynamic addressToPerson;

	






@end
