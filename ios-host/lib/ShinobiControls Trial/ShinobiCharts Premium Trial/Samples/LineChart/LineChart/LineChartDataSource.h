//
//  LineChartDataSource.h
//  LineChart
//
//  Copyright 2011 Scott Logic Ltd. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <ShinobiCharts/ShinobiChart.h>

@interface LineChartDataSource : NSObject <SChartDatasource> {
    NSCalendar *cal; //Calendar used for constructing date objects.
    BOOL stepLineMode;
}

@property (nonatomic, retain) NSMutableArray *series1Data, *series1Dates;

-(void)toggleSeriesType;

@end
