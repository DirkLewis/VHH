// DO NOT EDIT. This file is machine-generated and constantly overwritten.
// Make changes to GroceryStore.h instead.

#import <CoreData/CoreData.h>


extern const struct GroceryStoreAttributes {
	__unsafe_unretained NSString *favoriteStore;
	__unsafe_unretained NSString *groceryStoreName;
	__unsafe_unretained NSString *lastUpdated;
	__unsafe_unretained NSString *numberOfSaleItems;
} GroceryStoreAttributes;

extern const struct GroceryStoreRelationships {
	__unsafe_unretained NSString *storeToLocation;
	__unsafe_unretained NSString *storeToSaleItem;
} GroceryStoreRelationships;

extern const struct GroceryStoreFetchedProperties {
} GroceryStoreFetchedProperties;

@class Location;
@class SaleItem;






@interface GroceryStoreID : NSManagedObjectID {}
@end

@interface _GroceryStore : NSManagedObject {}
+ (id)insertInManagedObjectContext:(NSManagedObjectContext*)moc_;
+ (NSString*)entityName;
+ (NSEntityDescription*)entityInManagedObjectContext:(NSManagedObjectContext*)moc_;
- (GroceryStoreID*)objectID;




@property (nonatomic, strong) NSNumber *favoriteStore;


@property BOOL favoriteStoreValue;
- (BOOL)favoriteStoreValue;
- (void)setFavoriteStoreValue:(BOOL)value_;

//- (BOOL)validateFavoriteStore:(id*)value_ error:(NSError**)error_;




@property (nonatomic, strong) NSString *groceryStoreName;


//- (BOOL)validateGroceryStoreName:(id*)value_ error:(NSError**)error_;




@property (nonatomic, strong) NSDate *lastUpdated;


//- (BOOL)validateLastUpdated:(id*)value_ error:(NSError**)error_;




@property (nonatomic, strong) NSNumber *numberOfSaleItems;


@property short numberOfSaleItemsValue;
- (short)numberOfSaleItemsValue;
- (void)setNumberOfSaleItemsValue:(short)value_;

//- (BOOL)validateNumberOfSaleItems:(id*)value_ error:(NSError**)error_;





@property (nonatomic, strong) Location* storeToLocation;

//- (BOOL)validateStoreToLocation:(id*)value_ error:(NSError**)error_;




@property (nonatomic, strong) NSSet* storeToSaleItem;

- (NSMutableSet*)storeToSaleItemSet;




@end

@interface _GroceryStore (CoreDataGeneratedAccessors)

- (void)addStoreToSaleItem:(NSSet*)value_;
- (void)removeStoreToSaleItem:(NSSet*)value_;
- (void)addStoreToSaleItemObject:(SaleItem*)value_;
- (void)removeStoreToSaleItemObject:(SaleItem*)value_;

@end

@interface _GroceryStore (CoreDataGeneratedPrimitiveAccessors)


- (NSNumber*)primitiveFavoriteStore;
- (void)setPrimitiveFavoriteStore:(NSNumber*)value;

- (BOOL)primitiveFavoriteStoreValue;
- (void)setPrimitiveFavoriteStoreValue:(BOOL)value_;




- (NSString*)primitiveGroceryStoreName;
- (void)setPrimitiveGroceryStoreName:(NSString*)value;




- (NSDate*)primitiveLastUpdated;
- (void)setPrimitiveLastUpdated:(NSDate*)value;




- (NSNumber*)primitiveNumberOfSaleItems;
- (void)setPrimitiveNumberOfSaleItems:(NSNumber*)value;

- (short)primitiveNumberOfSaleItemsValue;
- (void)setPrimitiveNumberOfSaleItemsValue:(short)value_;





- (Location*)primitiveStoreToLocation;
- (void)setPrimitiveStoreToLocation:(Location*)value;



- (NSMutableSet*)primitiveStoreToSaleItem;
- (void)setPrimitiveStoreToSaleItem:(NSMutableSet*)value;


@end
