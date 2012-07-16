
#import <Foundation/Foundation.h>
#import <QuartzCore/QuartzCore.h>

@class TreatmentTrack;
@class SSBadgeView;
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

#pragma mark - Flexible Table view styles
+ (void)styleFlexibleHeaderView:(UIView*)view;
+ (void)styleFlexibleHeaderLastUpdatedLabel:(UILabel*)label;
+ (void)styleFlexibleHeaderStatusLabel:(UILabel*)label;
+ (void)styleFlexibleHeaderImageLayer:(CALayer*)layer frame:(CGRect)frame;

#pragma mark - SSBadge
+ (SSBadgeView*)basicBadgeView;
@end

