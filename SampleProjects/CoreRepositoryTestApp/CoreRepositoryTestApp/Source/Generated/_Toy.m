// DO NOT EDIT. This file is machine-generated and constantly overwritten.
// Make changes to Toy.m instead.

#import "_Toy.h"

const struct ToyAttributes ToyAttributes = {
	.toyImage = @"toyImage",
	.toyName = @"toyName",
	.toyValue = @"toyValue",
};

const struct ToyRelationships ToyRelationships = {
	.toyToPerson = @"toyToPerson",
};

const struct ToyFetchedProperties ToyFetchedProperties = {
};

@implementation ToyID
@end

@implementation _Toy

+ (id)insertInManagedObjectContext:(NSManagedObjectContext*)moc_ {
	NSParameterAssert(moc_);
	return [NSEntityDescription insertNewObjectForEntityForName:@"Toy" inManagedObjectContext:moc_];
}

+ (NSString*)entityName {
	return @"Toy";
}

+ (NSEntityDescription*)entityInManagedObjectContext:(NSManagedObjectContext*)moc_ {
	NSParameterAssert(moc_);
	return [NSEntityDescription entityForName:@"Toy" inManagedObjectContext:moc_];
}

- (ToyID*)objectID {
	return (ToyID*)[super objectID];
}

+ (NSSet *)keyPathsForValuesAffectingValueForKey:(NSString *)key {
	NSSet *keyPaths = [super keyPathsForValuesAffectingValueForKey:key];
	

	return keyPaths;
}




@dynamic toyImage;






@dynamic toyName;






@dynamic toyValue;






@dynamic toyToPerson;

	






@end
