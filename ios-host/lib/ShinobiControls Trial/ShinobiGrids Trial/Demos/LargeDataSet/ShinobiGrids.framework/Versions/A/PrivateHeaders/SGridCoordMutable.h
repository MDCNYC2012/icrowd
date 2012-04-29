// SGridCoordMutable.h
#import <Foundation/Foundation.h>
#import "SGridRowStruct.h"

/* A SGridCoord object represents the position of a given SGridCell object within the parent ShinobiGrid object.*/
@interface SGridCoordMutable : NSObject <NSCopying>{
}

/* Represents the column that the cell belongs to (the first column being 0).*/
@property (nonatomic, assign) int column;
/* Represents the row that the cell belongs to (the first row being at `index` 0 of `section` 0). */
@property (nonatomic, assign) SGridRow row;

#pragma mark -
#pragma mark Initialisation
/* Creates a SGridCoord object that is located at {colIndex, rowIndex} of the section at `sectionIndex`.*/
- (id) initWithColumn:(int)colIndex withRow:(SGridRow)rowIndex;

/* Returns YES if the parameter is of type SGridCoord and has column and row that matches the values of this SGridCoord.*/
- (BOOL) isEqual:(id)object;

/* Returns YES if the section number passed is equal to this this object's section property.*/
- (BOOL) hasSection:(int)sectionToCheck;
/* Returns YES if the column number passed is equal to this this object's column property.*/
- (BOOL) hasColumn:(int)colToCheck;
/* Returns YES if the row number passed is equal to this this object's row property.*/
- (BOOL) hasRow:(SGridRow)rowToCheck;
/* Returns YES if the column and row numbers passed are equal to this object's column and row properties.*/
- (BOOL) hasColumn:(int)colToCheck andRow:(SGridRow)rowToCheck;

/* Returns YES if `rowToCheck` is physically underneath the row that this grid coord represents.*/
- (BOOL) hasRowGreaterThanRow:(SGridRow) rowToCheck;
- (BOOL) hasRowLessThanRow:(SGridRow) rowToCheck;

@end
