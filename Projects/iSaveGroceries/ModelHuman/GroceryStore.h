#import "_GroceryStore.h"

@interface GroceryStore : _GroceryStore {}
// Custom logic goes here.

+ (NSArray *)sortDescriptorsForGroceryStores;
+ (BOOL)storeGroceryStoreFromArray:(NSArray*)groceryStoreArray location:(Location*)location;
+ (NSArray*)fetchArrayOfAllGroceryStoresSortedByName;
+ (NSFetchRequest*)fetchRequestForGroceryStores;
+ (NSFetchRequest*)fetchRequestForGroceryStoresStortedByName;
- (NSDate*)saleItemsExpireyDate;


@end
