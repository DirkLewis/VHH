//
//  SmartSourceElementParser.m
//  iSaveGroceries
//
//  Created by Dirk on 2/11/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "SmartSourceElementParser.h"


@implementation SmartSourceElementParser{
    

}

+ (NSArray*)parseLocationInformation:(NSString*)locationInfo{
    
    NSMutableArray *tokenArray = [NSMutableArray array];
    NSMutableArray *locationInfoArray = [NSMutableArray array];
    
    PKTokenizer *tokenizer = [PKTokenizer tokenizerWithString:locationInfo];
    PKToken *pkToken = nil;
    
    while ((pkToken = [tokenizer nextToken]) != [PKToken EOFToken]) {
        [tokenArray addObject:pkToken];
    }
    NSMutableDictionary *dataDictionary;

    for (int i = 0; i < [tokenArray count]-1; i++) {
        

		NSString *token = [[tokenArray objectAtIndex:i]description];
		
		if ( [token isEqualToString:@"'county_id'"]) {
			
            dataDictionary = [NSMutableDictionary dictionary];
			PKToken *countyID =[tokenArray objectAtIndex:i + 3];
			NSString *value = [countyID description];
			[dataDictionary setValue:value forKey:@"CountyID"];
		}
		
		if ([token isEqualToString:@"'county_name'"]) {
			
			PKToken *countyName =[tokenArray objectAtIndex:i + 3];
            NSString *value = [NSString replaceStringOccurance:[countyName description] targetCharacter:@"\"" replacementCharacter:@""];
			[dataDictionary setValue:value forKey:@"CountyName"];
                        
		}
        
		if ([token isEqualToString:@"'city_name'"]) {
			
			PKToken *cityName =[tokenArray objectAtIndex:i + 3];
            NSString *value = [NSString replaceStringOccurance:[cityName description] targetCharacter:@"\"" replacementCharacter:@""];
			[dataDictionary setValue:value forKey:@"CityName"];

		}
		
		if ([token isEqualToString:@"'state_id'"]) {
			
			PKToken *stateID =[tokenArray objectAtIndex:i + 3];
			NSString *value = [stateID description];
			[dataDictionary setValue:value forKey:@"StateID"];
		}	
		
		if ([token isEqualToString:@"'community_id'"]) {
			
			PKToken *communityID =[tokenArray objectAtIndex:i + 3];
			NSString *value = [communityID description];
			[dataDictionary setValue:value forKey:@"CommunityID"];
			
		}	
		if ([token isEqualToString:@"'community_name'"]) {
			
			PKToken *communityName =[tokenArray objectAtIndex:i + 3];
            NSString *value = [NSString replaceStringOccurance:[communityName description] targetCharacter:@"\"" replacementCharacter:@""];
			[dataDictionary setValue:value forKey:@"CommunityName"];
            [locationInfoArray addObject:dataDictionary];
            dataDictionary = nil;
		}
        
	}
   
    return locationInfoArray;
}

+ (NSArray*)parseGroceryStores:(NSString*)groceryStores{

    
	NSString *formattedGroceryStores = [groceryStores stringByReplacingPercentEscapesUsingEncoding:NSStringEncodingConversionExternalRepresentation];
	NSArray *storeArray = [formattedGroceryStores componentsSeparatedByString:@","];
	
	return storeArray;
}

