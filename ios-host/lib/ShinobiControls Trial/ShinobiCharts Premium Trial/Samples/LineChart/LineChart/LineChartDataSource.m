//
//  LineChartDataSource.m
//  LineChart
//
//  Copyright 2011 Scott Logic Ltd. All rights reserved.
//

#import "LineChartDataSource.h"

@implementation LineChartDataSource

@synthesize series1Data, series1Dates;

- (NSDate *)dateFromString:(NSString *)str
{
    static BOOL monthLookupTableInitialised = NO;
    static NSMutableArray *monthIdx;
    static NSArray *monthNames;
    static NSDictionary *months;
    
    if (!monthLookupTableInitialised) {
        monthIdx = [[NSMutableArray alloc] init ];
        for (int i = 1; i <= 12; ++i) {
            [monthIdx addObject:[NSNumber numberWithInt:i]];
        }
        
        monthNames = [[NSArray alloc] initWithObjects:@"Jan", @"Feb", @"Mar", @"Apr", @"May", @"Jun", @"Jul", @"Aug", @"Sep", @"Oct", @"Nov", @"Dec", nil];
        months = [[NSDictionary alloc] initWithObjects:monthIdx forKeys:monthNames];
        monthLookupTableInitialised = YES;
    }
    
    NSRange dayRange = NSMakeRange(0,2);
    NSString *dayString = [str substringWithRange:dayRange];
    NSUInteger day = [dayString intValue];
    
    NSRange monthRange = NSMakeRange(3, 3);
    NSString *monthString = [str substringWithRange:monthRange];
    NSUInteger month = [[months objectForKey:monthString] unsignedIntValue];
    
    NSRange yearRange = NSMakeRange(7, 4);
    NSString *yearString = [str substringWithRange:yearRange];
    NSUInteger year = [yearString intValue];
    
    NSDateComponents *components = [[NSDateComponents alloc] init];
    [components setDay:day];
    [components setMonth:month];
    [components setYear:year];
    
    NSCalendar *gregorian = [[NSCalendar alloc] initWithCalendarIdentifier:NSGregorianCalendar];
    NSDate *date = [gregorian dateFromComponents:components];
    
    [components release];
    [gregorian release];
    
    return date;
}


- (id)init
{
    self = [super init];
    if (self) {
        // Initialize the calendar
        cal = [[NSCalendar currentCalendar] retain];
        stepLineMode = NO;
        
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
    }
    
    return self;
}

- (void) dealloc {
	[cal release];
	[super dealloc];
}

-(void)toggleSeriesType {
    stepLineMode = !stepLineMode;
}

#pragma mark -
#pragma mark Datasource Protocol Functions

// Returns the number of points for a specific series in the specified chart
- (int)sChart:(ShinobiChart *)chart numberOfDataPointsForSeriesAtIndex:(int)seriesIndex {
    //In our example, all series have the same number of points
    return 3000;
}

// Returns the series at the specified index for a given chart
-(SChartSeries *)sChart:(ShinobiChart *)chart seriesAtIndex:(int)index {
    
    // Our series are either of type SChartLineSeries or SChartStepLineSeries depending on stepLineMode.
    SChartLineSeries *lineSeries = stepLineMode? 
                                    [[[SChartStepLineSeries alloc] init] autorelease]:
                                    [[[SChartLineSeries alloc] init] autorelease];
    
    lineSeries.style.lineWidth = [NSNumber numberWithInt: 2];
    
    lineSeries.style.lineColor = [UIColor colorWithRed:80.f/255.f green:151.f/255.f blue:0.f alpha:1.f];
    lineSeries.style.areaColor = [UIColor colorWithRed:90.f/255.f green:131.f/255.f blue:10.f/255.f alpha:1.f];
    
    lineSeries.style.lineColorBelowBaseline = [UIColor colorWithRed:227.f/255.f green:182.f/255.f blue:0.f alpha:1.f];
    lineSeries.style.areaColorBelowBaseline = [UIColor colorWithRed:150.f/255.f green:120.f/255.f blue:0.f alpha:1.f];
    
    lineSeries.baseline = [NSNumber numberWithInt:0];
    lineSeries.style.showFill = YES;
    
    lineSeries.crosshairEnabled = YES;
    
    return lineSeries;
}

// Returns the number of series in the specified chart
- (int)numberOfSeriesInSChart:(ShinobiChart *)chart {
    return 1;
}

// Returns the data point at the specified index for the given series/chart.
- (id<SChartData>)sChart:(ShinobiChart *)chart dataPointAtIndex:(int)dataIndex forSeriesAtIndex:(int)seriesIndex {
    
    // Construct a data point to return
    SChartDataPoint *datapoint = [[[SChartDataPoint alloc] init] autorelease];
    
    // For this example, we simply move one day forward for each dataIndex
    datapoint.xValue = [series1Dates objectAtIndex:dataIndex];
    
    // Construct an NSNumber for the yValue of the data point
    datapoint.yValue = [NSNumber numberWithFloat:[[series1Data objectAtIndex:dataIndex] floatValue] - 10000.f];
    
    return datapoint;
}

@end
