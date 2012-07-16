
#import <Foundation/Foundation.h>
#import <QuartzCore/QuartzCore.h>

@class TreatmentTrack;

@interface VHHStyleSheet : NSObject {}

+ (UIColor*)defaultBackgroundTexture;
+ (UIColor*)defaultTextColor;
+ (UIColor*)defaultLabelTextColor;
+ (UIColor*)lightBackgroundTexture;
/** Colors for disabled things */

+ (UIColor*)disabledBackgroundColor;
+ (UIColor*)disabledTextColor;

+ (UIColor*)defaultBackgroundColorForErrorCondition;
+ (UIColor*)defaultBackgroundColorForWarningCondition;
+ (UIColor*)defaultBackgroundColorForInformationCondition;
+ (UIColor*)defaultBackgroundColorForVerboseCondition;
+ (UIColor*)defaultBackgroundColorForPerformanceEntry;

+ (UIColor*)backgroundColorForDisciplineCode:(NSString *)disciplineCode;
+ (UIColor*)labelColorForDisciplineCode:(NSString *)disciplineCode;
+ (UIColor*)darkBackgroundColorForDisciplineCode:(NSString *)disciplineCode;
+ (UIColor*)lightBackgroundColorForDisciplineCode:(NSString *)disciplineCode;

+ (void)applyGrayGradientAppearanceToButton:(UIButton *)button;
+ (void)styleTableForContentList:(UITableView *)tableView;
+ (void)styleTableForMenuList:(UITableView *)tableView;
+ (void)applyDisciplineBackgroundGradientToView:(UIView *)view forDisciplineCode:(NSString *)disciplineCode;
+ (void)applyClearBackgroundToBasicCell:(UITableViewCell*)cell;

@end

