// SGridArrow.h
typedef enum {
    SGridArrowOrientationUp,
    SGridArrowOrientationDown,
    SGridArrowOrientationLeft,
    SGridArrowOrientationRight,
} SGridArrowOrientation;

@interface SGridArrow : UIImageView {
    SGridArrowOrientation orientation;
    CGPoint futureCenter;
	CGSize cellSize;
}

- (id) initWithOrientation:(SGridArrowOrientation)orientation;

- (void) addToCell:(SGridCell *)cell;

- (void) pulse;
- (void) fadeIn;
- (void) fadeOut;

@end
