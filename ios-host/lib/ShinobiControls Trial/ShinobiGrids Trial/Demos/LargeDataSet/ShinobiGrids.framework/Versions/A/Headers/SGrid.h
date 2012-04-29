// SGrid.h
@protocol SGridDataSource;

#import <UIKit/UIKit.h>
#import "SGridRowStruct.h"

@class SGridCell;
@class SGridDataSource;
@class SGridDelegate;
@class SGridLineStyle;
@class SGridBorderStyle;
@class SGridColRowStyle;
@class SGridLayer;
@class SGridCoordMutable;
@class SGridSectionHeaderStyle;
@class SGridDataSourceDelegateManager;
@class SGridArrow;
@class SGridMultiTouchRecognizer;
@protocol SGridDelegate;

typedef enum SGridDraggingDecision {
    DragCols,
    DragRows,
    NoDecision
} SGridDraggingDecision; 

typedef enum {
    SGridLinesVerticalOnTop,
    SGridLinesHorizontalOnTop
} SGridLinesOnTop;

/** The ShinobiGrid class is intended for easy construction of a grid structure that is presented in columns, rows and sections, composed of cells, separated by gridlines, that display content to the user. Columns, rows and sections are zero-indexed, where the first column in a grid is at index 0, the first row in a section is at index 0 and the first section in the grid is at index 0. Cells can be located within a grid from their grid coordinate.
 
 Sections group rows horizontally and have section headers that allow the user to tap and collapse a section. The grid will have one section by default, but this can be altered by implementing the appropriate SGridDelegate method.
 
 A ShinobiGrid object can present content that is too large for its own frame by allowing for panning and scrolling. This behaviour is automatic where the content dimensions (total cell heights or widths) are greater than the grid's dimensions - no additional setup/calibration is required. The height of columns and width of rows will autocalculate by default - in order to stop this behaviour simply implement the appropriate style method from SGridDelegate or apply the appropriate default style on the grid itself (such as defaultRowStyle etc.).
 
 A ShinobiGrid object must have an associated object that acts as the data source (which must conform to the SGridDataSource protocol). The data source provides the necessary information to construct the grid, such as number of rows, sections and columns, and the content to be displayed within each cell. The data source concerns itself solely with the data model, and issues relating to the style of the grid are controlled through the delegate. 
 
 The delegate of the ShinobiGrid object must conform to the SGridDelegate protocol and can be used to provide styles for specific rows/columns/gridlines. Only provide a delegate for your ShinobiGrid object if you wish to provide a style for a specific element of the grid. If you wish to style the grid in a uniform manner (every gridline will be styled identically etc) then the properties such as defaultRowStyle, defaultColumnStyles and defaultGridLineStyle are designed for this purpose. As such it is not necessary for a ShinobiGrid to have a delegate. 
 
 ShinobiGrid uses cell pooling to make your grid as memory efficient as possible. Cells that are not currently visible are returned to an internal cell pool for later use and cells that become visible due to users scrolling/panning are retrieved from this pool. This means that ShinobiGrid caches cells only for visible rows and columns, but caches styling objects for the entire grid. For ShinobiGrid to be able to pool cells correctly it needs to know what the cells will be used for - this is where the dequeueReusableCellWithIdentifier: method is utilised. You should use a different `reuseIdentifier` for each distinct type of cell within your grid - for example if you have header cells and normal cells in your grid, you might use the identifiers `"HEADER"` and `"NORMAL"`. For code examples of using the identifiers see the ShinobiGrid sample apps.
 
 @warning *Important* The allocation/instantiation of cells must be done via the dequeueReusableCellWithIdentifier: method.*/

@interface ShinobiGrid : UIScrollView <UIScrollViewDelegate> {
    
    SGridLineStyle               *defaultGridLineStyle;   
    SGridBorderStyle             *defaultBorderStyle;
    SGridColRowStyle             *defaultRowStyle;
    SGridColRowStyle             *defaultColumnStyle;
    BOOL                         rowStylesTakePriority;
    
    
@private
    SGridArrow     *arrows[4]; // up, down, left, right
    BOOL            needsDrawArrows;
    
    SGridDataSourceDelegateManager *dataSourceDelegateManager;
    
    UIView                       *masterContent;
    
