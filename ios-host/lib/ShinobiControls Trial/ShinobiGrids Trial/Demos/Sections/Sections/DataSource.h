//
//  DataSource.h
//  Sections
//
//  Copyright (c) 2012 Scott Logic Ltd. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <ShinobiGrids/ShinobiGrid.h>
#import "Stock.h"

@interface DataSource : NSObject <SGridDataSource> {
    NSMutableArray *risers;
    NSMutableArray *fallers;
}

@end
