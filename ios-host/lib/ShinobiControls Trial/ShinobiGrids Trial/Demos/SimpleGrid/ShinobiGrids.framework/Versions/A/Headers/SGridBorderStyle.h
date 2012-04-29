// SGridBorderStyle.h
#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@class ShinobiGrid;

/** An object of this type represents the style of the border that will encompass the contents of the grid. Note that as ShinobiGrid is a descendant of UIView that a border round the grid (rather than the content of the grid) can be applied using the `layer` property.*/
@interface SGridBorderStyle : NSObject {
    @private
    ShinobiGrid *owningGrid;
}

#pragma mark -
#pragma mark Initializing a Border Style
/** @name Initializing a Border Style*/
/** Creates and returns a border style with default values. 
 
 Default values are a width of `5.f` and color set to `[UIColor blackColor]`.*/
- (id)init;
/** Creates and returns a border style with the specified `newWidth` and `newColor` parameters.*/
- (id) initWithWidth:(float)newWidth withColor:(UIColor *)newColor;

#pragma mark -
#pragma mark Styling
/** @name Styling*/

/** The width of the border that will be applied to the content of the grid.*/
@property (nonatomic, assign) float   width;
/** The color of the border that will be applied to the content of the grid.*/
@property (nonatomic, retain) UIColor *color;

@end
