// DO NOT EDIT. This file is machine-generated and constantly overwritten.
// Make changes to ItemBaseEntity.h instead.

#import <CoreData/CoreData.h>


extern const struct ItemBaseEntityAttributes {
	__unsafe_unretained NSString *createdDate;
	__unsafe_unretained NSString *isFavorite;
} ItemBaseEntityAttributes;

extern const struct ItemBaseEntityRelationships {
} ItemBaseEntityRelationships;

extern const struct ItemBaseEntityFetchedProperties {
} ItemBaseEntityFetchedProperties;





@interface ItemBaseEntityID : NSManagedObjectID {}
@end

@interface _ItemBaseEntity : NSManagedObject {}
+ (id)insertInManagedObjectContext:(NSManagedObjectContext*)moc_;
+ (NSString*)entityName;
+ (NSEntityDescription*)entityInManagedObjectContext:(NSManagedObjectContext*)moc_;
- (ItemBaseEntityID*)objectID;




@property (nonatomic, strong) NSDate *createdDate;


//- (BOOL)validateCreatedDate:(id*)value_ error:(NSError**)error_;




@property (nonatomic, strong) NSNumber *isFavorite;


@property BOOL isFavoriteValue;
- (BOOL)isFavoriteValue;
- (void)setIsFavoriteValue:(BOOL)value_;

//- (BOOL)validateIsFavorite:(id*)value_ error:(NSError**)error_;





@end

@interface _ItemBaseEntity (CoreDataGeneratedAccessors)

@end

@interface _ItemBaseEntity (CoreDataGeneratedPrimitiveAccessors)


- (NSDate*)primitiveCreatedDate;
- (void)setPrimitiveCreatedDate:(NSDate*)value;




- (NSNumber*)primitiveIsFavorite;
- (void)setPrimitiveIsFavorite:(NSNumber*)value;

- (BOOL)primitiveIsFavoriteValue;
- (void)setPrimitiveIsFavoriteValue:(BOOL)value_;




@end
