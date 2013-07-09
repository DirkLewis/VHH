// DO NOT EDIT. This file is machine-generated and constantly overwritten.
// Make changes to Toy.h instead.

#import <CoreData/CoreData.h>


extern const struct ToyAttributes {
	__unsafe_unretained NSString *toyImage;
	__unsafe_unretained NSString *toyName;
	__unsafe_unretained NSString *toyValue;
} ToyAttributes;

extern const struct ToyRelationships {
	__unsafe_unretained NSString *toyToPerson;
} ToyRelationships;

extern const struct ToyFetchedProperties {
} ToyFetchedProperties;

@class Person;

@class NSObject;



@interface ToyID : NSManagedObjectID {}
@end

@interface _Toy : NSManagedObject {}
+ (id)insertInManagedObjectContext:(NSManagedObjectContext*)moc_;
+ (NSString*)entityName;
+ (NSEntityDescription*)entityInManagedObjectContext:(NSManagedObjectContext*)moc_;
- (ToyID*)objectID;




@property (nonatomic, strong) id toyImage;


//- (BOOL)validateToyImage:(id*)value_ error:(NSError**)error_;




@property (nonatomic, strong) NSString* toyName;


//- (BOOL)validateToyName:(id*)value_ error:(NSError**)error_;




@property (nonatomic, strong) NSDecimalNumber* toyValue;


//- (BOOL)validateToyValue:(id*)value_ error:(NSError**)error_;





@property (nonatomic, strong) Person* toyToPerson;

//- (BOOL)validateToyToPerson:(id*)value_ error:(NSError**)error_;





@end

@interface _Toy (CoreDataGeneratedAccessors)

@end

@interface _Toy (CoreDataGeneratedPrimitiveAccessors)


- (id)primitiveToyImage;
- (void)setPrimitiveToyImage:(id)value;




- (NSString*)primitiveToyName;
- (void)setPrimitiveToyName:(NSString*)value;




- (NSDecimalNumber*)primitiveToyValue;
- (void)setPrimitiveToyValue:(NSDecimalNumber*)value;





- (Person*)primitiveToyToPerson;
- (void)setPrimitiveToyToPerson:(Person*)value;


@end
