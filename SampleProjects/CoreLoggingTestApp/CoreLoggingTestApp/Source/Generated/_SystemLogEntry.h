// DO NOT EDIT. This file is machine-generated and constantly overwritten.
// Make changes to SystemLogEntry.h instead.

#import <CoreData/CoreData.h>


extern const struct SystemLogEntryAttributes {
	__unsafe_unretained NSString *context;
	__unsafe_unretained NSString *level;
	__unsafe_unretained NSString *message;
	__unsafe_unretained NSString *timestamp;
} SystemLogEntryAttributes;

extern const struct SystemLogEntryRelationships {
} SystemLogEntryRelationships;

extern const struct SystemLogEntryFetchedProperties {
} SystemLogEntryFetchedProperties;







@interface SystemLogEntryID : NSManagedObjectID {}
@end

@interface _SystemLogEntry : NSManagedObject {}
+ (id)insertInManagedObjectContext:(NSManagedObjectContext*)moc_;
+ (NSString*)entityName;
+ (NSEntityDescription*)entityInManagedObjectContext:(NSManagedObjectContext*)moc_;
- (SystemLogEntryID*)objectID;




@property (nonatomic, strong) NSNumber *context;


@property int contextValue;
- (int)contextValue;
- (void)setContextValue:(int)value_;

//- (BOOL)validateContext:(id*)value_ error:(NSError**)error_;




@property (nonatomic, strong) NSNumber *level;


@property int levelValue;
- (int)levelValue;
- (void)setLevelValue:(int)value_;

//- (BOOL)validateLevel:(id*)value_ error:(NSError**)error_;




@property (nonatomic, strong) NSString *message;


//- (BOOL)validateMessage:(id*)value_ error:(NSError**)error_;




@property (nonatomic, strong) NSDate *timestamp;


//- (BOOL)validateTimestamp:(id*)value_ error:(NSError**)error_;





@end

@interface _SystemLogEntry (CoreDataGeneratedAccessors)

@end

@interface _SystemLogEntry (CoreDataGeneratedPrimitiveAccessors)


- (NSNumber*)primitiveContext;
- (void)setPrimitiveContext:(NSNumber*)value;

- (int)primitiveContextValue;
- (void)setPrimitiveContextValue:(int)value_;




- (NSNumber*)primitiveLevel;
- (void)setPrimitiveLevel:(NSNumber*)value;

- (int)primitiveLevelValue;
- (void)setPrimitiveLevelValue:(int)value_;




- (NSString*)primitiveMessage;
- (void)setPrimitiveMessage:(NSString*)value;




- (NSDate*)primitiveTimestamp;
- (void)setPrimitiveTimestamp:(NSDate*)value;




@end
