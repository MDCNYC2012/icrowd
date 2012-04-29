//
//  ColumnChartDataSource.h
//  ColumnChart
//
//  Copyright 2011 Scott Logic Ltd. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <ShinobiCharts/ShinobiChart.h>

@interface ColumnChartDataSource : NSObject <SChartDatasource> {
    BOOL stackingColumnsMode;
}

-(void)toggleStackingMode;

@end
