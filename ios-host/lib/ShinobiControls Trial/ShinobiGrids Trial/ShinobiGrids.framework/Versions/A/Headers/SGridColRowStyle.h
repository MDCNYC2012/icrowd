// SGridColRowStyle.h
#import <UIKit/UIKit.h>
#import <Foundation/Foundation.h>

/** An object of type SGridColRowStyle represents a style that can be applied to an entire row or column.
 The methods `shinobiGrid:styleForRowAtIndex:inSection:` and `shinobiGrid:styleForColAtIndex:` of the object that implements the SGridDelegate protocol are
 intended to return objects of this type in order to apply a style to an entire row or column.
 
 Note that where there are style conflicts, the application of style occurs according to the level of specificity. 
 For example, if a cell is returned as having a blue background by applying this in the SGridDataSource protocol method `shinobiGrid:cellForGridCoord:` but we
 later specify that the row that the cell belongs to should have a red background (by implementing the SGridDelegate protocol), the cell will take on the most specific style.
 In this case we specify a row style and a cell style - therefore the most specific style is the cell style and so the cell in question will have a blue background.
 All other cells in the row will have a red background (unless a more specific style is applied elsewhere).
 
 Most specific to least specific, the styling order is:
 Giving a cell a background color itself (this cannot be done with size).
 A style returned from a delegate method is checked next. If nil, or a specific member of the style is nil, the following is checked:
 The `defaultColStyle` and `defaultRowStyle` properties on the grid object owning the cell.
 
 If no appropriate style is found, autosizing takes place.
*/

@interface SGridColRowStyle : NSObject <NSCopying> {
    BOOL    horizontalFreeze;
    BOOL    verticalFreeze;
}

#pragma mark -
#pragma mark Initialzation
/** @name Initializing a SGridColRowStyle Object*/
/** Creates and returns an object that represents the style of an entire row or column with default values. The size is nil by default, meaning that the default behaviour is for a SGridColRowStyle object to autocalculate its size.*/
- (id) init;

/** Creates and returns an object that represents the style of an entire row or column with the specified parameters.*/
- (id) initWithSize:(NSNumber *)newSize withBackgroundColor:(UIColor *) newBackgroundColor withTextColor: (UIColor *) newTextColor withFont:(UIFont *) newFont;


#pragma mark -
#pragma mark Styling
/** @name Styling*/

/** This property either represents the width of a column or the height of a row.
 
 Default value is nil. Having this set at nil results in auto-sizing of a cell's appropriate dimension. If auto-sizing is not desired then set this to be non-nil.
 A size of zero will mean that the column or row is not displayed.*/
@property (nonatomic, retain) NSNumber *size;
/** The background color that will be applied to every cell within the row or column.*/
@property (nonatomic, retain) UIColor *backgroundColor;
/** The color that will be applied to all text within every cell in the column or row.*/
@property (nonatomic, retain) UIColor *textColor;
/** The font that will be applied to all the text within every cell in the column or row.*/
@property (nonatomic, retain) UIFont  *font;

/** The default cell size.*/
+ (float) defaultSize;

@end
