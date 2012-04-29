// SGridSectionHeader.h
#import <UIKit/UIKit.h>
#import "SGridMovableElement.h"
#import "SGridSelectableElement.h"
#import "SGridOwnedElement.h"

@class SGridSection;
@class SGridSectionHeaderStyle;

@interface SGridSectionHeader : UILabel <SGridSelectableElement, SGridMovableElement, SGridOwnedElement> {
    @private
    SGridLayer   *owningLayer;
    SGridSection *section;
    float          previousAlpha;
    BOOL           collapsed;
}

- (id)initWithLayer:(SGridLayer *) theOwningLayer withSection:(SGridSection *) aSection;

- (void) setView:(UIView *)view;

@end
