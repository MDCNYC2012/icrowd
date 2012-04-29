// SGridCellPool.h
#import <Foundation/Foundation.h>

@class SGridCell;

@interface SGridCellPool : NSObject {
    NSMutableArray *sharedCells;
}

@property(nonatomic, retain) NSString *identifier;

+ (void) returnCell:(SGridCell *) cellToReturn;
+ (SGridCell *) getCellWithIdentifier:(NSString *) identifier;
+ (BOOL) containsObject:(SGridCell *) cellToTest;


@end
