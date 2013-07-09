// DO NOT EDIT. This file is machine-generated and constantly overwritten.
// Make changes to SystemLog.h instead.

#import <CoreData/CoreData.h>


extern const struct SystemLogAttributes {
	__unsafe_unretained NSString *logEntry;
} SystemLogAttributes;

extern const struct SystemLogRelationships {
} SystemLogRelationships;

extern const struct SystemLogFetchedProperties {
} SystemLogFetchedProperties;




@interface SystemLogID : NSManagedObjectID {}
@end

@interface _SystemLog : NSManagedObject {}
+ (id)insertInManagedObjectContext:(NSManagedObjectContext*)moc_;
+ (NSString*)entityName;
+ (NSEntityDescription*)entityInManagedObjectContext:(NSManagedObjectContext*)moc_;
- (SystemLogID*)objectID;




@property (nonatomic, strong) NSString* logEntry;


//- (BOOL)validateLogEntry:(id*)value_ error:(NSError**)error_;






@end

@interface _SystemLog (CoreDataGeneratedAccessors)

@end

@interface _SystemLog (CoreDataGeneratedPrimitiveAccessors)


- (NSString*)primitiveLogEntry;
- (void)setPrimitiveLogEntry:(NSString*)value;




@end
