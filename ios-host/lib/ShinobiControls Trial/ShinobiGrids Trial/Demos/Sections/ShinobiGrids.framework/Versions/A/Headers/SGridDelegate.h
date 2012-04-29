// SGridDelegate.h
#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import "SGridRowStruct.h"

typedef enum {
    SGridLineOrientationVertical,
    SGridLineOrientationHorizontal
} SGridLineOrientation;

@class ShinobiGrid;
@class SGridCell;
@class SGridAutoCell;
@class SGridLineStyle;
@class SGridColRowStyle;
@class SGridCoord;
@class SGridSectionHeaderStyle;

/** The delegate of a ShinobiGrid object must adopt the SGridDelegate protocol. The delegate concerns itself with the style of rows, columns and gridlines and can receive notifications that a cell is about to be selected (via a single tap) or that a cell has been edited (via a double-tap).
 
 The delegate should only be used for styling where you wish to provide a style for a particular row, column or gridline, or where each row/column/gridline is to have its own distinct style. If you wish to apply a uniform row/column/gridline style for the entire grid then the properites `defaultRowStyle`, `defaultColumnStyle` and `defaultGridLineStyle` of your ShinobiGrid object are designed for this purpose.
 
 @warning *Important* In certain cases row styles and column styles can conflict (a cell can belong to a row and column that have been given different styles). In this case the style is applied based on the `BOOL` `rowStylesTakePriority` property of the ShinobiGrid object.*/
@protocol SGridDelegate <UIScrollViewDelegate>

@optional
#pragma mark -
#pragma mark Columns and Row Styling
/** @name Styling Rows and Columns*/

/** Asks the delegate for the style to be used for a particular row within the ShinobiGrid object.
 
 Note that rows and sections are zero-indexed.
 
 @param grid The grid that is requesting the style.
 @param rowIndex The row within `grid` that is requesting the row style.
 @param sectionIndex The section that the row belongs to.
 
 @return The SGridColRowStyle object representing the style that will be applied to row at `rowIndex` of section at `sectionIndex` within `grid`.*/
- (SGridColRowStyle *)shinobiGrid:(ShinobiGrid *)grid styleForRowAtIndex:          (int)rowIndex inSection:(int) sectionIndex;

/** Asks the delegate for the style to be used for a particular column within the ShinobiGrid object.
 
 Note that columns are zero-indexed.
 
 @param grid The grid that is requesting the column style.
 @param colIndex The column within `grid` that is requesting the style.
 
 @return The SGridColRowStyle object representing the style that will be applied to column at `colIndex` within `grid`.*/
- (SGridColRowStyle *)shinobiGrid:(ShinobiGrid *)grid styleForColAtIndex:          (int)colIndex;




#pragma mark -
#pragma mark Gridline Styling
/** @name Styling Gridlines*/

/** Asks the delegate for the style to be used for a particular horizontal gridline within the ShinobiGrid object. 
 
 Gridlines are zero indexed - where the first horizontal grid line for a section appears underneath the first row of a section. Note that horizontal gridlines are zero-indexed within sections (that is to say that the first gridline in any section has a `gridLineIndex` of `0`). The last row of a section also has a gridline appear underneath it (unlike the last column of a grid). Returning `nil` for a particular gridline will result in the `defaultGridLineStyle` property of your ShinobiGrid object being applied.
 
 @param grid The grid that is requesting the horizontal gridline style.
 @param gridLineIndex The horizontal gridline for the section within `grid` that is requesting the style.
 @param sectionIndex The section that the horizontal gridline belongs to.
 
 @return The SGridLineStyle object representing the style that will be applied to the gridline at `gridLineIndex` with `orientation`.*/
- (SGridLineStyle *)  shinobiGrid:(ShinobiGrid *)grid     styleForHorizontalGridLineAtIndex: (int)gridLineIndex inSection:(int) sectionIndex;

/** Asks the delegate for the style to be used for a particular vertical gridline within the ShinobiGrid object. 
 
 Gridlines are zero indexed - where the first vertical grid line appears to the right of the first column of cells. Returning `nil` for a particular gridline will result in the `defaultGridLineStyle` property of your ShinobiGrid object being applied.
 
 @param grid The grid that is requesting the vertical gridline style.
 @param gridLineIndex The vertical gridline within `grid` that is requesting the style.
 
 @return The SGridLineStyle object representing the style that will be applied to the gridline at `gridLineIndex` with `orientation`.*/
