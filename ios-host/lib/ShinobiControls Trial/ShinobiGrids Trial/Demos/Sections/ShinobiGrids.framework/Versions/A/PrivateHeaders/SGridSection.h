// SGridSection.h
#import <UIKit/UIKit.h>
#import "SGridMovableElement.h"
#import "SGridRowStruct.h"
#import "SGridDelegate.h"

@class SGridCell;
@class SGridCompositeSectionHeader;
@class SGridLineComposite;
@class SGridLine;
@class SGridColRowStyle;
@class SGridCoord;

@interface SGridSection : NSObject {
    @private
    ShinobiGrid         *owningGrid;
    int                  index;
    
    NSMutableArray      *visibleRows;
    
    int                  lastFrozenRow;
}

@property(nonatomic, readonly, getter = isCollapsed) BOOL collapsed;
@property(nonatomic, readonly)                       int  index;

//init
- (id)    initWithGrid:(ShinobiGrid *) theOwningGrid withIndex:(int) sectionIndex;

//dimensions
- (int)   numberOfCols;
- (int)   numberOfRows;
- (SGridRow) lastPossibleRowInSection;
- (float) loadRowStylesAndReturnSectionHeight;

/* Returns the total height of this current section - if the section is collapsed then the height of the header only will be returned, otherwise the height of all rows, headers and horizontal gridlines will be returned.*/
- (float) currentContentHeight;
- (float) expandedContentHeight;
- (float) sumOfRowHeights;
- (void) collectNumberOfUnspecifiedHeights: (int   *)numberOfUnspecifiedHeights
                      andSpecifiedHeights: (float *)sumOfSpecifiedHeights  
               andNumberOfSpecifiedHeights: (int   *)numberOfSpecifiedHeights;

//headers
@property (nonatomic, retain) SGridCompositeSectionHeader *header;

//collapse/expand
- (void) collapseOrExpand;
- (void) collapse;
- (void) expand;

//add/remove/get cells
- (void) addCell:(SGridCell *)cellToAdd;
- (void) replaceRow:(NSArray *) rowToReplace withRow:(NSArray *) replaceRowWith;
- (void) prepareForReload;
- (SGridCell *) visibleCellAtCol:(int) colIndex atRowIndex:(int) rowIndex;
- (int)  indexOfCellForThisSection:(SGridCell *) cellForIndex;
- (NSArray *) visibleCells;

//switching columns
- (void) switchDragginColWithColAtIndex:(int)colToSwitchWith 
         withNewOriginOfColToSwitchWith:(float) newOriginOfColToSwitchWith 
                       fromCurrentState:(BOOL) fromCurrentState;


- (BOOL) containsFrozenRows;

//add/remove/get gridlines
- (SGridLineStyle *) gridLineStyleHorizontalAtIndex:(int) gridLineIndex;

#pragma mark -
#pragma mark Methods for Managing Infinite Scrolling
- (NSArray*) getRow:(SGridRow)rowToGet;
- (void) removeRow:(SGridRow) rowToRemove;
- (void) removeColAtIndex: (int) colIndexToRemove;
- (void) sortVisibleRows;

@end
