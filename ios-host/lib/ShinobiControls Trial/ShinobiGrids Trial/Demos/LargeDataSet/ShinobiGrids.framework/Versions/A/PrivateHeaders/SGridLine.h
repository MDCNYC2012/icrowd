// SGridLine.h
#import <UIKit/UIKit.h>
#import "SGridMovableElement.h"
#import "SGridOwnedElement.h"

@class SGridLineStyle;
@class ShinobiGrid;

@interface SGridLine : UIView <SGridMovableElement, SGridOwnedElement> {
    @private
    float          previousAlpha;
    BOOL           collapsed;
}

@property(nonatomic, retain) SGridLayer *owningLayer;
@property(nonatomic, retain) SGridLineStyle *style;
@property(nonatomic, assign) BOOL isVertical;

- (void) resetForReuse;
- (float)width;
- (BOOL) isVertical;
- (void) pulse;

@end
