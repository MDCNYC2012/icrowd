//
//  DataSource.h
//  CustomCell


#import <Foundation/Foundation.h>
#import <ShinobiGrids/ShinobiGrid.h>

@interface DataSource : NSObject <SGridDataSource>

@property (nonatomic, retain) NSMutableArray *reuseIdentifiers;

@end
