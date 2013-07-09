// DO NOT EDIT. This file is machine-generated and constantly overwritten.
// Make changes to Person.h instead.

#import <CoreData/CoreData.h>


extern const struct PersonAttributes {
	__unsafe_unretained NSString *firstName;
	__unsafe_unretained NSString *lastName;
} PersonAttributes;

extern const struct PersonRelationships {
	__unsafe_unretained NSString *personToAddress;
} PersonRelationships;

extern const struct PersonFetchedProperties {
} PersonFetchedProperties;

@class Address;




@interface PersonID : NSManagedObjectID {}
@end

@interface _Person : NSManagedObject {}
+ (id)insertInManagedObjectContext:(NSManagedObjectContext*)moc_;
+ (NSString*)entityName;
+ (NSEntityDescription*)entityInManagedObjectContext:(NSManagedObjectContext*)moc_;
- (PersonID*)objectID;




@property (nonatomic, strong) NSString* firstName;


//- (BOOL)validateFirstName:(id*)value_ error:(NSError**)error_;




@property (nonatomic, strong) NSString* lastName;


//- (BOOL)validateLastName:(id*)value_ error:(NSError**)error_;





@property (nonatomic, strong) NSSet* personToAddress;

- (NSMutableSet*)personToAddressSet;





@end

@interface _Person (CoreDataGeneratedAccessors)

- (void)addPersonToAddress:(NSSet*)value_;
- (void)removePersonToAddress:(NSSet*)value_;
- (void)addPersonToAddressObject:(Address*)value_;
- (void)removePersonToAddressObject:(Address*)value_;

@end

@interface _Person (CoreDataGeneratedPrimitiveAccessors)


- (NSString*)primitiveFirstName;
- (void)setPrimitiveFirstName:(NSString*)value;




- (NSString*)primitiveLastName;
- (void)setPrimitiveLastName:(NSString*)value;





- (NSMutableSet*)primitivePersonToAddress;
- (void)setPrimitivePersonToAddress:(NSMutableSet*)value;


@end
