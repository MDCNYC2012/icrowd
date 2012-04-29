// SGridCellSubclass.h
#import <Foundation/Foundation.h>
#import "SGridCell.h"
#import "SGridSelectableElement.h"

@interface SGridCell (ForSubclass) <SGridSelectableElement>

- (void) respondToSingleTap;
- (void) respondToDoubleTap; 

@end
