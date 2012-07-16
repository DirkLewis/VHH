// DO NOT EDIT. This file is machine-generated and constantly overwritten.
// Make changes to ShoppingList.h instead.

#import <CoreData/CoreData.h>
#import "ItemBaseEntity.h"

extern const struct ShoppingListAttributes {
} ShoppingListAttributes;

extern const struct ShoppingListRelationships {
	__unsafe_unretained NSString *shoppingListToSaleItem;
} ShoppingListRelationships;

extern const struct ShoppingListFetchedProperties {
} ShoppingListFetchedProperties;

@class SaleItem;


@interface ShoppingListID : NSManagedObjectID {}
@end

@interface _ShoppingList : ItemBaseEntity {}
+ (id)insertInManagedObjectContext:(NSManagedObjectContext*)moc_;
+ (NSString*)entityName;
+ (NSEntityDescription*)entityInManagedObjectContext:(NSManagedObjectContext*)moc_;
- (ShoppingListID*)objectID;





@property (nonatomic, strong) SaleItem* shoppingListToSaleItem;

//- (BOOL)validateShoppingListToSaleItem:(id*)value_ error:(NSError**)error_;




@end

@interface _ShoppingList (CoreDataGeneratedAccessors)

@end

@interface _ShoppingList (CoreDataGeneratedPrimitiveAccessors)



- (SaleItem*)primitiveShoppingListToSaleItem;
- (void)setPrimitiveShoppingListToSaleItem:(SaleItem*)value;


@end
