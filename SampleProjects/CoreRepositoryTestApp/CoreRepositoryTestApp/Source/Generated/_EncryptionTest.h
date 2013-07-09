// DO NOT EDIT. This file is machine-generated and constantly overwritten.
// Make changes to EncryptionTest.h instead.

#import <CoreData/CoreData.h>


extern const struct EncryptionTestAttributes {
	__unsafe_unretained NSString *testValue;
} EncryptionTestAttributes;

extern const struct EncryptionTestRelationships {
} EncryptionTestRelationships;

extern const struct EncryptionTestFetchedProperties {
} EncryptionTestFetchedProperties;


@class NSObject;

@interface EncryptionTestID : NSManagedObjectID {}
@end

@interface _EncryptionTest : NSManagedObject {}
+ (id)insertInManagedObjectContext:(NSManagedObjectContext*)moc_;
+ (NSString*)entityName;
+ (NSEntityDescription*)entityInManagedObjectContext:(NSManagedObjectContext*)moc_;
- (EncryptionTestID*)objectID;




@property (nonatomic, strong) id testValue;


//- (BOOL)validateTestValue:(id*)value_ error:(NSError**)error_;






@end

@interface _EncryptionTest (CoreDataGeneratedAccessors)

@end

@interface _EncryptionTest (CoreDataGeneratedPrimitiveAccessors)


- (id)primitiveTestValue;
- (void)setPrimitiveTestValue:(id)value;




@end
