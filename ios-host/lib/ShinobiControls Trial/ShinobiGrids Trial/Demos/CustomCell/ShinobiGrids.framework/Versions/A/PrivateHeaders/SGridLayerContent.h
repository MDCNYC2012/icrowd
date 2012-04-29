// SGridLayerContent.h
#import <UIKit/UIKit.h>
#import "ShinobiGrid.h"
#import "SGridSelectableElement.h"
#import "SGridMovableElement.h"

@class SGridLine;
@class SGridSection;

@interface SGridLayerContent : UIView {
}

@property (nonatomic, retain) SGridLayer            *owningLayer;
@property (nonatomic, assign) CGRect                 cellContainer;
@property (nonatomic, retain) NSMutableSet          *selectableGridElements;
@property (nonatomic, retain) SGridCell             *topLeftCell;
@property (nonatomic, retain) SGridCell             *bottomRightCell;
@property (nonatomic, retain) NSMutableDictionary   *sectionHeaders;

- (id)   initWithLayer:(SGridLayer *) theOwningLayer;
- (BOOL) containsElementForTouch:(UIGestureRecognizer *) touch;
- (void) addCell:(SGridCell *)cellToAdd;
- (void) removeCell:(SGridCell *) removeCell;
- (void) removeCells;
- (void) recalculateBoundingCells;
- (void) generateSectionHeadersForSection:(SGridSection *)section atOrigin:(float) yOrigin;
- (void) prepareForReload;

@end
