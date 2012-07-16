//
//  FirstViewController.m
//  iSaveGroceries
//
//  Created by Dirk on 2/11/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "SetupViewController.h"
#import "GeoLocator.h"

@interface SetupViewController ( Private )

- (void)findAndSaveGroceryStoresForZipCode:(NSString*)zipCode countyID:(NSString*)countyID;

@end

@implementation SetupViewController{

    CLLocationManager *_locationManager;
    BOOL _isLocationRunning;
    NSDictionary *_locationResultsDictionary;
    NSMutableDictionary *_smartSourceLocationData;
}

#pragma mark - Synth
@synthesize zipCodeTextField = _zipCodeTextField;
@synthesize cityNameLabel = _cityNameLabel;
@synthesize communityIDLabel = _CommunitIDLabel;
@synthesize communityNameLabel = _communityNameLabel;
@synthesize countyIDLabel = _countyIDLabel;
@synthesize countyNameLabel = _countyNameLabel;
@synthesize stateIDLabel = _stateIDLabel;
@synthesize stateNameLabel = _stateName;
@synthesize countryLabel = _countryLabel;

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Release any cached data, images, etc that aren't in use.
}

#pragma mark - View lifecycle

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    _smartSourceLocationData = [NSMutableDictionary dictionary];
}

- (void)viewDidUnload
{
    [self setZipCodeTextField:nil];
    [self setCityNameLabel:nil];
    [self setCommunityIDLabel:nil];
    [self setCommunityNameLabel:nil];
    [self setCountyIDLabel:nil];
    [self setCountyNameLabel:nil];
    [self setStateIDLabel:nil];
    [self setStateNameLabel:nil];
    [self setCountryLabel:nil];
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
}

- (void)viewWillDisappear:(BOOL)animated
{
	[super viewWillDisappear:animated];
}

- (void)viewDidDisappear:(BOOL)animated
{
	[super viewDidDisappear:animated];
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Return YES for supported orientations
    return (interfaceOrientation != UIInterfaceOrientationPortraitUpsideDown);
}

- (void)findAndSaveGroceryStoresForZipCode:(NSString*)zipCode countyID:(NSString*)countyID{
    
    Location *location = [Location fetchLocationForZipCodeAndCountyID:zipCode countyID:countyID];

    [SmartSource requestGroceryStoreDataByLocation:location results:^(id resultsData) {
        
        
        if (!resultsData) {
        }
                
        [GroceryStore storeGroceryStoreFromArray:resultsData location:location];
        
        [self hideHUDWithText:@"Finished"];
    }];

}

#pragma mark - Actions

- (IBAction)findLocaton:(id)sender {
    [self clearCookies:nil];

    [self showHUDWithText:@"Processing"];
    
    _locationManager = [[CLLocationManager alloc]init];
    [_locationManager setDelegate:self];
    [_locationManager setDistanceFilter:kCLDistanceFilterNone];
    [_locationManager setDesiredAccuracy:kCLLocationAccuracyBest];
    _isLocationRunning = YES;
    [_locationManager startUpdatingLocation];
}

- (IBAction)submitZip:(id)sender {
    [self clearCookies:nil];

    [self showHUDWithText:@"Processing"];
    

    if ([_zipCodeTextField.text length] != 0) {
        
        //start pulling data
        [SmartSource requestPostalcodeData:self.zipCodeTextField.text results:^(id resultsData) {
            NSString *result = resultsData;
            NSArray *temp = [SmartSourceElementParser parseLocationInformation:result];
            
            if ([temp count] == 0) {
                [self submitZip:nil];
            }
            
            for (NSDictionary *locations in temp) {
                
                for (NSString *key in [locations allKeys]) {
                    [_smartSourceLocationData setValue:[locations valueForKey:key] forKey:key];
                }
                
                self.cityNameLabel.text = [_smartSourceLocationData valueForKey:@"CityName"];
                self.communityIDLabel.text = [_smartSourceLocationData valueForKey:@"CommunityID"];
                self.communityNameLabel.text = [_smartSourceLocationData valueForKey:@"CommunityName"];
                self.countyIDLabel.text = [_smartSourceLocationData valueForKey:@"CountyID"];
                self.countyNameLabel.text = [_smartSourceLocationData valueForKey:@"CountyName"];
                self.stateIDLabel.text = [_smartSourceLocationData valueForKey:@"StateID"];
                
                if (![_smartSourceLocationData valueForKey:@"ZipCode"]) {
                    [_smartSourceLocationData setValue:self.zipCodeTextField.text forKey:@"ZipCode"];
                }
                else{
                    self.zipCodeTextField.text = [_smartSourceLocationData valueForKey:@"ZipCode"];
                    
                }
                
                self.stateNameLabel.text = [_smartSourceLocationData valueForKey:@"StateName"];
                self.countryLabel.text = [_smartSourceLocationData valueForKey:@"CountryName"];
                
                [Location storeLocationFromDictionary:_smartSourceLocationData];
                [self findAndSaveGroceryStoresForZipCode:self.zipCodeTextField.text countyID:[_smartSourceLocationData valueForKey:@"CountyID"]];
                [[NSNotificationCenter defaultCenter] postNotificationName:@"RefreshLocations" object:nil];
                _smartSourceLocationData = [NSMutableDictionary dictionary];
                
            }
            



        }];
        
    }
    else{
    
        //display alert that they must enter a zip.
    }
    
    [self.zipCodeTextField resignFirstResponder];

}

- (IBAction)clearCookies:(id)sender {
    

    NSURL *url = [NSURL URLWithString:@"http://smartsource.mygrocerydeals.com"];
    [SmartSource clearCookiesForURL:url];
    
}

#pragma mark - Location Manager Delegate

- (void)locationManager:(CLLocationManager *)manager didUpdateToLocation:(CLLocation *)newLocation fromLocation:(CLLocation *)oldLocation{
    
    [_locationManager stopUpdatingLocation];
    NSLog(@"My Location is: %@", newLocation);

    if (_isLocationRunning) {
        [GeoLocator requestReverseGeoCodeForLocation:newLocation results:^(NSDictionary *locationResultsDictionary) {
        
            _locationResultsDictionary = locationResultsDictionary;

            self.zipCodeTextField.text = [_locationResultsDictionary zipCodeFromLocation];
            [_smartSourceLocationData setValue:[_locationResultsDictionary zipCodeFromLocation] forKey:@"ZipCode"];
            [_smartSourceLocationData setValue:[_locationResultsDictionary stateFromLocation] forKey:@"StateName"];
            [_smartSourceLocationData setValue:[_locationResultsDictionary countryFromLocation] forKey:@"CountryName"];
            [self submitZip:nil];
            
        }];

    }
    _isLocationRunning = NO;

    
}
















@end



