    UIScrollView                 *scrollIndicatorLayer; //Transparent layer that has its content sized to mimic the other layers. Placed on top of other layers to keep a set of scroll indicators that are always on top.
    SGridLayer                   *liquidLayer; //this layer acts as the master layer
    //these layers mimic the master layer according to whichever directions they are not frozen in
    SGridLayer                   *verticallyFrozenLayer;
    SGridLayer                   *horizontallyFrozenLayer;
    SGridLayer                   *staticLayer;
    
    NSNumber                     *initialDefaultColWidth;
    NSNumber                     *initialDefaultRowHeight;
    BOOL                         weHaveSetCellFrames;
    BOOL                         userHasAlteredACellFrame;
    BOOL                         userSetDefaultColStyle;
    BOOL                         userSetDefaultRowStyle;
    BOOL                         keyBoardIsShowing;
    BOOL                         respondingToDoubleTap;

    NSMutableDictionary          *verticalCompositeGridLines;
    NSMutableDictionary          *horizontalCompositeGridLines;
    
    SGridRow                     lastFrozenRow;
    int                          lastFrozenCol;
    
    SGridCell                    *selectedCell;
    
    SGridCoord                   *selectedCellGridCoord;
    
    UITapGestureRecognizer       *doubleTapToEdit;
    UITapGestureRecognizer       *singleTapToSelect;
    UILongPressGestureRecognizer *holdToReorder;
    SGridMultiTouchRecognizer    *resizeGesture;
    float                         cellReorderOffset; // don't snap the centre to the user's finger
    
    int                           colResizingIndex;
    BOOL                          colResizing;
    UIImageView                  *colResizingFloater;
    
    SGridCoordMutable            *draggingIndex;
    int                           sectionWaitingForExpand; // when we hover over a section header, remember the section we are expanding
    
    CGPoint                      positionToSnapDraggingCellsTo;
    CGPoint                      lastTouchPosition;
    BOOL                         reordering; //Needed for when deciding whether to deselect a cell
    BOOL                         userDragging; //YES when user is dragging a row/col - needed to decide when to set below flag. If the user is dragging a row and we enter the scrollViewDidScroll method, then we know that the below flag should be set to YES.
    BOOL                         scrollingWhilstDragging; //YES when scrolling animation and user is dragging row - needed so we know when it is ok to reposition row (we only want to reposition row when scrolling animation is done - this gives the 'bobbing' effect).
    SGridDraggingDecision        dragDecision;
    CGPoint                      lastContentOffset;
    
    NSMutableArray               *visibleRowIndexes;
    NSMutableArray               *visibleColIndexes;
    
    BOOL                          poolDequeCalled;

    void                         *_reserved;
}

#pragma mark -
#pragma mark Changing a ShinobiGrid's Default Styles
/** @name Changing a ShinobiGrid's Default Styles*/

/** This property is the default style that will be applied to all gridlines that belong this this ShinobiGrid object. 
 
 Any style applied to a gridline via the delegate object will take priority over this property.*/
@property (nonatomic, retain) SGridLineStyle       *defaultGridLineStyle;

/** This property represents the style that will be applied to this grid's content border. 
 
 The border belongs the the content of the grid and not the grid itself. If you wish to apply a border to the grid then this can be accomplished as with a regular UIView through the use of the `layer` property (as ShinobiGrid is a descendant of UIView).*/
@property (nonatomic, retain) SGridBorderStyle     *defaultBorderStyle;

/** This property represents the style that will be applied to all section headers in this grid. 
 
 To specify individual styles for each (or a particular) section header then see the `shinobiGrid:headerStyleForSectionAtIndex:` method of SGridDelegate. Note that a style specified with the delegate method will take priority over this property.*/
@property (nonatomic, retain) SGridSectionHeaderStyle *defaultSectionHeaderStyle;

/** This property sets a default row style that will be used in all rows in all sections in this grid. Use this property to quickly set a base row style for the grid. 
 
 This property will be overriden by any style that is more specific, such as styles assigned in the delegate methods or styles assigned when returning a cell in the datasource method.*/
@property (nonatomic, retain) SGridColRowStyle     *defaultRowStyle;

/** This property sets a default column style that will be used in all columns in this grid. Use this property to quickly set a base column style for the grid. 
 
 This property will be overriden by any style that is more specific, such as styles assigned in the delegate methods or styles assigned when returning a cell in the datasource method.*/
