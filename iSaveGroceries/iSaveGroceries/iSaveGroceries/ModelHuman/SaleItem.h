#import "_SaleItem.h"

@interface SaleItem : _SaleItem {}
// Custom logic goes here.
+ (NSArray *)sortDescriptorsForSaleItem;
+ (NSArray *)sortDescriptorsForCategories;
+ (SaleItem*)fetchSaleItemForDescription:(NSString*)saleItemDescription;
+ (BOOL)storeSaleItemFromArray:(NSArray*)smartSourceSaleItemArray groceryStore:(GroceryStore*)groceryStore;
+ (SaleItem*)fetchSaleItemForDescription:(NSString*)saleItemDescription groceryStore:(GroceryStore*)groceryStore;
+ (NSArray*)fetchArrayOfAllSaleItemsSortedByDescriptionForStore:(GroceryStore*)groceryStore;
+ (NSArray*)fetchArrayOfSortedCategoriesForStore:(GroceryStore*)groceryStore;
+ (NSFetchRequest*)fetchRequestForSaleItem;
+ (NSArray*)fetchArrayOfAllSaleItemsSortedByDescriptionForStore:(GroceryStore *)groceryStore inCategory:(NSString*)category;
+ (NSArray *)sortDescriptorsForSaleEndDateAcending:(BOOL)acending;
+ (NSArray*)fetchArrayOfAllSaleItemsSortedByDescriptionForStore:(GroceryStore *)groceryStore inCategory:(NSString*)category containing:(NSString*)contains;
@end