- (SGridLineStyle *)  shinobiGrid:(ShinobiGrid *)grid     styleForVerticalGridLineAtIndex:   (int)gridLineIndex;


#pragma mark -
#pragma mark Sections
/** @name Asks the delegate for the style to be used for a particular sections header. 
 
 Use this method if you wish to specify different styles for each section header. If you wish to style all section headers uniformly then use the `defaultSectionHeaderStyle` property of your ShinobiGrid object. Section headers are zero-indexed.
 
 @param grid The grid which owns the section that is requesting the header style.
 @param sectionIndex The index of the section that is requesting the header style.
 
 @return An object representing the style that will be applied to the section at `sectionIndex` of `grid`.*/
- (SGridSectionHeaderStyle *)shinobiGrid:(ShinobiGrid *)grid styleForSectionHeaderAtIndex:(int) sectionIndex;

#pragma mark -
#pragma mark Section Notifications

/** @name Receiving Section Expand and Collapse Notifications*/

/** Tells the delegate that a section within the ShinobiGrid object is about to be expanded.
 
 @param grid The grid which contains the section that is about to expand.
 @param index The index of the section that is about to expand.
 */
- (void) shinobiGrid:(ShinobiGrid *)grid willExpandSectionAtIndex:(NSUInteger)sectionIndex;

/** Tells the delegate that a section within the ShinobiGrid object is about to be collapsed.
 
 @param grid The grid which contains the section that is about to collapse.
 @param index The index of the section that is about to collapse.
 */
- (void) shinobiGrid:(ShinobiGrid *)grid willCollapseSectionAtIndex:(NSUInteger)sectionIndex;

#pragma mark -
#pragma mark Selection/Editing Notifications
/** @name Receiving Cell Selection and Cell Editing Notifications*/
/** Tells the delegate that a cell within the ShinobiGrid object is about to be selected.
 
 This method gives the delegate an opportunity to apply a custom selection style/animation to the cell or another part of the grid.
 
 @param grid The grid which contains the cell that is about to be selected.
 @param gridCoord The coordinate of the cell that is about to be selected.
 
 @warning *Important* The default selection style will be applied to a cell unless the `selectionStyle` property of the SGridCell object is set to `SGridSelectionStyleNone` when you are returning the cell in your implementation of the SGridDataSource protocol.*/
- (void)                     shinobiGrid:(ShinobiGrid *)grid willSelectCellAtCoord:(const SGridCoord *) gridCoord;

/** Informs the delegate that a cell within the ShibiGrid object has been edited.
 
 This method gives the delegate an opportunity to feed back any changes that the user makes to the grid to the data source. Note that this delegate method only works in conjunction with SGridAutoCell (or its descendants).
 
 @param grid The grid which contains the cell that has been edited.
 @param cell The cell within `grid` that has been edited.*/
- (void)                     shinobiGrid:(ShinobiGrid *)grid didFinishEditingAutoCell: (const SGridAutoCell *) cell;

/** Informs the delegate that two columns within the ShinobiGrid object have been switched.
 
 This method gives the delegate an opportunity to update the data source appropriately.
 
 @param grid The grid that contains the columns that have been switched.
 @param colIndexSwitched The first switched column.
 @param colIndexSwitchedWith The second switched column.
 
 @warning *Important* When a user drags and drops a column this only reorders the currently visible cells. Therefore it is important to update your data source so that when scrolling/panning takes place, the cells that become visible appear in the correct order.*/

- (void)                     shinobiGrid:(ShinobiGrid *)grid colAtIndex:(int) colIndexSwitched hasBeenSwitchedWithColAtIndex:(int) colIndexSwitchedWith;

/** Informs the delegate that two rows within the ShinobiGrid object have been switched.
 
 This method gives the delegate an opportunity to update the data source appropriately.
 
 @param grid The grid that contains the columns that have been switched.
 @param rowSwitched The first switched row.
 @param rowSwitchedWith The second switched row.
 
 @warning *Important* When a user drags and drops a row this only reorders the currently visible cells. Therefore it is important to update your data source so that when scrolling/panning takes place, the cells that become visible appear in the correct order.*/
- (void)                     shinobiGrid:(ShinobiGrid *)grid row:       (SGridRow) rowSwitched hasBeenSwitchedWithRow:       (SGridRow) rowSwitchedWith;

@end
