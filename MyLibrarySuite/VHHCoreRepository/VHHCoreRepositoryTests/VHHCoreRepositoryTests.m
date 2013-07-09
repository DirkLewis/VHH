//
//  VHHCoreRepositoryTests.m
//  VHHCoreRepositoryTests
//
//  Created by Dirk Lewis on 7/2/13.
//  Copyright (c) 2013 VideoHooHaa. All rights reserved.
//

#import <XCTest/XCTest.h>
#import <CoreData/CoreData.h>
#import "SQLiteBackingstore.h"
#import "Repository.h"
#import "FileLevelSecurityRepository.h"
#import "FieldLevelSecurityRepository.h"
#import "UnsecuredRepository.h"
#import "ProtocolHeaders.h"
#import "FieldLevelSecurityStrategy.h"
#import "FileLevelSecurityStrategy.h"
#import "EncryptionPasswordTracker.h"

@interface VHHCoreRepositoryTests : XCTestCase

@end

@implementation VHHCoreRepositoryTests{

    SQLiteBackingstore *_personBackingStore;
    SQLiteBackingstore *_stuffBackingStore;
    id<RepositoryProtocol> _repository;

}

- (void)setUp
{
    [super setUp];
    
    // Set-up code here.
    _personBackingStore = [[SQLiteBackingstore alloc]initWithModelName:@"model" toFile:@"person.sqlite" fromConfiguration:@"person"];
    _stuffBackingStore = [[SQLiteBackingstore alloc]initWithModelName:@"model" toFile:@"stuff.sqlite" fromConfiguration:@"stuff"];
    [[EncryptionPasswordTracker sharedEncryptionPasswordTracker]setPassword:@"p1"];
    [[EncryptionPasswordTracker sharedEncryptionPasswordTracker]setPasswordNew:@"p1"];
    [[EncryptionPasswordTracker sharedEncryptionPasswordTracker]setPasswordOld:@"p1"];

}

- (void)tearDown
{
    // Tear-down code here.
    
    
    _personBackingStore = nil;
    _stuffBackingStore = nil;
    _repository = nil;
    
    [super tearDown];
    
    
}

#pragma mark - Security Tests

- (void)testFieldLevelRepository{

    id<RepositorySecurityStrategyProtocol> securityStrategy = [[FieldLevelSecurityStrategy alloc] init];
    _repository = [[FieldLevelSecurityRepository alloc]initWithBackingStore:_personBackingStore securityStrategy:securityStrategy];
    [_repository openRepository];
    NSManagedObject *person = [_repository insertNewEntityNamed:@"Person"];
    [person setValue:@"dirk" forKey:@"firstName"];
    [person setValue:@"lewis" forKey:@"lastName"];
    [person setValue:@"secretData" forKey:@"secretData"];
    [_repository save];
    person = nil;
    
    [EncryptionPasswordTracker sharedEncryptionPasswordTracker].password = @"p2";
    [[[_repository backingstore]managedObjectContext]reset];

    person = [_repository resultsForRequest:[_repository fetchRequestForEntityNamed:@"Person" batchSize:0]][0];
    NSString *secretData = [person valueForKey:@"secretData"];
    XCTAssertNil(secretData, @"should not be in the clear.");
    
    person = nil;
    [EncryptionPasswordTracker sharedEncryptionPasswordTracker].password = @"p1";
    [[[_repository backingstore]managedObjectContext]reset];

    person = [_repository resultsForRequest:[_repository fetchRequestForEntityNamed:@"Person" batchSize:0]][0];
    secretData = [person valueForKey:@"secretData"];
    XCTAssertTrue([secretData isEqualToString:@"secretData"], @"should be in the clear.");

    [_repository closeRepository];
    [_repository deleteBackingStore];

}

- (void)testFieldLevelSecurityReEncryption{

    id<RepositorySecurityStrategyProtocol> securityStrategy = [[FieldLevelSecurityStrategy alloc] init];
    _repository = [[FieldLevelSecurityRepository alloc]initWithBackingStore:_personBackingStore securityStrategy:securityStrategy];
    [_repository openRepository];
    NSManagedObject *person = [_repository insertNewEntityNamed:@"Person"];
    [person setValue:@"dirk" forKey:@"firstName"];
    [person setValue:@"lewis" forKey:@"lastName"];
    [person setValue:@"secretData" forKey:@"secretData"];
    [_repository save];
    person = nil;
    
    [EncryptionPasswordTracker sharedEncryptionPasswordTracker].passwordNew = @"p2";

    [_repository reEncryptRepositoryWithPasswordTracker:[EncryptionPasswordTracker sharedEncryptionPasswordTracker]];
    [[[_repository backingstore]managedObjectContext]reset];

    person = [_repository resultsForRequest:[_repository fetchRequestForEntityNamed:@"Person" batchSize:0]][0];
    NSString *secretData = [person valueForKey:@"secretData"];
    XCTAssertTrue([secretData isEqualToString:@"secretData"], @"should be in the clear.");
    
    [_repository closeRepository];
    [_repository deleteBackingStore];
}

#pragma mark - Repository Tests

- (void)testRepositoryInitFailsWithException{
    XCTAssertThrows([[Repository alloc]init], @"should have thrown error");
}

- (void)testRepositoryinitWithBackingStoreFailsWithException{
    
    XCTAssertThrows([[Repository alloc]initWithBackingStore:_personBackingStore securityStrategy:nil], @"should have thrown error") ;

}