@property (nonatomic, retain) SGridColRowStyle     *defaultColumnStyle;

#pragma mark -
#pragma mark Configuring a ShinobiGrid
/** @name Configuring a ShinobiGrid*/

/** Returns a reusable ShinobiGrid cell object located by its identifier.*/
- (id) dequeueReusableCellWithIdentifier:(NSString *) identifier;

/** This boolean value dictates the course of action to take if conflicting row and column styles are found. If set to `YES`, then the row style will take priority over the column style. If set to `NO` then the oppostie is true. The default value is `NO` (column styles take priority by default). 
 
 If you set the row at index 0 to have a `backgroundColor` of red, and the column at index 0 to have a `backgroundColor` of blue, then the cell at `gridCoord` {0,0} is being told to have a `backgroundColor` of red and blue. Setting this property to YES in this instance would mean that the row style (red background) will be appled.*/
@property (nonatomic, assign) BOOL                 rowStylesTakePriority;

/** Controls the manner in which the gridlines are displayed in this grid. 
 
 If this property is set to `SGridLinesVerticalOnTop` then the vertical gridlines will be drawn over the top of the horizontal gridlines. The opposite is true if this property is set to `SGridLinesHorizontalOnTop`. */
@property (nonatomic, assign) SGridLinesOnTop      linesOnTop;

/** This method freezes all columns to the left of (and including) the column at index `colIndex`. Note that if a cell belongs to both a frozen row and frozen column that it will not be scrollable in any direction.
 
 @param colIndex The index of the column that should be frozen, along with all columns that have a column index less than `colIndex`. */
- (void)               freezeColsToTheLeftOfAndIncludingIndex:(int) colIndex;

/** This method freezes all rows above (and including) the supplied row. Note that if a cell belongs to both a frozen row and frozen column that it will not be scrollable in any direction.
 
 @param row The row that should be frozen, along with all rows that appear above it in the grid.*/
- (void)               freezeRowsAboveAndIncludingRow:(SGridRow) row;

/** Dictates whether this grid's columns can be resized or not. 
 
 If canResizeColumnsViaPinch is `YES`, then a user can pinch two columns to resize them. Default value is `NO`. 
 
 @warning *Important* Having this value set to `YES` means that the grid has an internal pinch gesture recogniser that is enabled. Setting this property to `NO` disables this gesture recogniser.
 */

@property (nonatomic, assign) BOOL                  canResizeColumnsViaPinch;

/** Dictates whether this grid can be single tapped or not.
 
 If canSelectViaSingleTap is `YES`, then a user can single tap grid cells and section headers. Tapping a cell triggers the shinobiGrid:willSelectCellAtCoord: delegate call. Tapping a section header collapses the section. Default value for this property is `YES`.
 
 @warning *Important* Having this value set to `YES` means that the grid has an internal single tap gesture recogniser that is enabled. Setting this property to `NO` disables this gesture recogniser.
 */

@property (nonatomic, assign) BOOL                  canSelectViaSingleTap;

/** Dictates whether this grid can be edited or not. 
 
 If canEditCellsViaDoubleTap is `YES`, then a user can double tap a cell to edit its contents. Default value is `NO`. 
 
 See the `shinobiGrid:didFinishEditingCell:` method of the SGridDelegate protocol for a means of intercepting user's changes to cell content.
 
 @warning *Important* Having this value set to `YES` means that the grid has an internal double tap gesture recogniser that is enabled. Setting this property to `NO` disables this gesture recogniser.
 */
@property (nonatomic, assign) BOOL                 canEditCellsViaDoubleTap;

#pragma mark -
#pragma mark Accessing Cells and Cell Visibility
/** @name Accessing Cells and Cell Visibility*/
/** Returns the cell that belongs to `colIndex` and `row`. Use this to retrieve a cell at a given coordinate.
 
@warning *Important* Note that this method will only retrieve cells that are currently visible in the grid. If an attempt is made to retrieve a cell that is outside the bounds of the grid, nil will be returned. 
 
 @param colIndex The index of the column that the cell should belong to.
 @param row The row that the cell should belong to.
 
 @return An object representing the cell at grid coordinate {`colIndex`, `row`}.*/
- (SGridCell *)        visibleCellAtCol:(int)colIndex andRow:(SGridRow)row;

