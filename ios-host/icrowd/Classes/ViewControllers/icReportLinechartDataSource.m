//
//  icReportLinechartDataSource.m
//  icReportLinechartDataSource
//
//  Copyright 2011 Scott Logic Ltd. All rights reserved.
//

#import "icReportLinechartDataSource.h"
#import "icDataManager.h"
#import "icGrain.h"
#import "icUser.h"

@implementation icReportLinechartDataSource

@synthesize series1Data, series1Dates;

- (id)init
{
    self = [super init];
    if (self) {
        
        // Initialize the calendar
        cal = [NSCalendar currentCalendar];
        stepLineMode = NO;
        
        /*
        NSArray *rawData;
        
        NSString *path = [[NSBundle mainBundle] pathForResource:@"DJ" ofType:@"plist"];
        if ([[NSFileManager defaultManager] fileExistsAtPath:path]) {
            rawData =[[NSMutableArray alloc] initWithContentsOfFile:path];
        }
        series1Data = [[NSMutableArray alloc] init];
        series1Dates = [[NSMutableArray alloc] init];
        
        for (int i = 0; i < [rawData count]; i += 7) {
            // read in date axis
            NSString * dateString = [rawData objectAtIndex:i];
            NSDate *date = [self dateFromString:dateString];
            [series1Dates addObject:date];
            
            // read in data series
            [series1Data addObject:[rawData objectAtIndex:(i + 1)]];
        }
         */
    }
    
    return self;
}

-(void)toggleSeriesType {
    stepLineMode = !stepLineMode;
}

#pragma mark -
#pragma mark Datasource Protocol Functions

// Returns the number of points for a specific series in the specified chart
- (int)sChart:(ShinobiChart *)chart numberOfDataPointsForSeriesAtIndex:(int)seriesIndex {
    // In our example, all series have the same number of points
    icUser * user = [[[icDataManager singleton] userArray] objectAtIndex:seriesIndex];
    // return count of grains for that user
    int grainCount = [user.grain count];
    return (grainCount>=1) ? grainCount : 0;
}

// Returns the series at the specified index for a given chart
-(SChartSeries *)sChart:(ShinobiChart *)chart seriesAtIndex:(int)index {
    
    // get user (1:1) per series
    icUser * user = [[[icDataManager singleton] userArray] objectAtIndex:index];
    
    // Our series are either of type SChartLineSeries or SChartStepLineSeries depending on stepLineMode.
    SChartLineSeries *lineSeries = stepLineMode? 
                                    [[SChartStepLineSeries alloc] init]:
                                    [[SChartLineSeries alloc] init];
    
    lineSeries.style.lineWidth = [NSNumber numberWithInt: 2];
    
    // FEMALE
    if ([user.gender isEqualToNumber:[[NSNumber alloc] initWithInt:1]]) {
        
        lineSeries.style.lineColor = [UIColor colorWithRed:120.f/255.f green:0.f/255.f blue:100.f alpha:1.f];
        lineSeries.style.areaColor = [UIColor colorWithRed:120.f/255.f green:0.f/255.f blue:100.f alpha:1.f]; 
        
        lineSeries.style.lineColorBelowBaseline = [UIColor colorWithRed:120.f/255.f green:0.f/255.f blue:100.f alpha:1.f];
        lineSeries.style.areaColorBelowBaseline = [UIColor colorWithRed:120.f/255.f green:0.f/255.f blue:100.f alpha:1.f];        

        // MALE
    } else {
        lineSeries.style.lineColor = [UIColor colorWithRed:0.f/255.f green:41.f/255.f blue:150.f alpha:1.f];
        lineSeries.style.areaColor = [UIColor colorWithRed:0.f/255.f green:41.f/255.f blue:150.f/255.f alpha:1.f];
        
        lineSeries.style.lineColorBelowBaseline = [UIColor colorWithRed:0.f/255.f green:41.f/255.f blue:150.f alpha:1.f];
        lineSeries.style.areaColorBelowBaseline = [UIColor colorWithRed:0.f/255.f green:41.f/255.f blue:150.f/255.f alpha:1.f];       
        
    }
    
    /*
    lineSeries.style.lineColor = [UIColor colorWithRed:80.f/255.f green:151.f/255.f blue:0.f alpha:1.f];
    lineSeries.style.areaColor = [UIColor colorWithRed:90.f/255.f green:131.f/255.f blue:10.f/255.f alpha:1.f];
    
    lineSeries.style.lineColorBelowBaseline = [UIColor colorWithRed:227.f/255.f green:182.f/255.f blue:0.f alpha:1.f];
    lineSeries.style.areaColorBelowBaseline = [UIColor colorWithRed:150.f/255.f green:120.f/255.f blue:0.f alpha:1.f];
     */
    
    lineSeries.baseline = [NSNumber numberWithInt:0];
    lineSeries.style.showFill = YES;
    
    lineSeries.crosshairEnabled = YES;
    
    return lineSeries;
}

// Returns the number of series in the specified chart
- (int)numberOfSeriesInSChart:(ShinobiChart *)chart {
    int seriesCount = [[[icDataManager singleton] userArray] count];
    return seriesCount ? seriesCount : 0;
}

// Returns the data point at the specified index for the given series/chart.
- (id<SChartData>)sChart:(ShinobiChart *)chart dataPointAtIndex:(int)dataIndex forSeriesAtIndex:(int)seriesIndex {
    
    // get user (1:1) per series
    icUser * user = [[[icDataManager singleton] userArray] objectAtIndex:seriesIndex];
    
    // get grain for data index of this user's grains
    icGrain * grain = [[[user.grain objectEnumerator] allObjects] objectAtIndex:dataIndex];
    
    // Construct a data point to return
    SChartDataPoint *datapoint = [[SChartDataPoint alloc] init];
    
    // For this example, we simply move one day forward for each dataIndex
    datapoint.xValue = grain.date;
    
    // Construct an NSNumber for the yValue of the data point
    datapoint.yValue = [NSNumber numberWithFloat:([grain.feeling floatValue] * [grain.intensity floatValue])];
    
    return datapoint;
}

@end
