// DO NOT EDIT. This file is machine-generated and constantly overwritten.
// Make changes to PurchaseHIstory.m instead.

#import "_PurchaseHIstory.h"

const struct PurchaseHIstoryAttributes PurchaseHIstoryAttributes = {
	.quantitiy = @"quantitiy",
	.salePrice = @"salePrice",
};

const struct PurchaseHIstoryRelationships PurchaseHIstoryRelationships = {
	.saleHistoryToSaleItem = @"saleHistoryToSaleItem",
};

const struct PurchaseHIstoryFetchedProperties PurchaseHIstoryFetchedProperties = {
};

@implementation PurchaseHIstoryID
@end

@implementation _PurchaseHIstory

+ (id)insertInManagedObjectContext:(NSManagedObjectContext*)moc_ {
	NSParameterAssert(moc_);
	return [NSEntityDescription insertNewObjectForEntityForName:@"PurchaseHIstory" inManagedObjectContext:moc_];
}

+ (NSString*)entityName {
	return @"PurchaseHIstory";
}

+ (NSEntityDescription*)entityInManagedObjectContext:(NSManagedObjectContext*)moc_ {
	NSParameterAssert(moc_);
	return [NSEntityDescription entityForName:@"PurchaseHIstory" inManagedObjectContext:moc_];
}

- (PurchaseHIstoryID*)objectID {
	return (PurchaseHIstoryID*)[super objectID];
}

+ (NSSet *)keyPathsForValuesAffectingValueForKey:(NSString *)key {
	NSSet *keyPaths = [super keyPathsForValuesAffectingValueForKey:key];
	
	if ([key isEqualToString:@"quantitiyValue"]) {
		NSSet *affectingKey = [NSSet setWithObject:@"quantitiy"];
		keyPaths = [keyPaths setByAddingObjectsFromSet:affectingKey];
	}

	return keyPaths;
}




@dynamic quantitiy;



- (short)quantitiyValue {
	NSNumber *result = [self quantitiy];
	return [result shortValue];
}

- (void)setQuantitiyValue:(short)value_ {
	[self setQuantitiy:[NSNumber numberWithShort:value_]];
}

- (short)primitiveQuantitiyValue {
	NSNumber *result = [self primitiveQuantitiy];
	return [result shortValue];
}

- (void)setPrimitiveQuantitiyValue:(short)value_ {
	[self setPrimitiveQuantitiy:[NSNumber numberWithShort:value_]];
}





@dynamic salePrice;






@dynamic saleHistoryToSaleItem;

	





@end
