//
//  DataSource.h
//  SimpleGrid
//
//  Copyright (c) 2012 Scott Logic Ltd. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <ShinobiGrids/ShinobiGrid.h>

@interface DataSource : NSObject <SGridDataSource> {
    NSMutableArray *countries;
}

@end
