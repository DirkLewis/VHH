// DO NOT EDIT. This file is machine-generated and constantly overwritten.
// Make changes to Person.h instead.

#import <CoreData/CoreData.h>


extern const struct PersonAttributes {
	__unsafe_unretained NSString *address;
	__unsafe_unretained NSString *age;
	__unsafe_unretained NSString *firstName;
	__unsafe_unretained NSString *lastName;
	__unsafe_unretained NSString *moreSecrets;
	__unsafe_unretained NSString *secrets;
} PersonAttributes;

extern const struct PersonRelationships {
	__unsafe_unretained NSString *personToToy;
} PersonRelationships;

extern const struct PersonFetchedProperties {
} PersonFetchedProperties;

@class Toy;





@class NSObject;
@class NSObject;

@interface PersonID : NSManagedObjectID {}
@end

@interface _Person : NSManagedObject {}
+ (id)insertInManagedObjectContext:(NSManagedObjectContext*)moc_;
+ (NSString*)entityName;
+ (NSEntityDescription*)entityInManagedObjectContext:(NSManagedObjectContext*)moc_;
- (PersonID*)objectID;




@property (nonatomic, strong) NSString* address;


//- (BOOL)validateAddress:(id*)value_ error:(NSError**)error_;




@property (nonatomic, strong) NSNumber* age;


@property int16_t ageValue;
- (int16_t)ageValue;
- (void)setAgeValue:(int16_t)value_;

//- (BOOL)validateAge:(id*)value_ error:(NSError**)error_;




@property (nonatomic, strong) NSString* firstName;


//- (BOOL)validateFirstName:(id*)value_ error:(NSError**)error_;




@property (nonatomic, strong) NSString* lastName;


//- (BOOL)validateLastName:(id*)value_ error:(NSError**)error_;




@property (nonatomic, strong) id moreSecrets;


//- (BOOL)validateMoreSecrets:(id*)value_ error:(NSError**)error_;




@property (nonatomic, strong) id secrets;


//- (BOOL)validateSecrets:(id*)value_ error:(NSError**)error_;





@property (nonatomic, strong) NSSet* personToToy;

- (NSMutableSet*)personToToySet;





@end

@interface _Person (CoreDataGeneratedAccessors)

- (void)addPersonToToy:(NSSet*)value_;
- (void)removePersonToToy:(NSSet*)value_;
- (void)addPersonToToyObject:(Toy*)value_;
- (void)removePersonToToyObject:(Toy*)value_;

@end

@interface _Person (CoreDataGeneratedPrimitiveAccessors)


- (NSString*)primitiveAddress;
- (void)setPrimitiveAddress:(NSString*)value;




- (NSNumber*)primitiveAge;
- (void)setPrimitiveAge:(NSNumber*)value;

- (int16_t)primitiveAgeValue;
- (void)setPrimitiveAgeValue:(int16_t)value_;




- (NSString*)primitiveFirstName;
- (void)setPrimitiveFirstName:(NSString*)value;




- (NSString*)primitiveLastName;
- (void)setPrimitiveLastName:(NSString*)value;




- (id)primitiveMoreSecrets;
- (void)setPrimitiveMoreSecrets:(id)value;




- (id)primitiveSecrets;
- (void)setPrimitiveSecrets:(id)value;





- (NSMutableSet*)primitivePersonToToy;
- (void)setPrimitivePersonToToy:(NSMutableSet*)value;


@end
