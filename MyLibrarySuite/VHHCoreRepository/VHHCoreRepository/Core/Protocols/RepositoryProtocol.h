//
//  RepositoryProtocol.h
//  VHHCoreRepository
//
//  Created by Dirk Lewis on 7/2/13.
//  Copyright (c) 2013 VideoHooHaa. All rights reserved.
//

#import <Foundation/Foundation.h>
@class Repository;

typedef enum{
    
    RepositoryOperationStatusSuccess = 0,
    RepositoryOperationStatusBackupWriteFail = 1,
    RepositoryOperationStatusSecuredWriteFail = 2,
    RepositoryOperationStatusUnsecuredWriteFail = 3,
    RepositoryOperationStatusBackupRemoveFail = 4,
    RepositoryOperationStatusSecuredRemoveFail = 5,
    RepositoryOperationStatusUnsecuredRemoveFail = 6,
    RepositoryOperationStatusPasswordIncorrect  = 7,
    RepositoryOperationStatusSecuredFileNotFound = 8,
    RepositoryOperationStatusRepositorySecureFail = 9,
    RepositoryOperationStatusRepositoryUnSecureFail = 10,
    RepositoryOperationStatusRepositoryOpenFail = 11,
    RepositoryOperationStatusRepositoryCloseFail = 12,
    RepositoryOperationStatusFeatureNotImplemented = 13,
    RepositoryOperationStatusRepositoryResetFailed = 14
} RepositoryOperationStatus;

typedef enum {
    
    RepositorySecurityTypeAutomatic = 1,
    RepositorySecurityTypeFileBased = 2
    
} RepositorySecurityType;

@protocol PasswordProtocol <NSObject>

@required
@property (copy, nonatomic) NSString *passwordNew;
@property (copy, nonatomic) NSString *passwordOld;
@property (copy, nonatomic) NSString *password;

@end

@protocol RepositorySecurityStrategyProtocol <NSObject>

@required
- (BOOL)isRepositorySecured:(Repository*)repository;
- (RepositorySecurityType)repositorySecurityType;
+ (instancetype)securityStrategyInstance;

@optional
- (RepositoryOperationStatus)resetSecuredRepository:(Repository*)repository;
- (RepositoryOperationStatus)secureRepository:(Repository*)repository withPassword:(NSString*)password;
- (RepositoryOperationStatus)unsecureRepository:(Repository*)repository withPassword:(NSString*)password;
- (RepositoryOperationStatus)reEncryptRepository:(Repository*)repository passwordTracker:(id<PasswordProtocol>)passwordTracker;;

@end

@protocol RepositoryProtocol <NSObject>

@required

@property (assign) BOOL isRepositoryOpen;
@property (assign) BOOL isRepositorySecured;

@property (strong,nonatomic,readonly) id<BackingstoreProtocol> backingstore;
@property (strong,nonatomic,readonly) id<RepositorySecurityStrategyProtocol> securityStrategy;
@property (strong,nonatomic,readonly) NSMutableArray *errorArray;

- (RepositoryOperationStatus)closeRepository;
- (RepositoryOperationStatus)openRepository;
- (RepositoryOperationStatus)resetBackingStore;
- (RepositoryOperationStatus)deleteBackingStore;


- (id)initWithBackingStore:(id<BackingstoreProtocol>)backingStore securityStrategy:(id<RepositorySecurityStrategyProtocol>)securityStrategy;
+ (Repository*)repository:(id<BackingstoreProtocol>)backingstore securityStrategy:(id<RepositorySecurityStrategyProtocol>)securityStrategy;

- (id)insertNewEntityNamed:(NSString*)entityName;
- (NSFetchRequest *)fetchRequestForEntityNamed:(NSString*)entityName batchSize:(NSInteger)batchSize;
- (NSArray *)resultsForRequest:(NSFetchRequest*)fetchRequest error:(NSError*)error;
- (NSArray *)resultsForRequest:(NSFetchRequest*)fetchRequest;
- (BOOL)deleteManagedObject:(NSManagedObject*)managedObject;

- (BOOL)save;
- (BOOL)saveWithRollbackOnError;
@optional
- (RepositoryOperationStatus)resetSecuredRepository;
- (RepositoryOperationStatus)secureRepositoryWithPassword:(NSString*)password;
- (RepositoryOperationStatus)unsecureRepositoryWithPassword:(NSString*)password;
- (RepositoryOperationStatus)reEncryptRepositoryWithPasswordTracker:(id<PasswordProtocol>)passwordTracker;


@end


