// SGridDataSource.h
#import <UIKit/UIKit.h>
#import <Foundation/Foundation.h>

@class ShinobiGrid;
@class SGridCell;
@class SGridCoord;

/** The SGridDataSource protocol is adopted by an object that mediates the application's data model for a ShinobiGrid object. The datasource is responsible for providing the necessary information to construct a ShinobiGrid object - such as the number of rows/sections/columns and for returning appropriate cells for each coordinate in the grid.
 
 Information relating to the style and appearance of the ShinobiGrid is provided by the object that conforms to the SGridDelegate protocol. In this manner the data model and appearance of the grid are kept separate.
 
 ShinobiGrid uses cell pooling to make your grid as memory efficient as possible. Cells that are not currently visible are returned to an internal cell pool for later use and cells that become visible due to users scrolling/panning are retrieved from this pool. This means that ShinobiGrid caches cells only for visible rows and columns, but caches styling objects for the entire grid. For ShinobiGrid to be able to pool cells correctly it needs to know what the cells will be used for - this is where the dequeueReusableCellWithIdentifier: method is utilised. You should use a different `reuseIdentifier` for each distinct type of cell within your grid - for example if you have header cells and normal cells in your grid, you might use the identifiers `"HEADER"` and `"NORMAL"`. For code examples of using the identifiers see the ShinobiGrid sample apps.
 
 @warning *Important* The allocation/instantiation of cells must be done via the dequeueReusableCellWithIdentifier: method.*/
@protocol SGridDataSource <NSObject>

@required
#pragma mark -
#pragma mark Configuring a ShinobiGrid
/** @name Configuring a ShinobiGrid*/
/** Asks the data source for a cell to insert at a particular coordinate within the ShinobiGrid object. 
 
 `nil` can be returned if a cell is to be empty. For more information on providing content for a cell see the documentation on the SGridCell class.
 
 @param grid The grid that is requesting the cell.
 @param gridCoord Represents the column, row and section that the returned cell will belong to.
 
 @return The SGridCell object that you wish to appear at `gridCoord` of `grid`.
 
 @warning *Important* Cell frames are sized automatically and so any frame assigned to a cell will be ignored - specific columns and rows can be sized by implementing functions of the SGridDelegate protocol, or uniform cell sizes for the whole grid can be assigned through the `defaultRowStyle` and/or `defaultColumnStyle` properties of the ShinobiGrid object.
 
@warning *Important* The allocation/instantiation of cells must be done via the dequeueReusableCellWithIdentifier: method of ShinobiGrid.*/
- (SGridCell *)shinobiGrid:(ShinobiGrid *)grid cellForGridCoord:(const SGridCoord *) gridCoord;

/** Asks the data source to return the number of columns that the ShinobiGrid object should have.
 
 @param grid The grid that is requesting this information.
 @return The number of columns that `grid` will have.*/
- (NSUInteger)numberOfColsForShinobiGrid:(ShinobiGrid *)grid;

/** Asks the data source to return the number of rows that the a particular section within the ShinobiGrid object should have.
 
 @param grid The grid that contains the section that is requesting the information.
 @param sectionIndex The index of the section that will have the number of rows returned.
 
 @return The number of rows that the specified section will have within the grid.*/
- (NSUInteger)shinobiGrid:(ShinobiGrid *) grid numberOfRowsInSection:(int) sectionIndex;

@optional

/** Asks the data source to return the number of sections that the ShinobiGrid object should have.
 
 This data source method is optional - if this method is not implemented the grid will have 1 section by default.
 
 @param grid The grid that is requesting this information.
 
 @return The number of sections that `grid` will have.*/
- (NSUInteger) numberOfSectionsInShinobiGrid:(ShinobiGrid *) grid;

/** Asks the data source for the title of the movable portion of header of the specified section of the ShinobiGrid object.
 If you do not implement this method, a default title such as "Section 1" will be used. Returning nil will result in the specified section having a blank header.
 @warning *Important* Implementing shinobiGrid:viewForHeaderInSection:inFrame: overrides this method
 */
- (NSString *)shinobiGrid:(ShinobiGrid *)grid titleForHeaderInSection:(int)section;

/** Asks the data source for the title of the frozen portion of the header of the specified section of the ShinobiGrid object.
 If you do not implement this method a default title will be used. Returning nil will result in the specified section having a blank frozen header.
 @warning *Important* Implementing shinobiGrid:viewForFrozenHeaderInSection:inFrame: overrides this method
 */
- (NSString *)shinobiGrid:(ShinobiGrid *)grid titleForFrozenHeaderInSection:(int)section;

/** Asks the data source for a view for the movable portion of header of the specified section of the ShinobiGrid object.
 If you do not implement this method, the shinobiGrid:titleForHeaderInSection: delegate method is used as a fallback.
 Returning nil will also cause the title method to be used.
 The frame parameter specifies the header's bounds, which you can use to size your view appropriately
 */
- (UIView *)shinobiGrid:(ShinobiGrid *)grid viewForHeaderInSection:(int)section inFrame:(CGRect)frame;

/** Asks the data source for a view for the frozen portion of header of the specified section of the ShinobiGrid object.
 If you do not implement this method, the shinobiGrid:titleForFrozenHeaderInSection: delegate method is used as a fallback.
 Returning nil will also cause the title method to be used.
 The frame parameter specifies the header's bounds, which you can use to size your view appropriately.
 */
- (UIView *)shinobiGrid:(ShinobiGrid *)grid viewForFrozenHeaderInSection:(int)section inFrame:(CGRect)frame;

@end