+ (NSArray*)parseGrocerySaleItems:(NSString*)grocerySaleItems{

    NSCharacterSet *nonDecimalToRemove = [[NSCharacterSet decimalDigitCharacterSet] invertedSet];
    NSCharacterSet *whiteSpaceToRemove = [NSCharacterSet whitespaceCharacterSet];
    NSMutableArray *saleItems = [NSMutableArray array];
    
    NSRange startRange = [grocerySaleItems rangeOfString:@"<div id=\"resultSet\" class=\"\">" options:NSCaseInsensitiveSearch];
    NSRange endRange = [grocerySaleItems rangeOfString:@"<div id=\"footer\" class=\"clearfix\">" options:NSCaseInsensitiveSearch];
    
    if (startRange.length == 0 || endRange.length == 0) {
        return nil;
    }
    
    NSString *saleItemResults = [grocerySaleItems substringWithRange:NSMakeRange(startRange.location, (endRange.location - startRange.location))];
    
    if (!saleItemResults) {
        return nil;
    }
    
    DocumentRoot *document = [Element parseHTML:saleItemResults];
    
    NSArray *elements = [document selectElements:@"div.dealDisplay"];
    
    for (Element *element in elements) {
        
        NSMutableDictionary *newSaleItem = [NSMutableDictionary dictionary];
        
        NSArray *priceData = [element selectElements:@"div.price strong"];
        NSArray *saleEndDate = [element selectElements:@"div.price span"];
        
        if ([priceData count] == 0) {
            continue;
        }
        
        if ([saleEndDate count] == 1) {
            [newSaleItem setObject:@"0.00" forKey:@"RegularPrice"];
            NSString *contentsText = [[[priceData objectAtIndex:1]contentsText]stringByTrimmingCharactersInSet:nonDecimalToRemove];
            [newSaleItem setObject:contentsText forKey:@"SalePrice"];
            [newSaleItem setObject:[[saleEndDate objectAtIndex:0]contentsText] forKey:@"SaleEndDate"];
        }
        else if ([saleEndDate count] > 1){
            
            NSLog(@"%@",saleEndDate);
            NSString *regularPrice = [[[saleEndDate objectAtIndex:0]contentsText]stringByTrimmingCharactersInSet:nonDecimalToRemove];
            NSString *salePrice = [[[priceData objectAtIndex:([priceData count]-1)]contentsText] stringByTrimmingCharactersInSet:nonDecimalToRemove];            
            [newSaleItem setObject:regularPrice forKey:@"RegularPrice"];
            [newSaleItem setObject:salePrice forKey:@"SalePrice"];
            [newSaleItem setObject:[[saleEndDate objectAtIndex:1] contentsText] forKey:@"SaleEndDate"];
        }
        
        NSArray *descriptionData = [element selectElements:@"div.desc strong"];
        
        if ([descriptionData count]>0) {
            
            if ([descriptionData count] == 2) {
                
                [newSaleItem setObject:[[descriptionData objectAtIndex:0]contentsText] forKey:@"Description"];
                [newSaleItem setObject:[[[descriptionData objectAtIndex:1] contentsText] stringByTrimmingCharactersInSet:whiteSpaceToRemove] forKey:@"Weight"];
                
            }
            else{
            
                if ([[[descriptionData objectAtIndex:0]contentsText]length] > 10) {
                    [newSaleItem setObject:[[descriptionData objectAtIndex:0]contentsText] forKey:@"Description"];
                    [newSaleItem setObject:@"Not Available" forKey:@"Weight"];
                }
                else{
                    [newSaleItem setObject:@"Not Available" forKey:@"Description"];
                    [newSaleItem setObject:[[[descriptionData objectAtIndex:0]contentsText]stringByTrimmingCharactersInSet:whiteSpaceToRemove] forKey:@"Weight"];
                }
            
            }
            
        }
        else{
        
            [newSaleItem setObject:@"Not Available" forKey:@"Description"];
            [newSaleItem setObject:@"Weight" forKey:@"Weight"];
        }
        
        NSArray *commentData = [element selectElements:@"div.desc span"];
        if ([commentData count] == 1) {
            [newSaleItem setObject:[[commentData objectAtIndex:0]contentsText] forKey:@"Comment"];
        }
        else{
            [newSaleItem setObject:@"Not Availiable" forKey:@"Comment"];
        }
        
        Element *imageData = [element selectElement:@"div.image div.zoom a"];
        
        NSDictionary *imageDictionary = [imageData attributes];
        
        if ([imageDictionary count] > 0) {
            if (![[imageDictionary objectForKey:@"href"] isEqualToStringCaseInsensitive:@"/products/nw/200/0/1/1/1000031110.jpg"]) {
                [newSaleItem setObject:[imageDictionary objectForKey:@"href"] forKey:@"Image"];
            }
            else{
                [newSaleItem setObject:@"No Image Available" forKey:@"Image"];
            }
        }
        
        Element *categoryData = [element selectElement:@"div.category"];
        
        if ([[categoryData contentsText]length]>0) {
            [newSaleItem setObject:[categoryData contentsText] forKey:@"Category"];
        }
        else{
            [newSaleItem setObject:@"No Category" forKey:@"Category"];
        }
        
        [saleItems addObject:newSaleItem];
    }
    

    return saleItems;
}

@end
