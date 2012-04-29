// SGridColRowStylePrivateInterface.h
#import <Foundation/Foundation.h>

@interface SGridColRowStyle (hidden) 

//this interface is currently hidden from the user
//the checking of these ivars in layoutCells is therefore not actually needed - however this has been kept in in case we do want to open this up to the user at any point
- (BOOL) verticalFreeze;
- (void) setVerticalFreeze:(BOOL)freezeVertically;

- (BOOL) horizontalFreeze;
- (void) setHorizontalFreeze:(BOOL)freezeHorizontally;

@end
