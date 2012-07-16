//
//  NSDictionary+Location.m
//  iSaveGroceries
//
//  Created by Dirk on 2/11/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "NSDictionary+Location.h"

@implementation NSDictionary (Location)

- (BOOL)usesSubAdministrativeArea{

    NSDictionary *sub = [[self valueForKeyPath:@"Placemark.AddressDetails.Country.AdministrativeArea.SubAdministrativeArea"]objectAtIndex:0];
    
    NSDictionary *admin = [[self valueForKeyPath:@"Placemark.AddressDetails.Country.AdministrativeArea"]objectAtIndex:0];
    
    
    if ([sub isKindOfClass:[NSDictionary class]]) {
    
        return YES;
    }
    else if ([admin isKindOfClass:[NSDictionary class]]){
    
        return NO;
    
    }
    
    return NO;

}

- (NSString*)locationStringForKeyPath:(NSString*)keyPath{

    NSString *value = [[self valueForKeyPath:keyPath]objectAtIndex:0];
    return value;



    
}

- (NSString*)zipCodeFromLocation{

    if ([self usesSubAdministrativeArea]) {
        return [self locationStringForKeyPath:@"Placemark.AddressDetails.Country.AdministrativeArea.SubAdministrativeArea.Locality.PostalCode.PostalCodeNumber"];
    }
    else{
        return [self locationStringForKeyPath:@"Placemark.AddressDetails.Country.AdministrativeArea.Locality.PostalCode.PostalCodeNumber"];
    }
    
}

- (NSString*)stateFromLocation{
    return [self locationStringForKeyPath:@"Placemark.AddressDetails.Country.AdministrativeArea.AdministrativeAreaName"];
}

- (NSString*)countryFromLocation{

    return  [self locationStringForKeyPath:@"Placemark.AddressDetails.Country.CountryName"];
}


@end
