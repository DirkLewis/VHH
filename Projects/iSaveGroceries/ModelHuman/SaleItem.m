#import "SaleItem.h"
#import "NSString+VHHAdditions.h"
#import "NSString+iSaveAdditions.h"
@implementation SaleItem

// Custom logic goes here.
+ (NSArray *)sortDescriptorsForSaleItem{
    
    return [NSArray arrayWithObjects:[[NSSortDescriptor alloc] initWithKey:@"category" ascending:YES],[[NSSortDescriptor alloc] initWithKey:@"itemDescription" ascending:YES],nil];
}

+ (NSArray *)sortDescriptorsForCategories{
    
	return [NSArray arrayWithObjects:[[NSSortDescriptor alloc] initWithKey:@"category" ascending:YES],nil];
}

+ (NSArray *)sortDescriptorsForSaleEndDateAcending:(BOOL)acending{
    
	return [NSArray arrayWithObjects:[[NSSortDescriptor alloc] initWithKey:@"saleEndDate" ascending:acending],nil];
}


+ (BOOL)updateSaleItemFromDictionary:(NSDictionary*)saleItemDictionary groceryStore:(GroceryStore*)groceryStore{
    
    SaleItem *existingSaleItem = [SaleItem fetchSaleItemForDescription:[saleItemDictionary valueForKey:@"Description"] groceryStore:groceryStore];
    
    if (existingSaleItem) {
        
        existingSaleItem.itemDescription = [[saleItemDictionary valueForKey:@"Description"]stringByTrimmingLeadingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]];
        NSString *category = [[saleItemDictionary valueForKey:@"Category"] reformatCategory];
        existingSaleItem.category = category;
        existingSaleItem.comment = [[saleItemDictionary  valueForKey:@"Comment"]stringByTrimmingLeadingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]];
        existingSaleItem.regularPrice = [saleItemDictionary valueForKey:@"RegularPrice"];
        
        NSString *salePrice = [[saleItemDictionary valueForKey:@"SalePrice"]reformatSalePrice];
        existingSaleItem.salePrice = salePrice;
        existingSaleItem.weight = [saleItemDictionary valueForKey:@"Weight"];
        NSString *saleEndDate = [saleItemDictionary valueForKey:@"SaleEndDate"];
        existingSaleItem.saleEndDate = [NSDate dateFromString:saleEndDate];
        return YES;
    }
    
    return NO;
    
}

+ (BOOL)storeSaleItemFromArray:(NSArray*)smartSourceSaleItemArray groceryStore:(GroceryStore*)groceryStore{
    
    
    for (NSDictionary *saleItemDictionary in smartSourceSaleItemArray) {
        
        if ([SaleItem updateSaleItemFromDictionary:saleItemDictionary groceryStore:groceryStore]) {
            continue;
        }
        
        SaleItem *newSaleItem = [[iSaveRepository sharedInstance] insertNewEntityNamed:[SaleItem className]];
        
        newSaleItem.itemDescription = [[saleItemDictionary valueForKey:@"Description"]stringByTrimmingLeadingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]] ;
        NSString *category = [[saleItemDictionary valueForKey:@"Category"] reformatCategory];
        newSaleItem.category = category;
        newSaleItem.comment = [[saleItemDictionary  valueForKey:@"Comment"]stringByTrimmingLeadingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]];
        newSaleItem.regularPrice = [saleItemDictionary valueForKey:@"RegularPrice"];
        
        NSString *salePrice = [[saleItemDictionary valueForKey:@"SalePrice"]reformatSalePrice];
        newSaleItem.salePrice = salePrice;
        newSaleItem.weight = [saleItemDictionary valueForKey:@"Weight"];
        
        NSString *saleEndDate = [saleItemDictionary valueForKey:@"SaleEndDate"];
        newSaleItem.saleEndDate = [NSDate dateFromString:saleEndDate];
        [newSaleItem setSaleItemToStore:groceryStore];
    }
    
    return [[iSaveRepository sharedInstance] save];
    
}

