// DO NOT EDIT. This file is machine-generated and constantly overwritten.
// Make changes to SaleItem.m instead.

#import "_SaleItem.h"

const struct SaleItemAttributes SaleItemAttributes = {
	.category = @"category",
	.comment = @"comment",
	.imageName = @"imageName",
	.itemDescription = @"itemDescription",
	.regularPrice = @"regularPrice",
	.saleEndDate = @"saleEndDate",
	.salePrice = @"salePrice",
	.weight = @"weight",
};

const struct SaleItemRelationships SaleItemRelationships = {
	.saleItemToSaleHistory = @"saleItemToSaleHistory",
	.saleItemToShoppingList = @"saleItemToShoppingList",
	.saleItemToStore = @"saleItemToStore",
};

const struct SaleItemFetchedProperties SaleItemFetchedProperties = {
};

@implementation SaleItemID
@end

@implementation _SaleItem

+ (id)insertInManagedObjectContext:(NSManagedObjectContext*)moc_ {
	NSParameterAssert(moc_);
	return [NSEntityDescription insertNewObjectForEntityForName:@"SaleItem" inManagedObjectContext:moc_];
}

+ (NSString*)entityName {
	return @"SaleItem";
}

+ (NSEntityDescription*)entityInManagedObjectContext:(NSManagedObjectContext*)moc_ {
	NSParameterAssert(moc_);
	return [NSEntityDescription entityForName:@"SaleItem" inManagedObjectContext:moc_];
}

- (SaleItemID*)objectID {
	return (SaleItemID*)[super objectID];
}

+ (NSSet *)keyPathsForValuesAffectingValueForKey:(NSString *)key {
	NSSet *keyPaths = [super keyPathsForValuesAffectingValueForKey:key];
	

	return keyPaths;
}




@dynamic category;






@dynamic comment;






@dynamic imageName;






@dynamic itemDescription;






@dynamic regularPrice;






@dynamic saleEndDate;






@dynamic salePrice;






@dynamic weight;






@dynamic saleItemToSaleHistory;

	
- (NSMutableSet*)saleItemToSaleHistorySet {
	[self willAccessValueForKey:@"saleItemToSaleHistory"];
  
	NSMutableSet *result = (NSMutableSet*)[self mutableSetValueForKey:@"saleItemToSaleHistory"];
  
	[self didAccessValueForKey:@"saleItemToSaleHistory"];
	return result;
}
	

@dynamic saleItemToShoppingList;

	
- (NSMutableSet*)saleItemToShoppingListSet {
	[self willAccessValueForKey:@"saleItemToShoppingList"];
  
	NSMutableSet *result = (NSMutableSet*)[self mutableSetValueForKey:@"saleItemToShoppingList"];
  
	[self didAccessValueForKey:@"saleItemToShoppingList"];
	return result;
}
	

@dynamic saleItemToStore;

	





@end
