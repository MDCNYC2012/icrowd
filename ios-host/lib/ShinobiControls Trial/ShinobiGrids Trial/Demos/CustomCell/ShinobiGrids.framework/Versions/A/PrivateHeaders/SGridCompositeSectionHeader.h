// SGridCompositeSectionHeader.h
#import <Foundation/Foundation.h>
#import "SGridSelectableElement.h"
#import "SGridMovableElement.h"
#import "SGridMovableCompositeElement.h"

@class SGridSectionHeader;
@class SGridSection;

@interface SGridCompositeSectionHeader : SGridMovableCompositeElement {
    NSString *frozenTitle, *liquidTitle;
    UIView   *frozenView,  *liquidView;
    
    SGridSectionHeader *headers[2];
}

@property(nonatomic, retain) SGridSection *owningSection;
@property (nonatomic, retain) UILabel *textLabel;

- (void) addHeader:(SGridSectionHeader *) headerToAdd asFrozen:(BOOL)frozen;

- (void) setFrozenTitle:(NSString *)frozenTitle;
- (void) setLiquidTitle:(NSString *)liquidTitle;
- (void) setFrozenView:( UIView *)frozenUIView;
- (void) setLiquidView:( UIView *)liquidUIView;

- (float)height;

/* Returns the composite frame. Note that a composite header is not actually a UIView subclass and so this function is for convenience only.*/
- (CGRect) compositeFrame;

- (BOOL) hasAllSubheaders;

@end