+ (SaleItem*)fetchSaleItemForDescription:(NSString*)saleItemDescription{
    
    NSPredicate *filter = [NSPredicate predicateWithFormat:@"itemDescription == %@",saleItemDescription];
    NSFetchRequest *fetchRequest = [SaleItem fetchRequestForSaleItem];
    [fetchRequest setPredicate:filter];
    
    NSArray *fetchResults = [[iSaveRepository sharedInstance] resultsForRequest:fetchRequest];
    if ([fetchResults count] == 1) {
        return [fetchResults objectAtIndex:0];
    }
    else if ([fetchResults count] > 1){
        [NSException raise:@"Invalid Data" format:@"More than one sale items returned"];
    }
    return nil;
    
}


+ (SaleItem*)fetchSaleItemForDescription:(NSString*)saleItemDescription groceryStore:(GroceryStore*)groceryStore{
    
    NSPredicate *filter = [NSPredicate predicateWithFormat:@"saleItemToStore == %@ AND itemDescription == %@",groceryStore, saleItemDescription];
    NSFetchRequest *fetchRequest = [SaleItem fetchRequestForSaleItem];
    [fetchRequest setPredicate:filter];
    
    NSArray *fetchResults = [[iSaveRepository sharedInstance] resultsForRequest:fetchRequest];
    if ([fetchResults count] == 1) {
        return [fetchResults objectAtIndex:0];
    }
    else if ([fetchResults count] > 1){
        [NSException raise:@"Invalid Data" format:@"More than one sale items returned"];
    }
    return nil;
}

+ (NSArray*)fetchArrayOfAllSaleItemsSortedByDescriptionForStore:(GroceryStore*)groceryStore{
    
    NSPredicate *filter = [NSPredicate predicateWithFormat:@"saleItemToStore == %@",groceryStore];
    NSFetchRequest *fetchRequest = [SaleItem fetchRequestForSaleItem];
    [fetchRequest setSortDescriptors:[SaleItem sortDescriptorsForSaleItem]];
    [fetchRequest setPredicate:filter];
    
    
    return [[iSaveRepository sharedInstance] resultsForRequest:fetchRequest];
}

+ (NSArray*)fetchArrayOfSortedCategoriesForStore:(GroceryStore*)groceryStore{
    
    NSArray *saleItems = [self fetchArrayOfAllSaleItemsSortedByDescriptionForStore:groceryStore];
    
    NSArray *categories = [[saleItems valueForKeyPath:@"@distinctUnionOfObjects.category"]sortedArrayUsingSelector:@selector(compare:)];
    return categories;
}

+ (NSFetchRequest*)fetchRequestForSaleItem{
    
    return [[iSaveRepository sharedInstance] fetchRequestForEntityNamed:[SaleItem className]];
}

+ (NSArray*)fetchArrayOfAllSaleItemsSortedByDescriptionForStore:(GroceryStore *)groceryStore inCategory:(NSString*)category{

    NSArray *saleItems = [[[self fetchArrayOfAllSaleItemsSortedByDescriptionForStore:groceryStore]filteredArrayUsingPredicate:[NSPredicate predicateWithFormat:@"category == %@",category]]sortedArrayUsingDescriptors:[self sortDescriptorsForSaleItem]];

    return saleItems;
}

+ (NSArray*)fetchArrayOfAllSaleItemsSortedByDescriptionForStore:(GroceryStore *)groceryStore inCategory:(NSString*)category containing:(NSString*)contains{
    
    
    NSArray *saleItems = [self fetchArrayOfAllSaleItemsSortedByDescriptionForStore:groceryStore];
    
    NSArray *temp = [saleItems filteredArrayUsingPredicate:[NSPredicate predicateWithFormat:@"SELF.itemDescription contains[c] %@", contains]];
    return temp;
}
@end
