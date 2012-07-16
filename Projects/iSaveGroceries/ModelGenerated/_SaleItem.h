// DO NOT EDIT. This file is machine-generated and constantly overwritten.
// Make changes to SaleItem.h instead.

#import <CoreData/CoreData.h>
#import "ItemBaseEntity.h"

extern const struct SaleItemAttributes {
	__unsafe_unretained NSString *category;
	__unsafe_unretained NSString *comment;
	__unsafe_unretained NSString *imageName;
	__unsafe_unretained NSString *itemDescription;
	__unsafe_unretained NSString *regularPrice;
	__unsafe_unretained NSString *saleEndDate;
	__unsafe_unretained NSString *salePrice;
	__unsafe_unretained NSString *weight;
} SaleItemAttributes;

extern const struct SaleItemRelationships {
	__unsafe_unretained NSString *saleItemToSaleHistory;
	__unsafe_unretained NSString *saleItemToShoppingList;
	__unsafe_unretained NSString *saleItemToStore;
} SaleItemRelationships;

extern const struct SaleItemFetchedProperties {
} SaleItemFetchedProperties;

@class PurchaseHIstory;
@class ShoppingList;
@class GroceryStore;










@interface SaleItemID : NSManagedObjectID {}
@end

@interface _SaleItem : ItemBaseEntity {}
+ (id)insertInManagedObjectContext:(NSManagedObjectContext*)moc_;
+ (NSString*)entityName;
+ (NSEntityDescription*)entityInManagedObjectContext:(NSManagedObjectContext*)moc_;
- (SaleItemID*)objectID;




@property (nonatomic, strong) NSString *category;


//- (BOOL)validateCategory:(id*)value_ error:(NSError**)error_;




@property (nonatomic, strong) NSString *comment;


//- (BOOL)validateComment:(id*)value_ error:(NSError**)error_;




@property (nonatomic, strong) NSString *imageName;


//- (BOOL)validateImageName:(id*)value_ error:(NSError**)error_;




@property (nonatomic, strong) NSString *itemDescription;


//- (BOOL)validateItemDescription:(id*)value_ error:(NSError**)error_;




@property (nonatomic, strong) NSString *regularPrice;


//- (BOOL)validateRegularPrice:(id*)value_ error:(NSError**)error_;




@property (nonatomic, strong) NSDate *saleEndDate;


//- (BOOL)validateSaleEndDate:(id*)value_ error:(NSError**)error_;




@property (nonatomic, strong) NSString *salePrice;


//- (BOOL)validateSalePrice:(id*)value_ error:(NSError**)error_;




@property (nonatomic, strong) NSString *weight;


//- (BOOL)validateWeight:(id*)value_ error:(NSError**)error_;





@property (nonatomic, strong) NSSet* saleItemToSaleHistory;

- (NSMutableSet*)saleItemToSaleHistorySet;




@property (nonatomic, strong) NSSet* saleItemToShoppingList;

- (NSMutableSet*)saleItemToShoppingListSet;




@property (nonatomic, strong) GroceryStore* saleItemToStore;

//- (BOOL)validateSaleItemToStore:(id*)value_ error:(NSError**)error_;




@end

@interface _SaleItem (CoreDataGeneratedAccessors)

- (void)addSaleItemToSaleHistory:(NSSet*)value_;
- (void)removeSaleItemToSaleHistory:(NSSet*)value_;
- (void)addSaleItemToSaleHistoryObject:(PurchaseHIstory*)value_;
- (void)removeSaleItemToSaleHistoryObject:(PurchaseHIstory*)value_;

- (void)addSaleItemToShoppingList:(NSSet*)value_;
- (void)removeSaleItemToShoppingList:(NSSet*)value_;
- (void)addSaleItemToShoppingListObject:(ShoppingList*)value_;
- (void)removeSaleItemToShoppingListObject:(ShoppingList*)value_;

@end

@interface _SaleItem (CoreDataGeneratedPrimitiveAccessors)


- (NSString*)primitiveCategory;
- (void)setPrimitiveCategory:(NSString*)value;




- (NSString*)primitiveComment;
- (void)setPrimitiveComment:(NSString*)value;




- (NSString*)primitiveImageName;
- (void)setPrimitiveImageName:(NSString*)value;




- (NSString*)primitiveItemDescription;
- (void)setPrimitiveItemDescription:(NSString*)value;




- (NSString*)primitiveRegularPrice;
- (void)setPrimitiveRegularPrice:(NSString*)value;




- (NSDate*)primitiveSaleEndDate;
- (void)setPrimitiveSaleEndDate:(NSDate*)value;




- (NSString*)primitiveSalePrice;
- (void)setPrimitiveSalePrice:(NSString*)value;




- (NSString*)primitiveWeight;
- (void)setPrimitiveWeight:(NSString*)value;





- (NSMutableSet*)primitiveSaleItemToSaleHistory;
- (void)setPrimitiveSaleItemToSaleHistory:(NSMutableSet*)value;



- (NSMutableSet*)primitiveSaleItemToShoppingList;
- (void)setPrimitiveSaleItemToShoppingList:(NSMutableSet*)value;



- (GroceryStore*)primitiveSaleItemToStore;
- (void)setPrimitiveSaleItemToStore:(GroceryStore*)value;


@end
