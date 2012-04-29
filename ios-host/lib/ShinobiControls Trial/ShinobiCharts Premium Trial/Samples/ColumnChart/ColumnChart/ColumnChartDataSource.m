//
//  ColumnChartDataSource.m
//  ColumnChart
//
//  Copyright 2011 Scott Logic Ltd. All rights reserved.
//

#import "ColumnChartDataSource.h"

@implementation ColumnChartDataSource

- (id)init
{
    self = [super init];
    if (self) {
        // Initialization code here.
    }
    
    return self;
}

-(void)toggleStackingMode {
    stackingColumnsMode = !stackingColumnsMode;
}

#pragma mark -
#pragma mark Datasource Protocol Functions

//Returns the number of points for a specific series in the specified chart
- (int)sChart:(ShinobiChart *)chart numberOfDataPointsForSeriesAtIndex:(int)seriesIndex {
    //In our example all series have the same number of points
    return 20;
}

//Returns the series at the specified index for a given chart
-(SChartSeries *)sChart:(ShinobiChart *)chart seriesAtIndex:(int)index {
    
    //In our example all series are column series.
    SChartColumnSeries *columnSeries = [[[SChartColumnSeries alloc] init] autorelease];
    
    if (stackingColumnsMode) {
        // Stack column series 0+2 and 1+3 together.
        columnSeries.stackIndex = [NSNumber numberWithInt: index%2];
    }
    
    columnSeries.animated = YES;
    columnSeries.animationCurve = SChartAnimationCurveBounce;
    columnSeries.animationDuration = 1.f;
    
    // Columns draw down to 0
    columnSeries.baseline = [NSNumber numberWithInt: 0];
    
    //Configure the series
    columnSeries.title = [NSString stringWithFormat:@"Column #%d", index+1];
    
    columnSeries.crosshairEnabled = YES; //Allows crosshair to track the series
    
    //Sets the selection mode for the series - this can be None, Series or Point.
    //None:   Series cannot be selected
    //Series: The full series is selected upon tapping on / near the series
    //Point:  An individual point in the series is selected upon tapping on / near the point
    columnSeries.selectionMode = SChartSelectionSeries;
    
    return columnSeries;
}

//Returns the number of series in the specified chart
- (int)numberOfSeriesInSChart:(ShinobiChart *)chart {
    return 4;
}

//Returns the data point at the specified index for the given series/chart.
- (id<SChartData>)sChart:(ShinobiChart *)chart dataPointAtIndex:(int)dataIndex forSeriesAtIndex:(int)seriesIndex {
    
    //Construct a data point to return
    SChartDataPoint *datapoint = [[[SChartDataPoint alloc] init] autorelease];
    
    // Set the x value
    datapoint.xValue = [NSNumber numberWithInt: dataIndex];
    
    // Set the y value
    datapoint.yValue = [NSNumber numberWithInt: (5 + (1+seriesIndex)*dataIndex - (seriesIndex%2)*dataIndex) * ((seriesIndex%2)? 1:-1)];
    
    return datapoint;
}

@end
