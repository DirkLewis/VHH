#import "GroceryStore.h"
#import "SaleItem.h"
@implementation GroceryStore

// Custom logic goes here.
+ (NSArray *)sortDescriptorsForGroceryStores{
	return [NSArray arrayWithObjects:[[NSSortDescriptor alloc] initWithKey:@"groceryStoreName" ascending:YES],nil];
    
}

+ (BOOL)storeGroceryStoreFromArray:(NSArray*)groceryStoreArray location:(Location*)location{
    
    for (NSString *storeName in groceryStoreArray) {
        
        NSFetchRequest *fetchRequest = [GroceryStore fetchRequestForGroceryStores];
        
        NSPredicate *filter = [NSPredicate predicateWithFormat:@"groceryStoreName == %@ AND storeToLocation == %@",storeName,location];
        [fetchRequest setPredicate:filter];
        
        NSArray *fetchResults = [[iSaveRepository sharedInstance] resultsForRequest:fetchRequest];
        
        if ([fetchResults count] == 0) {
            //can save store to that location
            GroceryStore *store = [[iSaveRepository sharedInstance] insertNewEntityNamed:[GroceryStore className]];
            store.groceryStoreName = storeName;
            store.storeToLocation = location;
        }
        
    }
    return [[iSaveRepository sharedInstance] save];
    
}

+ (NSArray*)fetchArrayOfAllGroceryStoresSortedByName{
    
    NSFetchRequest *fetchRequest = [GroceryStore fetchRequestForGroceryStoresStortedByName];
    
    NSArray *fetchResults = [[iSaveRepository sharedInstance] resultsForRequest:fetchRequest];
    
    return fetchResults;
}

+ (NSFetchRequest*)fetchRequestForGroceryStoresStortedByName{
    
    NSFetchRequest *fetchRequest = [GroceryStore fetchRequestForGroceryStores];
    [fetchRequest setFetchBatchSize:20];
    [fetchRequest setSortDescriptors:[self sortDescriptorsForGroceryStores]];
    return fetchRequest;
}

+ (NSFetchRequest*)fetchRequestForGroceryStores{
    
    return [[iSaveRepository sharedInstance] fetchRequestForEntityNamed:[GroceryStore className]];
    
}

- (NSDate*)saleItemsExpireyDate{

    
    NSArray *saleItems = [[self.storeToSaleItem allObjects] sortedArrayUsingDescriptors:[SaleItem sortDescriptorsForSaleEndDateAcending:NO]];
    if ([saleItems count] > 0) {
        return [[saleItems objectAtIndex:0] saleEndDate];
    }
    
    return [NSDate date];
    
}

@end
