//
//  PieChartDataSource.m
//  PieChart
//
//  Copyright 2012 Scott Logic Ltd. All rights reserved.
//

#import "PieChartDataSource.h"

@implementation PieChartDataSource

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

// Returns the number of points for a specific series in the specified chart
- (int)sChart:(ShinobiChart *)chart numberOfDataPointsForSeriesAtIndex:(int)seriesIndex {
    //In our example, all series have the same number of points
    return 6;
}

// Returns the series at the specified index for a given chart
-(SChartSeries *)sChart:(ShinobiChart *)chart seriesAtIndex:(int)index {
    //In our example we have either a pie series or a donut series at index 0, depending on the chart.
    SChartRadialSeries *radialSeries;
    
    // Return an appropriate subclass of SChartRadialSeries.
    if ([[chart title] isEqualToString:@"Pie Chart"]) {
        
        // Pie Chart
        SChartPieSeries *pieSeries = [[[SChartPieSeries alloc] init] autorelease];
        
        // Configure the series
        pieSeries.title = [NSString stringWithFormat:@"Pie Series"];
        pieSeries.style.showLabels = YES;
        pieSeries.style.chartEffect = SChartRadialChartEffectFlat;
        pieSeries.selectedStyle.chartEffect = SChartRadialChartEffectFlat;
        pieSeries.selectedStyle.labelFontColor = [UIColor blackColor];
        
        radialSeries = pieSeries;
        
    } else {
        
        // Donut Chart
        SChartDonutSeries *donutSeries = [[[SChartDonutSeries alloc] init] autorelease];
        
        // Configure the series
        donutSeries.title = [NSString stringWithFormat:@"Donut Series"];
        donutSeries.selectedStyle.labelFontColor = [UIColor blackColor];
        donutSeries.selectedPosition = [NSNumber numberWithInt: 0];
        
        radialSeries = donutSeries;
    }
    
    return radialSeries;
}

// Returns the number of series in the specified chart
- (int)numberOfSeriesInSChart:(ShinobiChart *)chart {
    return 1;
}

// Returns the data point at the specified index for the given series/chart.
- (id<SChartData>)sChart:(ShinobiChart *)chart dataPointAtIndex:(int)dataIndex forSeriesAtIndex:(int)seriesIndex {
    
    // Construct a data point to return
    SChartRadialDataPoint *datapoint = [[[SChartRadialDataPoint alloc] init] autorelease];
    
    // Give the data point a name
    datapoint.name = [NSString stringWithFormat:@"Data %d", dataIndex];
    
    // Give the data point a value
    datapoint.value = [NSNumber numberWithInt: 5+dataIndex];
    
    return datapoint;
}

@end

