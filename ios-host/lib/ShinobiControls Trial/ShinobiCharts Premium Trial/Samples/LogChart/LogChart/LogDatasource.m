//
//  LogDatasource.m
//  LogChart
//
//  Copyright (c) 2012 Scott Logic Ltd. All rights reserved.
//

#import "LogDatasource.h"

@implementation LogDatasource

-(int)numberOfSeriesInSChart:(ShinobiChart *)chart {
    return 6;
}

-(SChartSeries *)sChart:(ShinobiChart *)chart seriesAtIndex:(int)index {
    
    SChartLineSeries *series = [[SChartLineSeries alloc] init];
    series.style.showFill = YES;
    series.baseline = [NSNumber numberWithInt: index];
    return series;
}

-(int)sChart:(ShinobiChart *)chart numberOfDataPointsForSeriesAtIndex:(int)seriesIndex {
    return 100;
}

-(id<SChartData>)sChart:(ShinobiChart *)chart dataPointAtIndex:(int)dataIndex forSeriesAtIndex:(int)seriesIndex {
    SChartDataPoint *dp = [[SChartDataPoint alloc] init];
    double val = 0.1f + dataIndex/10.f ;
    dp.xValue = [NSNumber numberWithDouble: val];
    dp.yValue = [NSNumber numberWithDouble: val*(1+seriesIndex)];
    return dp;
}

@end
