// SGridSelectableElement.h
#import <Foundation/Foundation.h>

@protocol SGridSelectableElement <NSObject>

@required
- (void) respondToSingleTap;
- (void) respondToDoubleTap; 
- (CGRect) frame;

@end
