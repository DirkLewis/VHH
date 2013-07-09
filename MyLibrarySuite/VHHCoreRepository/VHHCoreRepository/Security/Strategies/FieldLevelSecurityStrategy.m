//
//  FieldLevelSecurityStrategy.m
//  VHHCoreRepository
//
//  Created by Dirk Lewis on 7/2/13.
//  Copyright (c) 2013 VideoHooHaa. All rights reserved.
//

#import "FieldLevelSecurityStrategy.h"
#import "Repository.h"

@interface FieldLevelSecurityStrategy()

@end

@implementation FieldLevelSecurityStrategy{
}

+ (instancetype)securityStrategyInstance{
    
    return [[self alloc]init];
}

- (BOOL)isRepositorySecured:(id<RepositoryProtocol>)repository{
    
    return YES;
}

- (RepositorySecurityType)repositorySecurityType{
    
    return RepositorySecurityTypeAutomatic;
    
}

- (NSDictionary*)findTransformableAttributesInEntitiesInRepository:(id<RepositoryProtocol>)repository{
    
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

- (RepositoryOperationStatus)applySecurityToRepository:(id<RepositoryProtocol>)repository{
    
    for (NSDictionary *entityDict in [self findTransformableAttributesInEntitiesInRepository:repository]) {
        
        NSString *currentEntity = entityDict[@"entity"];
        NSArray *attributes = entityDict[@"attributes"];
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

- (RepositoryOperationStatus)reEncryptRepository:(id<RepositoryProtocol>)repository passwordTracker:(id<PasswordProtocol>)passwordTracker{
    
    [self setPasswordTracker:passwordTracker];
    RepositoryOperationStatus status = [self applySecurityToRepository:repository];
    if (status == RepositoryOperationStatusSuccess) {
        self.passwordTracker.password = self.passwordTracker.passwordNew;
    }
    else {
        self.passwordTracker.password = self.passwordTracker.passwordOld;

    }
    
    [repository save];
    return status;
}
@end
