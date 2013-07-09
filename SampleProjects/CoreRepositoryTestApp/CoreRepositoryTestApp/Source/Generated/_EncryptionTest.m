// DO NOT EDIT. This file is machine-generated and constantly overwritten.
// Make changes to EncryptionTest.m instead.

#import "_EncryptionTest.h"

const struct EncryptionTestAttributes EncryptionTestAttributes = {
	.testValue = @"testValue",
};

const struct EncryptionTestRelationships EncryptionTestRelationships = {
};

const struct EncryptionTestFetchedProperties EncryptionTestFetchedProperties = {
};

@implementation EncryptionTestID
@end

@implementation _EncryptionTest

+ (id)insertInManagedObjectContext:(NSManagedObjectContext*)moc_ {
	NSParameterAssert(moc_);
	return [NSEntityDescription insertNewObjectForEntityForName:@"EncryptionTest" inManagedObjectContext:moc_];
}

+ (NSString*)entityName {
	return @"EncryptionTest";
}

+ (NSEntityDescription*)entityInManagedObjectContext:(NSManagedObjectContext*)moc_ {
	NSParameterAssert(moc_);
	return [NSEntityDescription entityForName:@"EncryptionTest" inManagedObjectContext:moc_];
}

- (EncryptionTestID*)objectID {
	return (EncryptionTestID*)[super objectID];
}

+ (NSSet *)keyPathsForValuesAffectingValueForKey:(NSString *)key {
	NSSet *keyPaths = [super keyPathsForValuesAffectingValueForKey:key];
	

	return keyPaths;
}




@dynamic testValue;











@end
