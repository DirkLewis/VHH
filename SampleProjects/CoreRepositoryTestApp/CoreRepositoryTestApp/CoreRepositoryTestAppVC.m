//
//  ViewController.m
//  CoreRepositoryTestApp
//
//  Created by Dirk Lewis on 7/19/12.
//  Copyright (c) 2012 Optima HCS. All rights reserved.
//

#import "CoreRepositoryTestAppVC.h"

#import "Person.h"
#import "Toy.h"
#import "EncryptionPasswordTracker.h"
#import "EncryptionTest.h"

#import "AppDelegate.h"
#import <CoreRepositoryLibrary/CoreRepositoryLibraryHeaders.h>

@interface CoreRepositoryTestAppVC ()

@end

@implementation CoreRepositoryTestAppVC
@synthesize updatedPasswordTextField = _updatedPasswordTextField;

@synthesize passwordTextField = _passwordTextField;

- (NSArray*)createTestData{
    UIImage *image = [UIImage imageNamed:@"pebblesB.png"];
    NSDictionary *robotToy = [NSDictionary dictionaryWithObjectsAndKeys:@"Robot",@"toyName",[NSNumber numberWithInt:5],@"toyValue",image,@"toyImage", nil];
    NSDictionary *chickenToy = [NSDictionary dictionaryWithObjectsAndKeys:@"Rubber Chicken",@"toyName",[NSNumber numberWithInt:1],@"toyValue",image,@"toyImage", nil];
    NSDictionary *shipToy = [NSDictionary dictionaryWithObjectsAndKeys:@"Old Ship",@"toyName",[NSNumber numberWithInt:10],@"toyValue",image,@"toyImage", nil];
    
    NSArray *personOneToys = [NSArray arrayWithObjects:robotToy, nil];
    NSArray *personTwoToys = [NSArray arrayWithObjects:robotToy,chickenToy, nil];
    NSArray *personThreeToys = [NSArray arrayWithObjects:robotToy,shipToy, nil];
    
    NSDictionary *personOne = [NSDictionary dictionaryWithObjectsAndKeys:@"moreSec1",@"moreSecrets",@"mydata1",@"secrets",@"John",@"firstName",@"Doe",@"lastName",[NSNumber numberWithInt:30],@"age",personOneToys,@"personToToy", nil];
    NSDictionary *personTwo = [NSDictionary dictionaryWithObjectsAndKeys:@"moreSec2",@"moreSecrets",@"mydata2",@"secrets",@"Jane",@"firstName",@"Doe",@"lastName",[NSNumber numberWithInt:20],@"age",personTwoToys,@"personToToy", nil];
    NSDictionary *personThree = [NSDictionary dictionaryWithObjectsAndKeys:@"moreSec3",@"moreSecrets",@"mydata3",@"secrets",@"Sally",@"firstName",@"Doe",@"lastName",[NSNumber numberWithInt:10],@"age",personThreeToys,@"personToToy", nil];
    
    return  [NSArray arrayWithObjects:personOne,personTwo,personThree, nil];
}


- (void)addPeopleToRepository:(Repository*)repo fromArray:(NSArray*)peopleArray{
    
    if ([[repo resultsForRequest:[repo fetchRequestForEntityNamed:[Person entityName] batchSize:20]]count]>0) {
        return;
    }
    
    for (NSDictionary *newPerson in peopleArray) {
        Person *person = [repo insertNewEntityNamed:[Person entityName]];
        
        for (NSString *keyname in [newPerson allKeys]) {
            if ([[newPerson valueForKey:keyname]isKindOfClass:[NSArray class]]) {
                for (NSDictionary *newToy in [newPerson valueForKey:@"personToToy"]) {
                    Toy *toy = [repo insertNewEntityNamed:[Toy entityName]];
                    [toy setValuesForKeysWithDictionary:newToy];
                    [toy setToyToPerson:person];
                }            
            }
            else {
                [person setValue:[newPerson valueForKey:keyname] forKeyPath:keyname];
            }
        }
        NSLog(@"My secret is: %@ : More Secrets: %@",person.secrets,person.moreSecrets);
    }
    
    [repo save];
}

- (NSArray*)peopleWithToysWorthMoreThan:(NSNumber*)value inRepository:(Repository*)repo{
    
    NSFetchRequest *request = [repo fetchRequestForEntityNamed:[Person entityName] batchSize:20];
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"SUBQUERY(personToToy,$t,$t.toyValue > %i).@count > 0",[value intValue]];
    
    
    [request setPredicate:predicate];
    NSArray *results = [repo resultsForRequest:request];
    
    NSLog(@"%@",results);
    return results;
}

- (NSNumber *)aggregateOperation:(NSString *)function onAttribute:(NSString *)attributeName withPredicate:(NSPredicate *)predicate inRepository:(Repository*)repo
{
    NSExpression *ex = [NSExpression expressionForFunction:function arguments:[NSArray arrayWithObject:[NSExpression expressionForKeyPath:attributeName]]];
    
    
    NSExpressionDescription *ed = [[NSExpressionDescription alloc] init];
    [ed setName:@"result"];
    [ed setExpression:ex];
    [ed setExpressionResultType:NSInteger64AttributeType];
    
    NSArray *properties = [NSArray arrayWithObject:ed];
    
    NSFetchRequest *request = [repo fetchRequestForEntityNamed:[Person entityName] batchSize:20];
    [request setPropertiesToFetch:properties];
    [request setResultType:NSDictionaryResultType];
    
    if (predicate != nil)
        [request setPredicate:predicate];
    
    NSArray *results = [repo resultsForRequest:request];
    NSDictionary *resultsDictionary = [results objectAtIndex:0];
    NSNumber *resultValue = [resultsDictionary objectForKey:@"result"];
    return resultValue;
    
}

