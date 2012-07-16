// DO NOT EDIT. This file is machine-generated and constantly overwritten.
// Make changes to Location.h instead.

#import <CoreData/CoreData.h>


extern const struct LocationAttributes {
	__unsafe_unretained NSString *cityName;
	__unsafe_unretained NSString *communityID;
	__unsafe_unretained NSString *communityName;
	__unsafe_unretained NSString *country;
	__unsafe_unretained NSString *countyID;
	__unsafe_unretained NSString *countyName;
	__unsafe_unretained NSString *favoriteLocation;
	__unsafe_unretained NSString *stateID;
	__unsafe_unretained NSString *stateName;
	__unsafe_unretained NSString *zipCode;
} LocationAttributes;

extern const struct LocationRelationships {
	__unsafe_unretained NSString *locationToStore;
} LocationRelationships;

extern const struct LocationFetchedProperties {
} LocationFetchedProperties;

@class GroceryStore;












@interface LocationID : NSManagedObjectID {}
@end

@interface _Location : NSManagedObject {}
+ (id)insertInManagedObjectContext:(NSManagedObjectContext*)moc_;
+ (NSString*)entityName;
+ (NSEntityDescription*)entityInManagedObjectContext:(NSManagedObjectContext*)moc_;
- (LocationID*)objectID;




@property (nonatomic, strong) NSString *cityName;


//- (BOOL)validateCityName:(id*)value_ error:(NSError**)error_;




@property (nonatomic, strong) NSString *communityID;


//- (BOOL)validateCommunityID:(id*)value_ error:(NSError**)error_;




@property (nonatomic, strong) NSString *communityName;


//- (BOOL)validateCommunityName:(id*)value_ error:(NSError**)error_;




@property (nonatomic, strong) NSString *country;


//- (BOOL)validateCountry:(id*)value_ error:(NSError**)error_;




@property (nonatomic, strong) NSString *countyID;


//- (BOOL)validateCountyID:(id*)value_ error:(NSError**)error_;




@property (nonatomic, strong) NSString *countyName;


//- (BOOL)validateCountyName:(id*)value_ error:(NSError**)error_;




@property (nonatomic, strong) NSNumber *favoriteLocation;


@property BOOL favoriteLocationValue;
- (BOOL)favoriteLocationValue;
- (void)setFavoriteLocationValue:(BOOL)value_;

//- (BOOL)validateFavoriteLocation:(id*)value_ error:(NSError**)error_;




@property (nonatomic, strong) NSString *stateID;


//- (BOOL)validateStateID:(id*)value_ error:(NSError**)error_;




@property (nonatomic, strong) NSString *stateName;


//- (BOOL)validateStateName:(id*)value_ error:(NSError**)error_;




@property (nonatomic, strong) NSString *zipCode;


//- (BOOL)validateZipCode:(id*)value_ error:(NSError**)error_;





@property (nonatomic, strong) NSSet* locationToStore;

- (NSMutableSet*)locationToStoreSet;




@end

@interface _Location (CoreDataGeneratedAccessors)

- (void)addLocationToStore:(NSSet*)value_;
- (void)removeLocationToStore:(NSSet*)value_;
- (void)addLocationToStoreObject:(GroceryStore*)value_;
- (void)removeLocationToStoreObject:(GroceryStore*)value_;

@end

@interface _Location (CoreDataGeneratedPrimitiveAccessors)


- (NSString*)primitiveCityName;
- (void)setPrimitiveCityName:(NSString*)value;




- (NSString*)primitiveCommunityID;
- (void)setPrimitiveCommunityID:(NSString*)value;




- (NSString*)primitiveCommunityName;
- (void)setPrimitiveCommunityName:(NSString*)value;




- (NSString*)primitiveCountry;
- (void)setPrimitiveCountry:(NSString*)value;




- (NSString*)primitiveCountyID;
- (void)setPrimitiveCountyID:(NSString*)value;




- (NSString*)primitiveCountyName;
- (void)setPrimitiveCountyName:(NSString*)value;




- (NSNumber*)primitiveFavoriteLocation;
- (void)setPrimitiveFavoriteLocation:(NSNumber*)value;

- (BOOL)primitiveFavoriteLocationValue;
- (void)setPrimitiveFavoriteLocationValue:(BOOL)value_;




- (NSString*)primitiveStateID;
- (void)setPrimitiveStateID:(NSString*)value;




- (NSString*)primitiveStateName;
- (void)setPrimitiveStateName:(NSString*)value;




- (NSString*)primitiveZipCode;
- (void)setPrimitiveZipCode:(NSString*)value;





- (NSMutableSet*)primitiveLocationToStore;
- (void)setPrimitiveLocationToStore:(NSMutableSet*)value;


@end
