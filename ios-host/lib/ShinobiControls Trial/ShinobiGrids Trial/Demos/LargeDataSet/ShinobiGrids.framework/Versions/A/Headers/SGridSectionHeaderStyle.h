// SGridSectionHeaderStyle.h
#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

/** A SGridSectionHeaderStyle object represents the style to be used for the header of a section.*/

@interface SGridSectionHeaderStyle : NSObject

/** @name Initializing a header style object.*/
/** Initialises a header style object with the defaults values; height of `50.f`, background color of `[UIColor scrollViewTexturedBackgroundColor]` and a text color of `[UIColor blackColor]`.*/
- (id) init;
/** Initialises with a header style with your specified parameters.*/
- (id) initWithHeight:(float) aHeight withBackgroundColor:(UIColor *) aBackgroundColor;
/** Initialises with a headr style with your specified parameters.*/
- (id) initWithHeight:(float)aHeight withBackgroundColor:(UIColor *)aBackgroundColor withHidden:(BOOL)isHidden;

/** @name Styling*/
/** This boolean property indicates whether the section header is to be shown or not. 
 
 If set to `YES` then the section at sectionIndex will have no header. Default value is `NO`.
 
 @warning *Important* A section requires a section header to be collapsable/expandable.*/
@property (nonatomic, assign) BOOL hidden;

/** This property represents the height that will be applied to the section header(s).*/
@property (nonatomic, assign) float height;
/** This property represents the background color that will be applied to te section header(s).*/
@property (nonatomic, retain) UIColor *backgroundColor;

/** This property represents the text color that will be applied to the section header(s). */
@property (nonatomic, retain) UIColor *textColor;

/** This property represents the font that will be applied to the section header(s).*/
@property (nonatomic, retain) UIFont *font;

@end