- (id<RepositoryProtocol>)createRepository{

    return [RepositoryFactory createFieldLevelRepositoryForModel:@"Model" toFile:@"MyNewModel.sqlite" fromConfiguration:nil];

}

- (void)examineRepository{

    id<RepositoryProtocol> repo = [self createRepository];
    [repo openRepository];
    NSArray *people = [repo resultsForRequest:[repo fetchRequestForEntityNamed:[Person entityName] batchSize:20]];
    
    for (Person *person in people) {
        DLog(@"%@ %@",[person secrets],[person moreSecrets]);
        DLog(@"%@",[(Toy*)[[person.personToToy allObjects]objectAtIndex:0]toyImage]);
        DLog(@"stopper");
    }
    [repo closeRepository];
}

- (BOOL)encryptionTest{
    
    id<RepositoryProtocol> repo = [self createRepository];
    [repo openRepository];
    
    NSFetchRequest *fetchRequest = [repo fetchRequestForEntityNamed:[EncryptionTest entityName] batchSize:20];
    EncryptionTest *test = [[repo resultsForRequest:fetchRequest] objectAtIndex:0];
    
    if (test.testValue) {
        return YES;
    }
    
    return NO;
}

- (IBAction)touchRunStuff:(id)sender{
    
    [EncryptionPasswordTracker sharedEncryptionPasswordTracker].password = self.passwordTextField.text;
    [EncryptionPasswordTracker sharedEncryptionPasswordTracker].passwordOld = self.passwordTextField.text;
    [EncryptionPasswordTracker sharedEncryptionPasswordTracker].passwordNew = self.updatedPasswordTextField.text;
    
    

    // Do any additional setup after loading the view, typically from a nib.
    
    id<RepositoryProtocol> repo = [self createRepository];

    RepositoryOperationStatus status;
    if ([repo respondsToSelector:@selector(unsecureRepositoryWithPassword:)]) {
        status = [repo unsecureRepositoryWithPassword:[EncryptionPasswordTracker sharedEncryptionPasswordTracker].password];
    }
    
    if ([repo openRepository] == RepositoryOperationStatusSuccess) {
        
        NSArray *people = [self createTestData];
        [self addPeopleToRepository:repo fromArray:people];
        
        [self aggregateOperation:@"average:" onAttribute:@"age" withPredicate:nil inRepository:repo];
        [self peopleWithToysWorthMoreThan:[NSNumber numberWithInt:9] inRepository:repo];
        
        static dispatch_once_t onceToken;        
        dispatch_once(&onceToken, ^{
            
            EncryptionTest *newENCTest = [repo insertNewEntityNamed:[EncryptionTest entityName]];
            newENCTest.testValue = @"TESTVALUE";
            [repo save];
        });
    }
    
    [repo save];
    
    if (![self encryptionTest]) {
        DLog(@"Bad security");
        return;
    }
    
    if ([repo respondsToSelector:@selector(secureRepositoryWithPassword:)]) {
        status = [repo secureRepositoryWithPassword:[EncryptionPasswordTracker sharedEncryptionPasswordTracker].password];
    }
    DLog(@"%@",[EncryptionPasswordTracker sharedEncryptionPasswordTracker].password);
    DLog(@"%@",[EncryptionPasswordTracker sharedEncryptionPasswordTracker].passwordNew);
    DLog(@"%@",[EncryptionPasswordTracker sharedEncryptionPasswordTracker].passwordOld);
    [self examineRepository];
    
    if ([repo respondsToSelector:@selector(reEncryptRepositoryWithPasswordTracker:)]) {
        if ([repo reEncryptRepositoryWithPasswordTracker:[EncryptionPasswordTracker sharedEncryptionPasswordTracker]] == RepositoryOperationStatusSuccess) {
            self.passwordTextField.text = [EncryptionPasswordTracker sharedEncryptionPasswordTracker].passwordNew;
            DLog(@"Password - %@",[EncryptionPasswordTracker sharedEncryptionPasswordTracker].passwordNew);
            [EncryptionPasswordTracker sharedEncryptionPasswordTracker].password = [EncryptionPasswordTracker sharedEncryptionPasswordTracker].passwordNew;
            DLog(@"%@",[EncryptionPasswordTracker sharedEncryptionPasswordTracker].password);
            DLog(@"%@",[EncryptionPasswordTracker sharedEncryptionPasswordTracker].passwordNew);
            DLog(@"%@",[EncryptionPasswordTracker sharedEncryptionPasswordTracker].passwordOld);

            [self examineRepository];
        }
    }
    
    if ([repo isRepositorySecured] && [repo.securityStrategy repositorySecurityType] != RepositorySecurityTypeAutomatic) {
        [repo resetSecuredRepository];
        [repo closeRepository];
    }
    else {
        [repo closeRepository];
    }
    
}

- (IBAction)touchCreateSystemRepo:(id)sender {
    
    id<RepositoryProtocol> repo = [RepositoryFactory createFieldLevelRepositoryForModel:@"Model" toFile:@"SystemLog.sqlite" fromConfiguration:@"System"];
    [repo openRepository];
    [repo closeRepository];
}

- (void)viewDidLoad
{
    [super viewDidLoad];

}

- (void)viewDidUnload
{
    [self setUpdatedPasswordTextField:nil];
    [super viewDidUnload];
    // Release any retained subviews of the main view.
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation != UIInterfaceOrientationPortraitUpsideDown);
}

- (IBAction)touchRestButton:(id)sender {
    id<RepositoryProtocol> repo = [self createRepository];
    [repo openRepository];
    [repo resetBackingstore];
    [repo closeRepository];
    
}

@end
