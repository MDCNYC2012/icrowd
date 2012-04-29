// SGridMovableElement.h
#import <Foundation/Foundation.h>

@class SGridLayerContent;
@class SGridLayer;
@class ShinobiGrid;

@protocol SGridMovableElement <NSObject>

@property (nonatomic, assign, getter = isCollapsed) BOOL    collapsed;
@property (nonatomic, assign)                       CGPoint center;

- (void) adjustYPositionOfCentreBy:(NSNumber *) amountToAdjustBy;
- (void) removeFromContent;
- (void) bringToFront;
- (void) sendToBack;

@end
