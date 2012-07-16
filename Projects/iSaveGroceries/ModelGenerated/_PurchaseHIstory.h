// DO NOT EDIT. This file is machine-generated and constantly overwritten.
// Make changes to PurchaseHIstory.h instead.

#import <CoreData/CoreData.h>
#import "ItemBaseEntity.h"

extern const struct PurchaseHIstoryAttributes {
	__unsafe_unretained NSString *quantitiy;
	__unsafe_unretained NSString *salePrice;
} PurchaseHIstoryAttributes;

extern const struct PurchaseHIstoryRelationships {
	__unsafe_unretained NSString *saleHistoryToSaleItem;
} PurchaseHIstoryRelationships;

extern const struct PurchaseHIstoryFetchedProperties {
} PurchaseHIstoryFetchedProperties;

@class SaleItem;




@interface PurchaseHIstoryID : NSManagedObjectID {}
@end

@interface _PurchaseHIstory : ItemBaseEntity {}
+ (id)insertInManagedObjectContext:(NSManagedObjectContext*)moc_;
+ (NSString*)entityName;
+ (NSEntityDescription*)entityInManagedObjectContext:(NSManagedObjectContext*)moc_;
- (PurchaseHIstoryID*)objectID;




@property (nonatomic, strong) NSNumber *quantitiy;


@property short quantitiyValue;
- (short)quantitiyValue;
- (void)setQuantitiyValue:(short)value_;

//- (BOOL)validateQuantitiy:(id*)value_ error:(NSError**)error_;




@property (nonatomic, strong) NSString *salePrice;


//- (BOOL)validateSalePrice:(id*)value_ error:(NSError**)error_;





@property (nonatomic, strong) SaleItem* saleHistoryToSaleItem;

//- (BOOL)validateSaleHistoryToSaleItem:(id*)value_ error:(NSError**)error_;




@end

@interface _PurchaseHIstory (CoreDataGeneratedAccessors)

@end

@interface _PurchaseHIstory (CoreDataGeneratedPrimitiveAccessors)


- (NSNumber*)primitiveQuantitiy;
- (void)setPrimitiveQuantitiy:(NSNumber*)value;

- (short)primitiveQuantitiyValue;
- (void)setPrimitiveQuantitiyValue:(short)value_;




- (NSString*)primitiveSalePrice;
- (void)setPrimitiveSalePrice:(NSString*)value;





- (SaleItem*)primitiveSaleHistoryToSaleItem;
- (void)setPrimitiveSaleHistoryToSaleItem:(SaleItem*)value;


@end
