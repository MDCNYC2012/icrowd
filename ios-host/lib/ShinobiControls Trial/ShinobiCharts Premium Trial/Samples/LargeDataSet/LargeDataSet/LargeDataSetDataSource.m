//
//  LargeDataSetDataSource.m
//  LargeDataSet
//
//  Copyright 2012 Scott Logic Ltd. All rights reserved.
//

#import "LargeDataSetDataSource.h"

@implementation LargeDataSetDataSource

- (id)init
{
    self = [super init];
    if (self) {

    }
    
    return self;
}

#pragma mark -
#pragma mark Datasource Protocol Functions

//Returns the number of points for a specific series in the specified chart
- (int)sChart:(ShinobiChart *)chart numberOfDataPointsForSeriesAtIndex:(int)seriesIndex {
    //In our example, we have 10,000 points in our data series
    return 20000;
}

//Returns the series at the specified index for a given chart
-(SChartSeries *)sChart:(ShinobiChart *)chart seriesAtIndex:(int)index {
    
    //In our example all series are line series.
    SChartLineSeries *lineSeries = [[[SChartLineSeries alloc] init] autorelease];
    
    //Configure the series
    lineSeries.title = [NSString stringWithFormat:@"Large Data Series #%d", index+1];
    lineSeries.style.lineWidth = [NSNumber numberWithInt:2];
    lineSeries.crosshairEnabled = YES; //Allows crosshair to track the series
    
    //lineSeries.style.showFill = NO;
    
    //Sets the selection mode for the series - this can be None, Series or Point.
    //None:   Series cannot be selected
    //Series: The full line is selected upon tapping on / near the line
    //Point:  An individual point in the series is selected upon tapping on / near the point
    lineSeries.selectionMode = SChartSelectionPoint;
    
    return lineSeries;
}

//Returns the number of series in the specified chart
- (int)numberOfSeriesInSChart:(ShinobiChart *)chart {
    return 1;
}

//Returns the data point at the specified index for the given series/chart.
- (id<SChartData>)sChart:(ShinobiChart *)chart dataPointAtIndex:(int)dataIndex forSeriesAtIndex:(int)seriesIndex {
    
    //Construct a data point to return
    SChartDataPoint *datapoint = [[[SChartDataPoint alloc] init] autorelease];
    
    //For this example, we simply move forward by 1 for each dataIndex
    datapoint.xValue = [NSNumber numberWithInt: dataIndex];
    
    //Construct an NSNumber for the yValue of the data point
    datapoint.yValue = [NSNumber numberWithDouble: 200.f + (arc4random() % 101)];  // Random number between 200 and 300
    
    return datapoint;
}

@end

