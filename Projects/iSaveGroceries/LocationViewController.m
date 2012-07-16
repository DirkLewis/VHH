//
//  SecondViewController.m
//  iSaveGroceries
//
//  Created by Dirk on 2/11/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "LocationViewController.h"
#import "Location.h"
#import "GeoLocator.h"

@interface LocationViewController ( )
- (void)refreshNotification:(NSNotification*)notification;
- (void)findAndSaveGroceryStoresForZipCode:(NSString*)zipCode countyID:(NSString*)countyID;
- (void)clearCookies;
@end

@implementation LocationViewController{

    CLLocationManager *_locationManager;
    BOOL _isLocationRunning;
    NSDictionary *_locationResultsDictionary;
    NSMutableDictionary *_smartSourceLocationData;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Release any cached data, images, etc that aren't in use.
}

#pragma mark - View lifecycle

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    _smartSourceLocationData = [NSMutableDictionary dictionary];
    
    
	// Do any additional setup after loading the view, typically from a nib.
    self.useCustomHeaders = YES;
    [self refresh];
}

- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    UIBarButtonItem *button = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemRefresh target:self action:@selector(refresh)];
	[self.navigationItem setRightBarButtonItem:button animated:YES];
    [self.navigationItem setTitle:@"Locations"];
    [self.navigationController setToolbarHidden:NO];

    [VHHStyleSheet styleTableForMenuList:self.flexibleTableView];
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    [[NSNotificationCenter defaultCenter] removeObserver:self];

    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(refreshNotification:) name:@"RefreshLocations" object:nil];
}

- (void)viewWillDisappear:(BOOL)animated
{
	[super viewWillDisappear:animated];

}

- (void)viewDidDisappear:(BOOL)animated
{
	[super viewDidDisappear:animated];
    [self.navigationController setToolbarHidden:YES];

}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Return YES for supported orientations
    return (interfaceOrientation != UIInterfaceOrientationPortraitUpsideDown);
}

- (void)refreshNotification:(NSNotification*)notification{

    [self refresh];

}

#pragma mark - Actions


- (IBAction)touchLocateMe:(id)sender {
    [self clearCookies];
    
    [self showHUDWithText:@"Processing"];
    
    _locationManager = [[CLLocationManager alloc]init];
    [_locationManager setDelegate:self];
    [_locationManager setDistanceFilter:kCLDistanceFilterNone];
    [_locationManager setDesiredAccuracy:kCLLocationAccuracyBest];
    _isLocationRunning = YES;
    [_locationManager startUpdatingLocation];
}

- (IBAction)touchAddMyZip:(id)sender {
    
    //show alert with text input to get the zip
    [[UIAlertView createZipCodeAlertView:self]show];
}

- (IBAction)touchResetData:(id)sender {
    
    [[iSaveRepository sharedInstance]resetBackingstore];
    [self refresh];
    
}

#pragma mark - Private Methods

- (void)submitZipCode:(NSString*)zipCode{

    [self clearCookies];
    
    [self showHUDWithText:@"Processing"];
    
    
    if ([zipCode length] != 0) {
        
        //start pulling data
        [SmartSource requestPostalcodeData:zipCode results:^(id resultsData) {
            NSString *result = resultsData;
            NSArray *temp = [SmartSourceElementParser parseLocationInformation:result];
            
            if ([temp count] == 0) {
                [self submitZipCode:zipCode];
            }
            
            for (NSDictionary *locations in temp) {
                
                for (NSString *key in [locations allKeys]) {
                    [_smartSourceLocationData setValue:[locations valueForKey:key] forKey:key];
                }
                
                
                if (![_smartSourceLocationData valueForKey:@"ZipCode"]) {
                    [_smartSourceLocationData setValue:zipCode forKey:@"ZipCode"];
                }
                else{
                    [zipCode isEqualToStringCaseInsensitive:[_smartSourceLocationData valueForKey:@"ZipCode"]];
                    
                }
                
                [Location storeLocationFromDictionary:_smartSourceLocationData];
                [self findAndSaveGroceryStoresForZipCode:zipCode countyID:[_smartSourceLocationData valueForKey:@"CountyID"]];
                [[NSNotificationCenter defaultCenter] postNotificationName:@"RefreshLocations" object:nil];
                _smartSourceLocationData = [NSMutableDictionary dictionary];
                
            }
        }];
        
    }
    else{
        
        //display alert that they must enter a zip.
    }
    
}

