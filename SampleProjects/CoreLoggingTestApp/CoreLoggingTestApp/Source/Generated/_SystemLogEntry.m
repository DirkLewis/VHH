// DO NOT EDIT. This file is machine-generated and constantly overwritten.
// Make changes to SystemLogEntry.m instead.

#import "_SystemLogEntry.h"

const struct SystemLogEntryAttributes SystemLogEntryAttributes = {
	.context = @"context",
	.level = @"level",
	.message = @"message",
	.timestamp = @"timestamp",
};

const struct SystemLogEntryRelationships SystemLogEntryRelationships = {
};

const struct SystemLogEntryFetchedProperties SystemLogEntryFetchedProperties = {
};

@implementation SystemLogEntryID
@end

@implementation _SystemLogEntry

+ (id)insertInManagedObjectContext:(NSManagedObjectContext*)moc_ {
	NSParameterAssert(moc_);
	return [NSEntityDescription insertNewObjectForEntityForName:@"SystemLogEntry" inManagedObjectContext:moc_];
}

+ (NSString*)entityName {
	return @"SystemLogEntry";
}

+ (NSEntityDescription*)entityInManagedObjectContext:(NSManagedObjectContext*)moc_ {
	NSParameterAssert(moc_);
	return [NSEntityDescription entityForName:@"SystemLogEntry" inManagedObjectContext:moc_];
}

- (SystemLogEntryID*)objectID {
	return (SystemLogEntryID*)[super objectID];
}

+ (NSSet *)keyPathsForValuesAffectingValueForKey:(NSString *)key {
	NSSet *keyPaths = [super keyPathsForValuesAffectingValueForKey:key];
	
	if ([key isEqualToString:@"contextValue"]) {
		NSSet *affectingKey = [NSSet setWithObject:@"context"];
		keyPaths = [keyPaths setByAddingObjectsFromSet:affectingKey];
	}
	if ([key isEqualToString:@"levelValue"]) {
		NSSet *affectingKey = [NSSet setWithObject:@"level"];
		keyPaths = [keyPaths setByAddingObjectsFromSet:affectingKey];
	}

	return keyPaths;
}




@dynamic context;



- (int)contextValue {
	NSNumber *result = [self context];
	return [result intValue];
}

- (void)setContextValue:(int)value_ {
	[self setContext:[NSNumber numberWithInt:value_]];
}

- (int)primitiveContextValue {
	NSNumber *result = [self primitiveContext];
	return [result intValue];
}

- (void)setPrimitiveContextValue:(int)value_ {
	[self setPrimitiveContext:[NSNumber numberWithInt:value_]];
}





@dynamic level;



- (int)levelValue {
	NSNumber *result = [self level];
	return [result intValue];
}

- (void)setLevelValue:(int)value_ {
	[self setLevel:[NSNumber numberWithInt:value_]];
}

- (int)primitiveLevelValue {
	NSNumber *result = [self primitiveLevel];
	return [result intValue];
}

- (void)setPrimitiveLevelValue:(int)value_ {
	[self setPrimitiveLevel:[NSNumber numberWithInt:value_]];
}





@dynamic message;






@dynamic timestamp;










@end
