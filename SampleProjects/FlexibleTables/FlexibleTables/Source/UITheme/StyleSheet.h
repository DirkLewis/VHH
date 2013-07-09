
#import <Foundation/Foundation.h>
#import <QuartzCore/QuartzCore.h>

@class FlexibleUIButton;
@class TreatmentTrack;
@class SSBadgeView;

@interface StyleSheet : NSObject {}



/** Colors for the different Therapy Tracks */
+ (UIColor*)defaultTextColorForSTTrack;
+ (UIColor*)defaultTextColorForOTTrack;
+ (UIColor*)defaultTextColorForPTTrack;
+ (UIColor*)defaultTextColorForClosedTrack;

+ (UIColor*)defaultBackgroundColorForSTTrack;
+ (UIColor*)defaultBackgroundColorForOTTrack;
+ (UIColor*)defaultBackgroundColorForPTTrack;
+ (UIColor*)defaultBackgroundColorForClosedTrack;

+ (UIColor*)lightBackgroundColorForSTTrack;
+ (UIColor*)lightBackgroundColorForOTTrack;
+ (UIColor*)lightBackgroundColorForPTTrack;
+ (UIColor*)lightBackgroundColorForClosedTrack;

+ (UIColor*)darkBackgroundColorForSTTrack;
+ (UIColor*)darkBackgroundColorForOTTrack;
+ (UIColor*)darkBackgroundColorForPTTrack;
+ (UIColor*)darkBackgroundColorForClosedTrack;



+ (UIColor*)backgroundColorForDisciplineCode:(NSString *)disciplineCode;
+ (UIColor*)labelColorForDisciplineCode:(NSString *)disciplineCode;
+ (UIColor*)darkBackgroundColorForDisciplineCode:(NSString *)disciplineCode;
+ (UIColor*)lightBackgroundColorForDisciplineCode:(NSString *)disciplineCode;

+ (void)applyGrayGradientAppearanceToButton:(UIButton *)button;

/** Returns color for Document Status text */
+ (UIColor *)textColorForDocumentStatus:(NSString *)documentStatusCode;

/** Returns the icon image name for the document status */
+ (NSString *)documentIconNameForDocumentStatus: (NSString *)documentStatusCode;

/** Returns the icon image name for the provided payer type string */
+ (NSString *)payerTypeIconNameFor:(NSString *)payerType;
/** Returns a shared date formatter that is configured for the current thread **/
+ (NSDateFormatter *)dateFormatter;

/** Returns a gradent layer used on the left of track cards **/
+ (CAGradientLayer *)gradientLayerForDisciplineCode:(NSString *)disciplineCode withFrame:(CGRect)frame;

/** Returns a gradent layer used on the left of track cards suitable for a highlighted edge **/
+ (CAGradientLayer *)gradientHighlightLayerForDisciplineCode:(NSString *)disciplineCode withFrame:(CGRect)frame;

+ (CAGradientLayer *)gradientLayerForDisciplineWithStartColor:(UIColor *)startColor endColor:(UIColor *)endColor frame:(CGRect)frame;


+ (void)styleTableForContentList:(UITableView *)tableView;
+ (void)styleTableForMenuList:(UITableView *)tableView;
+ (void)applyDisciplineBackgroundGradientToView:(UIView *)view forDisciplineCode:(NSString *)disciplineCode;
+ (void)applyClearBackgroundToBasicCell:(UITableViewCell*)cell;





@end

