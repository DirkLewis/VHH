//
//  TestAppTests.m
//  TestAppTests
//
//  Created by Dirk on 10/31/11.
//  Copyright (c) 2011 __MyCompanyName__. All rights reserved.
//

#import "TestAppTests.h"
#import "Dhirkin.h"

@implementation TestAppTests

- (void)setUp
{
    [super setUp];
    
    // Set-up code here.
}

- (void)tearDown
{
    // Tear-down code here.
    
    [super tearDown];
}

- (void)testAddingByExample{
    
    
    
    NSMutableArray *testArray = [[NSMutableArray alloc]init];
    
    //adding test block
    __block NSNumber *whenResult;
    __block NSArray *givenArguments;
    
    DhirkinResult (^givenAddingBlock)(NSArray*) = ^DhirkinResult(NSArray* arguments){
        givenArguments = arguments;
        return Passed;
    };
    
    DhirkinResult (^whenAddingBlock)(NSArray*) = ^DhirkinResult(NSArray* arguments){
        
        int left = [[givenArguments objectAtIndex:0]intValue];
        int right = [[givenArguments objectAtIndex:1]intValue];
        
        whenResult = [NSNumber numberWithInt:(left + right)];
        
        if (whenResult) {
            return Passed;
        }
        else{
            return Failed;
        }        
    };
    
    DhirkinResult (^thenAddingBlock)(NSArray*) = ^DhirkinResult(NSArray* arguments){
        
        NSNumber *answer = [arguments objectAtIndex:0];
        NSString *outcome = [arguments objectAtIndex:1];
        
        if ([outcome caseInsensitiveCompare:@"pass"] == NSOrderedSame) {
            if ([answer intValue] == [whenResult intValue]) {
                return  Passed;
            }
            else{
                return  Failed;
            }
        }
        else{
            if ([answer intValue] == [whenResult intValue]) {
                return  Failed;
            }
            else{
                return  Passed;
            }
        }
        
        
    };
    
    NSString *featurePath = [[NSBundle bundleForClass:[self class]] pathForResource:@"addingbyexample" ofType:@"feature"];
    NSString *featureString = [NSString stringWithContentsOfFile:featurePath encoding:NSASCIIStringEncoding error:nil];
    
    if ([featureString length] == 0 || featureString == nil) {
        STFail(@"The Feature File could not be found");
    }
    
    Dhirkin *dhirkin = [[Dhirkin alloc]initWthFeatureFileContents:featureString];
    
    
    NSDictionary *givenAdding = [NSDictionary dictionaryWithObjects:
                                 [NSArray arrayWithObjects:givenAddingBlock, @"Given the input <left> \\+ <right>", nil] forKeys:
                                 [NSArray arrayWithObjects:@"Block",@"Expression", nil]];
    
    NSDictionary *whenAdding = [NSDictionary dictionaryWithObjects:
                                [NSArray arrayWithObjects:whenAddingBlock, @"When the calculator is run", nil] forKeys:
                                [NSArray arrayWithObjects:@"Block",@"Expression", nil]];
    
    NSDictionary *thenAdding = [NSDictionary dictionaryWithObjects:
                                [NSArray arrayWithObjects:thenAddingBlock, @"Then the output should be <answer> with a result <outcome>", nil] forKeys:
                                [NSArray arrayWithObjects:@"Block",@"Expression", nil]];
    
    
    
    [testArray addObject:givenAdding];
    [testArray addObject:whenAdding];
    [testArray addObject:thenAdding];
    
    NSArray *results = [dhirkin runTests:testArray];
    
    NSString *resultMessage = @"ADDING BY EXAMPLE TESTS FAILED: \n";
    if ([results count] > 0) {
        for (NSString *result in results) {
            
            resultMessage =  [resultMessage stringByAppendingFormat:@"\n\n%@", result];
        }
        
        STAssertTrue(NO, resultMessage);
    }
    
}

