// SGridBorderStylePrivate.h
#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@class ShinobiGrid;

@interface SGridBorderStyle (hidden)

//convenience method for when we create the grid's default border style
- (id)initWithGrid:(ShinobiGrid *) owningGrid;

- (void) setGrid:(ShinobiGrid *) newOwningGrid;

@end