/** Returns an `NSArray` of `NSNumber` objects. Each `NSNumber` object represents a currently visible `colIndex`. Use this function to query which columns are currently visible in the grid. */
- (NSArray *)          visibleColumnIndexes;

/** Returns an `NSArray` of `NSValue` objects. Each `NSValue` object represents a currently visible `row` - the `SGridRow` struct can be retrieved from an `NSValue` object by first providing a struct variable such as `SGridRow visibleRow`, and then using the `getValue:` method of the `NSValue` object like so - `[rowValueObject getValue:&visibleRow]`. Use this function to query which rows are currently visible within the grid.*/
- (NSArray *)          visibleRows;

#pragma mark -
#pragma mark Row Utility Functions
/** This function will return the next row down.
 
 @warning *Important* This function is purely a utility function and has no bounds checking in relation to the grid. If you ask it to return the next row down from the very last row in the grid, it will return what would be the next row down regardless of the fact that the returned row does not exist in the grid.
 
 @param rowToStepDownFrom The row that will be stepped down from in order to find the next row.
 @return The row resulting from incrementing `rowToStepDownFrom` by one place.*/
- (SGridRow) findRowAfterRow:(SGridRow) rowToStepDownFrom;

/** This function will return the next row up.
 
 @warning *Important* This function is purely a utility function and has no bounds checking in relation to the grid. If you ask it to return the next row up from the very first row in the grid, it will return what would be the next row up regardless of the fact that the returned row does not exist in the grid.
 
 @param rowToStepUpFrom The row that will be stepped up from in order to find the previous row.
 @return The row resulting from decrementing `rowToStepUpFrom` by one place.*/
- (SGridRow) findRowBeforeRow:(SGridRow) rowToStepUpFrom;

#pragma mark -
#pragma mark Drag and Drop
/** @name Dragging and Dropping Columns and Rows*/
/** A boolean that dictates whether the rows of this grid can be dragged and dropped by the user. 
 
 If set to YES then the user can touch and hold a cell to initiate the drag and drop of a row - the cell being touched and held will display a pulse animation to indicate it is ready for dragging.
 
 @warning *Important* ShinobiGrid has an internal long press gesture recogniser which is enabled if either this property or the canReorderColsViaLongPress property is set to YES. Setting both these properties to NO disables this gesture recogniser.*/
@property (nonatomic, assign) BOOL                 canReorderRowsViaLongPress;
/** A boolean that dictates whether the columns of this grid can be dragged and dropped by the user. 
 
 If set to YES then the user can touch and hold a cell to initiate the drag and drop of a column - the cell being touched and held will display a pulse animation to indicate it is ready for dragging.
 
 @warning *Important* ShinobiGrid has an internal long press gesture recogniser which is enabled if either this property or the canReorderRowsViaLongPress property is set to YES. Setting both these properties to NO disables this gesture recogniser.*/
@property (nonatomic, assign) BOOL                 canReorderColsViaLongPress;




#pragma mark -
#pragma mark Reloading the ShinobiGrid
/** Reloads this ShinobiGrid object.
 
 Use this method to reload all the data that is used to construct the grid.*/
- (void)               reload;

#pragma mark -
#pragma mark Sections

- (void) setSectionAtIndex:(NSUInteger)index asCollapsed:(BOOL)collapsed;
- (BOOL) sectionAtIndexIsCollapsed:(NSUInteger)index;

#pragma mark -
#pragma mark Delegate, Data Source and License Key
/** @name Managing the Delegate and Data Source*/
/** The object that acts as the data source for the receving ShinobiGrid object.
 
 The data source must adopt the SGridDataSource protocol. The data source is not retained.*/
@property (nonatomic, assign) id <SGridDataSource> dataSource;

/** The object that acts as the delegate of the receiving ShinobiGrid object.
 
 The delegate must adopt the SGridDelegate protocol. The delegate is not retained.*/
@property (nonatomic, assign) id <SGridDelegate>   delegate;

/** 
 The License Key for this Grid
 
 A valid license key must be set before the grid will render */
@property (nonatomic, assign) NSString *licenseKey;


#pragma mark -
#pragma mark Grid Version

/** @name Grid Version*/



/** @return An NSString describing the grid's version. */
+ (NSString *) getInfo;

/** @return An NSString describing the grid's version. */
- (NSString *) getInfo;

@end
