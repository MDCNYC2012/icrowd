//
//  BarChartDataSource.m
//  BarChart
//
//  Copyright 2011 Scott Logic Ltd. All rights reserved.
//

#import "BarChartDataSource.h"

@implementation BarChartDataSource

- (id)init
{
    self = [super init];
    if (self) {
        // Initialization code here.
    }
    
    return self;
}

#pragma mark -
#pragma mark Datasource Protocol Functions

//Returns the number of points for a specific series in the specified chart
- (int)sChart:(ShinobiChart *)chart numberOfDataPointsForSeriesAtIndex:(int)seriesIndex {
    //In our example all series have the same number of points
    return 5;
}

//Returns the series at the specified index for a given chart
-(SChartSeries *)sChart:(ShinobiChart *)chart seriesAtIndex:(int)index {
    //In our example all series are bar series.
    SChartBarSeries *barSeries = [[[SChartBarSeries alloc] init] autorelease];
    
    //Configure the series
    barSeries.title = [NSString stringWithFormat:@"Bar #%d", index+1];
    
    barSeries.crosshairEnabled = YES; //Allows crosshair to track the series
    
    //The series will be animated from the baseline to their normal position when data is loaded/reloaded
    barSeries.animated = YES;
    //Animation duration in seconds
    barSeries.animationDuration = 0.7f;
    //Animation curve type
    barSeries.animationCurve = SChartAnimationCurveBounce;
    
    // Baseline for the bar series, bars will be filled down/up to this value
    barSeries.baseline = [NSNumber numberWithFloat:barBaseline];
    
    return barSeries;
}

//Returns the number of series in the specified chart
- (int)numberOfSeriesInSChart:(ShinobiChart *)chart {
    return 3;
}

//Returns the data point at the specified index for the given series/chart.
- (id<SChartData>)sChart:(ShinobiChart *)chart dataPointAtIndex:(int)dataIndex forSeriesAtIndex:(int)seriesIndex {
    
    //Construct a data point to return
    SChartDataPoint *datapoint = [[[SChartDataPoint alloc] init] autorelease];
    
    //The y axis is going to be a category axis, so set the y value
    //of the data point to a different string based on the data index
    datapoint.yValue = [NSString stringWithFormat:@"Label %d", dataIndex+1];
    
    //Set the x value to a random number between 0 and 10
    //    datapoint.xValue = [NSNumber numberWithDouble:arc4random() % 11];
    datapoint.xValue = [NSNumber numberWithFloat:seriesIndex + (float)dataIndex * 1.5];
    
    return datapoint;
}

@end
