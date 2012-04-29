// SGridCell.h
#import <UIKit/UIKit.h>


@class SGridCoord;
@class SGridLayer;

typedef enum {
    SGridCellSelectionStyleNone,
    SGridCellSelectionStyleDefault
} SGridCellSelectionStyle;

@class ShinobiGrid;

/** A SGridCell object is used to represent a cell within a ShinobiGrid and can be located within the grid via its gridCoord property. This class provides basic cell functionality such as cell selection and cell styling. This class is ideal if you want to provide custom content that the SGridAutoCell (and subclasses) are not suited for - as instances of this class have no automatic content, they are effective containers for other UIView objects (or descendants) that you may wish to add as subviews to the cell. SGridCell's use the reuseIdentifier property for performance reasons much in the same manner as the Cocoa framework's `UIScrollView` and `UITableViewCell` classes. For this reason it is important to ensure you make effective use of the reuseIdentifier for each different type of cell content you wish to display in the ShinobiGrid - see the included project samples for examples of the reuseIdentifer in use.*/

@interface SGridCell:UIView <NSCopying> {
    SGridCoord            *gridCoord;
    
    BOOL                  selected;
    
@private
    ShinobiGrid           *grid;
    SGridLayer            *owningLayer;
    BOOL                  horizontallyFrozen;
    BOOL                  verticallyFrozen;
    
    BOOL                  beingDragged;
    
    BOOL                  userAddedSubview;
    BOOL                  useOwnBackgroundColor;
    
    float                 previousAlpha;
    BOOL                  collapsed;
}


#pragma mark -
#pragma mark Initialization

/** Initializes a cell with a reuse identifier and returns it to the caller.
 @warning *Important* This method must be used to initialize a cell - using `init` or `initWithFrame` is not permitted.*/
- (id) initWithReuseIdentifier:(NSString *) identifier;


#pragma mark -
#pragma mark Styling
/** @name Styling a ShinobiGrid Object */

#pragma mark -
#pragma mark Cell Content
/** @name Providing Cell Content */

/** Setting this property to `YES` results in any added subviews having dimensions automatically applied so that they are the same size as the cell. Default value is `YES`.*/
@property (nonatomic, assign) BOOL              fitSubviewsToView;

/** A string used to identify a cell that is reusable. (read-only)
 
 The reuse identifier is associated with a SGridCell object that the ShinobiGrid's data source creates with the intent to reuse it as the basis (for performance reasons) for multiple cells of a ShinobiGrid object. It is assigned to the cell object in initWithReuseIdentifier: and cannot be changed thereafter. A ShinobiGrid object maintains a collection of the currently reusable cells, each with its own reuse identifier, and makes them available to the data source in the dequeueReusableCellWithIdentifier: method.*/
@property (nonatomic, readonly) NSString *reuseIdentifier;





#pragma mark -
#pragma mark Cell Location
/** @name Cell Location */


/** This property represents the coordinates of the cell and uniquely identifies it within its parent grid.
 
 The notation {`colIndex`, `row`}, is sometimes used to refer to a gridCoord object within this documentation.*/
@property (nonatomic, retain, readonly) SGridCoord *gridCoord;

#pragma mark -
#pragma mark Selection Color
/** The color that the cell will change to when selected. 
 
 Seting this property to `nil` will result in a selection color that is identical to the cell's final background color.*/
@property (nonatomic, retain) UIColor               *selectedColor;

@end
