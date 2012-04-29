// SGridMovableCompositeElement.h
#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import "SGridMovableElement.h"

@interface SGridMovableCompositeElement : UIView <SGridMovableElement> {
    NSMutableArray *subElements;
}

- (void) assertSubElementsNotNil;

@end
