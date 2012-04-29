// SGridOwnedElement.h
#import <Foundation/Foundation.h>

@protocol SGridOwnedElement <NSObject>

//every gridElement (gridLine, cell, section) should have a reference back to the content pane, layer and grid that it belongs to
- (SGridLayerContent *) owningContentPane;
- (SGridLayer *)        owningLayer;
- (ShinobiGrid *)       owningGrid;

@end