- (void)clearCookies{
    
    
    NSURL *url = [NSURL URLWithString:@"http://smartsource.mygrocerydeals.com"];
    [SmartSource clearCookiesForURL:url];
    
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

#pragma mark - Location Manager Delegate

- (void)locationManager:(CLLocationManager *)manager didUpdateToLocation:(CLLocation *)newLocation fromLocation:(CLLocation *)oldLocation{
    
    [_locationManager stopUpdatingLocation];
    
    if (_isLocationRunning) {
        [GeoLocator requestReverseGeoCodeForLocation:newLocation results:^(NSDictionary *locationResultsDictionary) {
            
            _locationResultsDictionary = locationResultsDictionary;
            
            [_smartSourceLocationData setValue:[_locationResultsDictionary zipCodeFromLocation] forKey:@"ZipCode"];
            [_smartSourceLocationData setValue:[_locationResultsDictionary stateFromLocation] forKey:@"StateName"];
            [_smartSourceLocationData setValue:[_locationResultsDictionary countryFromLocation] forKey:@"CountryName"];
            [self submitZipCode:[_smartSourceLocationData valueForKey:@"ZipCode"]];
            
        }];
        
    }
    _isLocationRunning = NO;
    
    
}

#pragma mark - Flexible Table
- (void)createRows{

    NSArray *locations = [Location fetchArrayOfAllLocationsSortedByCityName];

    [self addSectionAtIndex:0 WithAnimation:UITableViewRowAnimationAutomatic];
    for (Location *location in locations) {
        
        [self appendRowToSection:0 CellClass:[LocationTableViewCell class] CellData:location WithAnimation:UITableViewRowAnimationAutomatic];
    }
    
    
    
}


- (void)refresh{
    
    [self refreshWithDelay:0.0];
    
}

- (void)refreshWithDelay:(NSTimeInterval)delay{
    
	[self removeAllSectionsWithAnimation:UITableViewRowAnimationFade];
	[self performSelector:@selector(createRows) withObject:nil afterDelay:delay];
}


#pragma mark - TableView delegate methods

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    [super tableView:tableView didSelectRowAtIndexPath:indexPath];    
    
    
    Class cellClass = [self cellClassForRow:indexPath.row InSection:indexPath.section];
    if ([cellClass isHeaderFooter] && [indexPath row] == 0) {
        return;
    }
    
    if ([cellClass isHeaderFooter] && [[self sectionAtIndex:[indexPath section]]count] - 1 == [indexPath row]) {
        return;
    }
    
    // Toggle 'selected' state
    BOOL isSelected = ![self cellIsSelected:indexPath];
    // Store cell 'selected' state keyed on indexPath
    NSNumber *selectedIndex = [NSNumber numberWithBool:isSelected];
    [self setCellIsSelected:selectedIndex forKey:indexPath];
    
    [self.flexibleTableView beginUpdates];
    [self.flexibleTableView endUpdates];
    
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    Class cellClass = [self cellClassForRow:indexPath.row InSection:indexPath.section];
    
    if ([cellClass isHeaderFooter] && [indexPath row] == 0) {
        return [cellClass rowHeight];
    }
    
    if ([cellClass isHeaderFooter] && [[self sectionAtIndex:[indexPath section]]count] - 1 == [indexPath row]) {
        return [cellClass rowHeight];
    }  
    
    if ([self cellIsSelected:indexPath]) {
        
        return [cellClass rowExpandedHeight];
    }
    else{
        return [cellClass rowHeight];
    }
}

- (NSString*)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section{
    
    return @"";
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender{

    NSIndexPath *indexPath =  [self.flexibleTableView indexPathForSelectedRow];
    id data = [self dataForRow:indexPath.row InSection:indexPath.section];
    GroceryStoresViewController *gsvc = (GroceryStoresViewController*)segue.destinationViewController;
    gsvc.location = (Location*)data;
}

#pragma mark - alert view delegate

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex{

    if (alertView.tag == kZipCodeAlertView) {
        
        if ([[alertView textFieldAtIndex:0].text length] == 5) {
            [self submitZipCode:[alertView textFieldAtIndex:0].text];
        }

    }
}
@end