- (void)testAddingTableDataSuite{
    NSMutableArray *testArray = [[NSMutableArray alloc]init];
    
    //adding test block
    
    __block NSArray *givenTable;
    __block NSArray *thenTable;
    __block NSArray *whenTableResult;
    
    DhirkinResult (^givenAddingTableBlock)(NSArray*) = ^DhirkinResult(NSArray* table){
        
        givenTable = table;
        return Passed;
        
    };
    
    DhirkinResult (^whenAddingTableBlock)(NSArray*) = ^DhirkinResult(NSArray* table){
        
        NSMutableArray *tempResults = [[NSMutableArray alloc]init];
        int columnCounter = 0;
        for (NSString *value in [givenTable objectAtIndex:0]) {
            
            if ([value rangeOfCharacterFromSet:[NSCharacterSet decimalDigitCharacterSet]].location != NSNotFound) {
                int left = [value intValue];
                int right = [[[givenTable objectAtIndex:1]objectAtIndex:columnCounter]intValue];
                int answer = left + right;
                
                [tempResults addObject:[NSNumber numberWithInt:answer]];
            }
            else{
                [tempResults addObject:value];//adds the header as a placeholder for consistancy.
            }
            columnCounter += 1;
            
        }
        
        whenTableResult = [NSArray arrayWithArray:tempResults];
        return Passed;
        
    };
    
    DhirkinResult (^thenAddingTableBlock)(NSArray*) = ^DhirkinResult(NSArray* table){
        
        thenTable = table;
        int rowCounter = 0;
        
        for (NSString *value in [thenTable objectAtIndex:0]) {
            
            if ([value rangeOfCharacterFromSet:[NSCharacterSet decimalDigitCharacterSet]].location != NSNotFound) {
                
                int testValue = [value intValue];
                int actualValue = [[whenTableResult objectAtIndex:rowCounter]intValue];
                
                if (testValue != actualValue) {
                    return Failed;
                }
                
            }
            rowCounter += 1;
        }
        
        return Passed;
    };
    
    NSString *featurePath = [[NSBundle bundleForClass:[self class]] pathForResource:@"addingtable" ofType:@"feature"];
    NSString *featureString = [NSString stringWithContentsOfFile:featurePath encoding:NSASCIIStringEncoding error:nil];
    
    if ([featureString length] == 0 || featureString == nil) {
        STFail(@"The Feature File could not be found");
    }
    
    Dhirkin *dhirkin = [[Dhirkin alloc]initWthFeatureFileContents:featureString];
    
    
    NSDictionary *whenAddingTable = [NSDictionary dictionaryWithObjects:
                                     [NSArray arrayWithObjects:whenAddingTableBlock, @"When the calculator is run for several values", nil] forKeys:
                                     [NSArray arrayWithObjects:@"Block",@"Expression", nil]];
    
    NSDictionary *givenAddingTable = [NSDictionary dictionaryWithObjects:
                                      [NSArray arrayWithObjects:givenAddingTableBlock, @"Given the input:", nil] forKeys:
                                      [NSArray arrayWithObjects:@"Block",@"Expression", nil]];
    
    NSDictionary *thenAddingTable = [NSDictionary dictionaryWithObjects:
                                     [NSArray arrayWithObjects:thenAddingTableBlock, @"Then the output should be:", nil] forKeys:
                                     [NSArray arrayWithObjects:@"Block",@"Expression", nil]];
    
    
    [testArray addObject:givenAddingTable];
    [testArray addObject:thenAddingTable];
    [testArray addObject:whenAddingTable];
    
    
    NSArray *results = [dhirkin runTests:testArray];
    
    NSString *resultMessage = @"ADDING WITH TABLE TESTS FAILED: \n";
    if ([results count] > 0) {
        for (NSString *result in results) {
            
            resultMessage =  [resultMessage stringByAppendingFormat:@"\n\n%@", result];
        }
        
        STAssertTrue(NO, resultMessage);
    }
    
}

- (void)testAdditionSuite
{
    
    NSMutableArray *testArray = [[NSMutableArray alloc]init];
    
    //adding test block
    __block NSNumber *whenResult;
    __block NSArray *givenArguments;
    
    DhirkinResult (^givenAddingBlock)(NSArray*) = ^DhirkinResult(NSArray* arguments){
        givenArguments = arguments;
        return Passed;
    };
    
    DhirkinResult (^whenAddingBlock)(NSArray*) = ^DhirkinResult(NSArray* arguments){
        
        int left = [[givenArguments objectAtIndex:0]intValue];
        int right = [[givenArguments objectAtIndex:1]intValue];
        
        whenResult = [NSNumber numberWithInt:(left + right)];
        
        if (whenResult) {
            return Passed;
        }
        else{
            return Failed;
        }
        
    };
    
    DhirkinResult (^andAddingBlock)(NSArray*) = ^DhirkinResult(NSArray* arguments){
        
        NSString *answer = [arguments objectAtIndex:0];
        
        if ([answer isEqualToString:@"'FULL'"]) {
            return Passed;
        }
        
        return  Failed;
        
    };
    
    DhirkinResult (^thenAddingBlock)(NSArray*) = ^DhirkinResult(NSArray* arguments){
        
        NSNumber *answer = [arguments objectAtIndex:0];
        
        if ([answer intValue] == [whenResult intValue]) {
            return  Passed;
        }
        else{
            return  Failed;
        }
    };
    
    NSString *featurePath = [[NSBundle bundleForClass:[self class]] pathForResource:@"adding" ofType:@"feature"];
    NSString *featureString = [NSString stringWithContentsOfFile:featurePath encoding:NSASCIIStringEncoding error:nil];
    
    if ([featureString length] == 0 || featureString == nil) {
        STFail(@"The Feature File could not be found");
    }
    
    Dhirkin *dhirkin = [[Dhirkin alloc]initWthFeatureFileContents:featureString];
    
    
    NSDictionary *givenAdding = [NSDictionary dictionaryWithObjects:
                                 [NSArray arrayWithObjects:givenAddingBlock, @"Given the input \\d \\+ \\d", nil] forKeys:
                                 [NSArray arrayWithObjects:@"Block",@"Expression", nil]];
    
    NSDictionary *whenAdding = [NSDictionary dictionaryWithObjects:
                                [NSArray arrayWithObjects:whenAddingBlock, @"When the calculator is run", nil] forKeys:
                                [NSArray arrayWithObjects:@"Block",@"Expression", nil]];
    
    
    NSDictionary *andAdding = [NSDictionary dictionaryWithObjects:
                               [NSArray arrayWithObjects:andAddingBlock, @"And the accesslevel is (.*)", nil] forKeys:
                               [NSArray arrayWithObjects:@"Block",@"Expression", nil]];   
    
    
    NSDictionary *thenAdding = [NSDictionary dictionaryWithObjects:
                                [NSArray arrayWithObjects:thenAddingBlock, @"Then the output should be \\d", nil] forKeys:
                                [NSArray arrayWithObjects:@"Block",@"Expression", nil]];
    
    
    
    [testArray addObject:givenAdding];
    [testArray addObject:whenAdding];
    [testArray addObject:andAdding];
    [testArray addObject:thenAdding];
    
    NSArray *results = [dhirkin runTests:testArray];
    
    NSString *resultMessage = @"ADDING TESTS FAILED: \n";
    if ([results count] > 0) {
        for (NSString *result in results) {
            
            resultMessage =  [resultMessage stringByAppendingFormat:@"\n\n%@", result];
        }
        
        STAssertTrue(NO, resultMessage);
    }
    
    
}



@end
