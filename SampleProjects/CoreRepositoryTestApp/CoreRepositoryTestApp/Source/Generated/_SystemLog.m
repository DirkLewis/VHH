// DO NOT EDIT. This file is machine-generated and constantly overwritten.
// Make changes to SystemLog.m instead.

#import "_SystemLog.h"

const struct SystemLogAttributes SystemLogAttributes = {
	.logEntry = @"logEntry",
};

const struct SystemLogRelationships SystemLogRelationships = {
};

const struct SystemLogFetchedProperties SystemLogFetchedProperties = {
};

@implementation SystemLogID
@end

@implementation _SystemLog

+ (id)insertInManagedObjectContext:(NSManagedObjectContext*)moc_ {
	NSParameterAssert(moc_);
	return [NSEntityDescription insertNewObjectForEntityForName:@"SystemLog" inManagedObjectContext:moc_];
}

+ (NSString*)entityName {
	return @"SystemLog";
}

+ (NSEntityDescription*)entityInManagedObjectContext:(NSManagedObjectContext*)moc_ {
	NSParameterAssert(moc_);
	return [NSEntityDescription entityForName:@"SystemLog" inManagedObjectContext:moc_];
}

- (SystemLogID*)objectID {
	return (SystemLogID*)[super objectID];
}

+ (NSSet *)keyPathsForValuesAffectingValueForKey:(NSString *)key {
	NSSet *keyPaths = [super keyPathsForValuesAffectingValueForKey:key];
	

	return keyPaths;
}




@dynamic logEntry;











@end
