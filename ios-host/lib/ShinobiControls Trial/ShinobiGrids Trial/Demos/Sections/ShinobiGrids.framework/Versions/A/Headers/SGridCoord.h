// SGridCoord.h
#import <Foundation/Foundation.h>
#import "SGridRowStruct.h"

@class SGridCoordMutable;

/** A SGridCoord object represents the position of a given SGridCell object within the parent ShinobiGrid object. 
 
 A grid coord is of the form {`colIndex`, `row`}, where `colIndex` is an `int` that represents the column of the coordinate and `row` is a `struct` that represents the row of the coordinate. This `struct` is of type `SGridRow` as follows:
        
        typedef struct {
            int index;
            int section;
        } SGridRow;
 
 The `SGridRow` type therefore represents a row in a grid by representing the section that the row belongs to and the index of the row within that section. 
 
 
 Columns, rows and sections are zero-indexed. For example the first (top left) cell of the grid will have a column of 0, row of 0 and a section of 0.*/
@interface SGridCoord: NSObject {
    @private
    SGridCoordMutable *mutableGridCoord;
}

#pragma mark -
#pragma mark Initialisation
/** @name Initializing a SGridCoord Object*/
/** Creates and returns a SGridCoord object that is located at {`colIndex`, `rowIndex`, `sectionIndex`}.
 
 @param colIndex The column that this grid coord will point to.
 @param row The row that this grid coord will point to (contains the section and row of that section).*/
- (id) initWithColumn:(int)colIndex withRow:(SGridRow)row;


#pragma mark -
#pragma mark Identifying and Comparing
/** @name Identifying and Comparing SGridCoord Objects*/
/** Returns `YES` if the parameter `object` is of type SGridCoord and has column and row properties that match the values of this SGridCoord object.
 
 @param object The object to test for equality with this SGridCoord object.
 @return `YES` if `object` is of type SGridCoord and has matching col, row and section values.*/
- (BOOL) isEqual:(id)object;

/** A convenienve method to allow for the identification of cells/gridcoors that reside within a particular section.
 
 @param sectionToCheck
 @return `YES` if `sectionIndex` is equal to this grid coord's section property.*/
- (BOOL) hasSection:(int)sectionToCheck; 

/** A convenience method to allow for the identification of cells/gridcoords that reside within a particular column.
 
 @param colToCheck The index of the column to be checked.
 @return `YES` if `colIndex` is equal to this this grid coord's column property*/
- (BOOL) hasColumn:(int)colToCheck;

/** A convenience method to allow for the identification of cells/gridcoords that reside within a particular row.
 
 @param rowToCheck The index of the row to be checked.
 @return `YES` if `rowIndex` is equal to this this object's row property*/
- (BOOL) hasRow:(SGridRow)rowToCheck;

/** A convenience method to allow for the identification of a cell/gridcoord at a particular column and row within a particular section.
 
 @param rowToCheck The row to be checked.
 @param colToCheck The index of the column to be checked.
 @return `YES` if `rowToCheck` and `colToCheck` are equal to this object's row and column properties.*/
- (BOOL) hasColumn:(int)colToCheck andRow:(SGridRow)rowToCheck;

/** A convenience method to allow for the identification of a cell/gridcoord that belongs to a particular row or column.
 
 @param rowToCheck The row to be checked.
 @param colToCheck The index of the column to be checked.
 @return `YES` if `rowToCheck` or `colToCheck` is equal to the correspoinding row or column property of this object.*/
- (BOOL) hasColumn:(int)colToCheck orRow:(SGridRow)rowToCheck;

/** A convenience method in order to check if this grid coord has a row that is greater (physically lower in the grid) that the parameter row.
 
 @param rowToCheck The row that this grid coord's row will be checked against.
 
 @return `YES` if `rowToCheck` is less than (physically higher in the grid) than this grid coords `row` property.*/
- (BOOL) hasRowGreaterThanRow:(SGridRow)rowToCheck;

/** Returns the index of the column that this grid coord object represents.*/
- (int) column;
/** Returns the struct of type Row that represents the index and section of the row that this grid coord represents.*/
- (SGridRow) row;
/** Returns the index of the row that this grid coord belongs to (note that this does not inform you of the section that the row belongs to).*/
- (int) rowIndex;
/** Returns the index of the section that this grid coord object belongs to.*/
- (int) section;

/** @name SGridRow convenience methods*/

/** This method allows for the easy construction of a SGridRow struct.
 
 @param rowIndex The index of the row within the section.
 @param sectionIndex The index of the section within the grid.
 
 @return The SGridRow struct that represents a row at `rowIndex` of `sectionIndex` within the grid.*/
SGridRow SGridRowMake (int rowIndex, int sectionIndex);

/** This method allows for the easy construction of a SGridRow struct that represents the first row of the first section.*/
extern const SGridRow SGridRowZero;

@end
