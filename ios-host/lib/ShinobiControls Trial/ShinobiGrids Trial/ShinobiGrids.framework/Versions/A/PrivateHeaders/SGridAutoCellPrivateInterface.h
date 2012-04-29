// SGridAutoCellPrivateInterface.h
#import "SGridAutoCell.h"

@interface SGridAutoCell (autocellhidden)

@property (nonatomic, assign) BOOL useOwnTextColor;
@property (nonatomic, assign) BOOL useOwnFont;

-(void) setDefaults;
- (void) commitChangesToDelegate;

@end
