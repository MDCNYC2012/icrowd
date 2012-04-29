// SGridLineStyle.h
#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@class ShinobiGrid;

/** An object of type SGridLineStyle represents the style that is to be a applied to a gridline in a ShinobiGrid object. */

@interface SGridLineStyle : NSObject

#pragma mark -
#pragma mark Initializing
/** @name Initializing a SGridLineStyle Object*/
/** Creates and returns an object that represents the style of a gridline with default values.
 
 Default values are a width of `3.f` and a black color.*/
- (id) init;

/** Creates and returns an object that represents the style of a gridline with the supplied `newWidth` and `newColor` values.*/
- (id) initWithWidth:(float)newWidth withColor:(UIColor *)newColor;

#pragma mark -
#pragma mark Styling
/** Styling*/

/** The width in pixels of the gridline that has this style applied to it.
 The minimum width that can be displayed is 1.0f
 */
@property (nonatomic, assign) float    width;
/** The color of the gridline that has this style applied to it.*/
@property (nonatomic, retain) UIColor *color;

@end
