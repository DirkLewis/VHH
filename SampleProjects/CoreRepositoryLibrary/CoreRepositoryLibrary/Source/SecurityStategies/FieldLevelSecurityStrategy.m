//
//  FieldLevelSecurity.m
//  CoreDataRepositoryFramework
//
//  Created by Dirk Lewis on 7/18/12.
//  Copyright (c) 2012 Optima HCS. All rights reserved.
//

#import "FieldLevelSecurityStrategy.h"
#import "Repository.h"
#import "BackingstoreProtocol.h"
@interface FieldLevelSecurityStrategy ()
@end

@implementation FieldLevelSecurityStrategy

@synthesize passwordTracker = _passwordTracker;
- (id)init
{
    self = [super init];
    if (self) {
    }
    return self;
}

- (BOOL)isRepositorySecured:(Repository*)repository{
    
    return YES;
}

- (RepositorySecurityType)repositorySecurityType{
    
    return RepositorySecurityTypeAutomatic;
    
}

- (NSDictionary*)findTransformableAttributesInEntitiesInRepository:(Repository*)repository{
    
    NSMutableArray *transformables = [NSMutableArray array];
    NSArray *repositoryEntities = [[[repository.backingstore managedObjectModel] entities]valueForKey:@"name"];
    
    for (NSString *entityName in repositoryEntities) {
        NSEntityDescription *entityDescription = [NSEntityDescription entityForName:entityName inManagedObjectContext:[repository.backingstore managedObjectContext]];
        NSMutableArray *attributes = [NSMutableArray array];
        for (NSAttributeDescription *att in entityDescription) {
            if ([att isKindOfClass:[NSAttributeDescription class]]) {
                if ([att attributeType] == NSTransformableAttributeType) {
                    [attributes addObject:[att valueForKey:@"name"]];
                }
            }
        }
        
        if ([attributes count] > 0) {
            [transformables addObject:[NSDictionary dictionaryWithObjectsAndKeys:entityName,@"entity",attributes,@"attributes", nil]];
        }
    }
    
    return (NSDictionary*)transformables;
}

- (RepositoryOperationStatus)applySecurityToRepository:(Repository*)repository{
    
    for (NSDictionary *entityDict in [self findTransformableAttributesInEntitiesInRepository:repository]) {
        
        NSString *currentEntity = [entityDict valueForKey:@"entity"];
        NSArray *attributes = [entityDict valueForKey:@"attributes"];
        NSArray *data = [repository resultsForRequest:[repository fetchRequestForEntityNamed:currentEntity batchSize:25]];
        
        for (NSManagedObject *managedObject in data) {
            for (NSString *attribute in attributes) {
                NSObject *oldValue = [managedObject valueForKey:attribute];
                if (oldValue) {
                    [self.passwordTracker setPassword:self.passwordTracker.passwordNew];
                    [managedObject setValue:nil forKey:attribute];
                    [repository save];
                    [managedObject setValue:oldValue forKey:attribute];
                    [repository save];
                    [self.passwordTracker setPassword:self.passwordTracker.passwordOld];
                }
            }
        }
    }
    
    return RepositoryOperationStatusSuccess;
}

- (RepositoryOperationStatus)reEncryptRepository:(Repository*)repository passwordTracker:(id<PasswordProtocol>)passwordTracker{
    
    [self setPasswordTracker:passwordTracker];
    RepositoryOperationStatus status = [self applySecurityToRepository:repository];
    if (status != RepositoryOperationStatusSuccess) {
        //TODO: What do do when done
        self.passwordTracker.password = self.passwordTracker.passwordNew;
    }
    else {
    }
    
    [repository save];
    return status;
}

@end