- (void)testInitializeRepositoryWithoutSecurity{

    UnsecuredRepository *repository = [[UnsecuredRepository alloc]initWithBackingStore:_personBackingStore securityStrategy:nil];
    XCTAssertNotNil(repository, @"should not be nil");
    RepositoryOperationStatus openStatus = [repository openRepository];
    RepositoryOperationStatus resetStatus = [repository resetBackingStore];
    XCTAssertTrue(openStatus == RepositoryOperationStatusSuccess, @"should have had a success");
    XCTAssertTrue(resetStatus == RepositoryOperationStatusSuccess, @"should have had a success");
}

- (void)testInitialzeRepositoryWithoutSecuritySharedMethod{

    id<RepositoryProtocol> repository = [UnsecuredRepository repository:_personBackingStore securityStrategy:nil];
    XCTAssertNotNil(repository, @"should not be nil");
    RepositoryOperationStatus openStatus = [repository openRepository];
    RepositoryOperationStatus resetStatus = [repository resetBackingStore];
    XCTAssertTrue(openStatus == RepositoryOperationStatusSuccess, @"should have had a success");
    XCTAssertTrue(resetStatus == RepositoryOperationStatusSuccess, @"should have had a success");
}

- (void)testAddingPersonData{

    _repository = [UnsecuredRepository repository:_personBackingStore securityStrategy:nil];
    [_repository openRepository];
    NSManagedObject *person = [_repository insertNewEntityNamed:@"Person"];
    [person setValue:@"dirk" forKey:@"firstName"];
    [person setValue:@"lewis" forKey:@"lastName"];
    [_repository save];
    
    NSArray *data = [_repository resultsForRequest:[_repository fetchRequestForEntityNamed:@"Person" batchSize:0]];
    
    XCTAssertTrue([data count] == 1, @"should have one record");
    [_repository deleteBackingStore];
    XCTAssertFalse([[_repository backingstore]persistantStoreFileExistsByName:@"person.sqlite"], @"file should not exist");
    
}

- (void)testAddingModifingDeletingPersonData{
    _repository = [UnsecuredRepository repository:_personBackingStore securityStrategy:nil];
    [_repository openRepository];
    NSManagedObject *person = [_repository insertNewEntityNamed:@"Person"];
    [person setValue:@"dirk" forKey:@"firstName"];
    [person setValue:@"lewis" forKey:@"lastName"];
    [_repository save];
    person = nil;
    
    NSArray *data = [_repository resultsForRequest:[_repository fetchRequestForEntityNamed:@"Person" batchSize:0]];
    XCTAssertTrue([data count] == 1, @"should have one record");
    person = data[0];
    [person setValue:@"JBob" forKey:@"firstName"];
    [_repository save];
    [_repository closeRepository];
    [_repository openRepository];
    person = nil;
    data = nil;
    
    data = [_repository resultsForRequest:[_repository fetchRequestForEntityNamed:@"Person" batchSize:0]];
    XCTAssertTrue([[(NSManagedObject*)data[0]valueForKey:@"firstName"]isEqualToString:@"JBob"], @"name should be JBob.");
    
    [_repository deleteManagedObject:data[0]];
    [_repository save];
    data = nil;
    data = [_repository resultsForRequest:[_repository fetchRequestForEntityNamed:@"Person" batchSize:0]];
    XCTAssertTrue([data count] == 0, @"there should be no person records");
    
    [_repository deleteBackingStore];
    XCTAssertFalse([[_repository backingstore]persistantStoreFileExistsByName:@"person.sqlite"], @"file should not exist");
}

#pragma mark - Backingstore Tests
- (void)testBackingStoreInitFailsWithException{
    
    XCTAssertThrows([[SQLiteBackingstore alloc]init], @"should have thrown error");
}

- (void)testInitializeBackingstore{

    SQLiteBackingstore *bs = [[SQLiteBackingstore alloc]initWithModelName:@"model" toFile:@"testdata.sqlite" fromConfiguration:Nil];
    XCTAssertNotNil(bs, @"should not be nil");
    
}

- (void)testBackingStoreFileExistsInPersistanceStore{

    SQLiteBackingstore *bs = [[SQLiteBackingstore alloc]initWithModelName:@"model" toFile:@"testdata.sqlite" fromConfiguration:Nil];
    [bs openBackingstore];
    XCTAssertTrue([bs persistantStoreFileExistsByName:@"testdata.sqlite"], @"file should exist");
    [bs DeleteBackingStore];
    XCTAssertFalse([bs persistantStoreFileExistsByName:@"testdata.sqlite"], @"file should not exist");

}

- (void)testBackingStoreOpenReset{
    SQLiteBackingstore *bs = [[SQLiteBackingstore alloc]initWithModelName:@"model" toFile:@"testdata.sqlite" fromConfiguration:Nil];
    BOOL open = [bs openBackingstore];
    BOOL close = [bs DeleteBackingStore];
    

    XCTAssertTrue(open, @"open failed");
    XCTAssertTrue(close, @"close faild");
}

- (void)testOpenResetPersonConfiguration{
    BOOL open = [_personBackingStore openBackingstore];
    BOOL close = [_personBackingStore DeleteBackingStore];
    XCTAssertTrue(open, @"open failed");
    XCTAssertTrue(close, @"close faild");
}

- (void)testOpenResetStuffConfiguration{
    BOOL open = [_stuffBackingStore openBackingstore];
    BOOL close = [_stuffBackingStore DeleteBackingStore];
    XCTAssertTrue(open, @"open failed");
    XCTAssertTrue(close, @"close faild");
}

@end
