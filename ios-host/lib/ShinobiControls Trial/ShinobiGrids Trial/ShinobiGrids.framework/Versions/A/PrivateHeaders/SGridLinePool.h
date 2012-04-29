// SGridLinePool.h
#import <Foundation/Foundation.h>
@class SGridLine;

@interface SGridLinePool : NSObject {
    @private
    NSMutableArray *subLinePool;
}

+ (SGridLine*) getSubGridLine;
+ (void) returnSubGridLine: (SGridLine*) lineToReturn;

@end
