// SGridLineComposite.h
#import <UIKit/UIKit.h>
#import "SGridMovableElement.h"
#import "SGridMovableCompositeElement.h"
#import "SGridSelectableElement.h"

@class SGridLine;

@interface SGridLineComposite : SGridMovableCompositeElement <SGridMovableElement> {

}

- (void) removeSublinesFromSuperview;
- (void) prepareForReload;
- (SGridLine*) firstSubLine;
- (SGridLine*) lastSubLine;
- (SGridLine*) sublineAtVisibleIndex:(int) sublineVisibleIndex;
- (void) addNewLine:(SGridLine *)lineToAdd atVisibleIndex:(int) visibleIndex;
- (void) removeLineAtVisibleIndex:(int) visibleIndex deleteIndex:(BOOL) deleteIndex;

- (void) pulse;

@end
