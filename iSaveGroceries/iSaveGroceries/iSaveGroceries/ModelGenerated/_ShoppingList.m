// DO NOT EDIT. This file is machine-generated and constantly overwritten.
// Make changes to ShoppingList.m instead.

#import "_ShoppingList.h"

const struct ShoppingListAttributes ShoppingListAttributes = {
};

const struct ShoppingListRelationships ShoppingListRelationships = {
	.shoppingListToSaleItem = @"shoppingListToSaleItem",
};

const struct ShoppingListFetchedProperties ShoppingListFetchedProperties = {
};

@implementation ShoppingListID
@end

@implementation _ShoppingList

+ (id)insertInManagedObjectContext:(NSManagedObjectContext*)moc_ {
	NSParameterAssert(moc_);
	return [NSEntityDescription insertNewObjectForEntityForName:@"ShoppingList" inManagedObjectContext:moc_];
}

+ (NSString*)entityName {
	return @"ShoppingList";
}

+ (NSEntityDescription*)entityInManagedObjectContext:(NSManagedObjectContext*)moc_ {
	NSParameterAssert(moc_);
	return [NSEntityDescription entityForName:@"ShoppingList" inManagedObjectContext:moc_];
}

- (ShoppingListID*)objectID {
	return (ShoppingListID*)[super objectID];
}

+ (NSSet *)keyPathsForValuesAffectingValueForKey:(NSString *)key {
	NSSet *keyPaths = [super keyPathsForValuesAffectingValueForKey:key];
	

	return keyPaths;
}




@dynamic shoppingListToSaleItem;

	





@end
