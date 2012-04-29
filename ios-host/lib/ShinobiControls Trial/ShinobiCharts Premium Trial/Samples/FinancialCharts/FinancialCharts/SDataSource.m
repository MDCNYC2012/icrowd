//
//  VBDataSource.m
//
//  Created by on 16/04/2012.
//  Copyright 2012 Scott Logic Ltd. All rights reserved.
//

#import "SDataSource.h"

#define NUM_DATA_FIELDS 7

@implementation SDataSource

- (NSDate *)dateFromString:(NSString *)str
{
    // Create an NSDate from the given string
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
        NSArray *rawData;
        
        // Load the Historic Dow Jones data
        NSString *path = [[NSBundle mainBundle] pathForResource:@"DJ" ofType:@"plist"];
        if ([[NSFileManager defaultManager] fileExistsAtPath:path]) {
            rawData =[[NSMutableArray alloc] initWithContentsOfFile:path];
        }
        
        // setup OHLC data
        seriesOpen = [[NSMutableArray alloc] init];
        seriesHigh = [[NSMutableArray alloc] init];
        seriesLow = [[NSMutableArray alloc] init];
        seriesClose = [[NSMutableArray alloc] init];
        dateAxisArray = [[NSMutableArray alloc] init];
        
        for (int i = 0; i < [rawData count]; i += NUM_DATA_FIELDS) {
            // read in date axis
            NSString * dateString = [rawData objectAtIndex:i];
            NSDate *date = [self dateFromString:dateString];
            [dateAxisArray addObject:date];
            
            // read in data series
            [seriesOpen addObject:[rawData objectAtIndex:(i + 1)]];
            [seriesHigh addObject:[rawData objectAtIndex:(i + 2)]];
            [seriesLow addObject:[rawData objectAtIndex:(i + 3)]];
            [seriesClose addObject:[rawData objectAtIndex:(i + 4)]];
        }
        
        charts = [[NSMutableArray alloc] init];
    }
    
    return self;
}

-(void)addChart:(ShinobiChart *)chart {
    [charts addObject:chart];
}

#pragma mark Datasource Protocol Functions
- (int)numberOfSeriesInSChart:(ShinobiChart*)chart {
    return 1;
}

- (int)getChartIndex:(ShinobiChart*)chart {
    // Find the chart index
    for (int i = 0; i < charts.count; ++i) {
        ShinobiChart *c = [charts objectAtIndex:i];
        if (c == chart) {
            return i;
        }
    }
    return -1;
}

- (SChartSeries *)sChart:(ShinobiChart*)chart seriesAtIndex:(int)index {
    
    int chartIndex = [self getChartIndex:chart];
    
    if (chartIndex == 0) {
        // Create a candlestick series
        SChartCandlestickSeries *candleSeries = [[[SChartCandlestickSeries alloc] init] autorelease];
        
        // Define the data field names
        NSMutableArray *keys = [[NSMutableArray alloc] initWithObjects:@"Open",@"High", @"Low", @"Close", nil];
        candleSeries.dataSeries.yValueKeys = keys;
        [keys release];
        
        candleSeries.crosshairEnabled = YES;
        candleSeries.title = @"DJI Average";
        
        return candleSeries;
    } else if (chartIndex == 1) {
        // Create an OHLC series
        SChartOHLCSeries *ohlcSeries = [[[SChartOHLCSeries alloc] init] autorelease];
        
        // Define the data field names
        NSMutableArray *keys = [[NSMutableArray alloc] initWithObjects:@"Open",@"High", @"Low", @"Close", nil];
        ohlcSeries.dataSeries.yValueKeys = keys;
        [keys release];
        
        ohlcSeries.crosshairEnabled = YES; 
        ohlcSeries.title = @"DJI Average";
        
        return ohlcSeries;
    } else if (chartIndex == 2) {
        // Create a Band series
        SChartBandSeries *bandSeries = [[[SChartBandSeries alloc] init] autorelease];
        
        bandSeries.crosshairEnabled = YES;
        bandSeries.title = @"DJI Average";
        
        return bandSeries;
    }
    
    return nil;
}

- (int)sChart:(ShinobiChart*)chart numberOfDataPointsForSeriesAtIndex:(int)seriesIndex {
    return [seriesOpen count] * 0.95f;
}

- (id<SChartData>)sChart:(ShinobiChart*)chart dataPointAtIndex:(int)dataIndex forSeriesAtIndex:(int)seriesIndex {
    
    int chartIndex = [self getChartIndex:chart];
    
    // Use a multi y datapoint
    SChartMultiYDataPoint *dp = [[[SChartMultiYDataPoint alloc] init] autorelease];
    
    // Set the xValue (date)
    dp.xValue = [dateAxisArray objectAtIndex: dataIndex];
    
    // Get the open, high, low, close values
    NSMutableDictionary *ohlcData = [[NSMutableDictionary alloc] init];
    float openVal  = [[seriesOpen  objectAtIndex: dataIndex] floatValue];
    float highVal  = [[seriesHigh  objectAtIndex: dataIndex] floatValue];
    float lowVal   = [[seriesLow   objectAtIndex: dataIndex] floatValue];
    float closeVal = [[seriesClose objectAtIndex: dataIndex] floatValue];
    
    // Clamp values
    openVal  = (openVal  < 0.0f ? 0.0f : openVal);
    highVal  = (highVal  < 0.0f ? 0.0f : highVal);
    lowVal   = (lowVal   < 0.0f ? 0.0f : lowVal);
    closeVal = (closeVal < 0.0f ? 0.0f : closeVal);
    
    // Set the OHLC values
    if (chartIndex < 2) {
        // Candlestick or OHLC chart
        [ohlcData setValue:[NSNumber numberWithFloat:openVal]  forKey:@"Open"];
        [ohlcData setValue:[NSNumber numberWithFloat:highVal]  forKey:@"High"];
        [ohlcData setValue:[NSNumber numberWithFloat:lowVal]   forKey:@"Low"];
        [ohlcData setValue:[NSNumber numberWithFloat:closeVal] forKey:@"Close"];
    } else {
        // Band chart
        [ohlcData setValue:[NSNumber numberWithFloat:closeVal] forKey:@"High"];
        [ohlcData setValue:[NSNumber numberWithFloat:openVal]  forKey:@"Low"];
    }
    dp.yValues = ohlcData;
    
    [ohlcData release];
    return dp;
}

-(void)dealloc {
    [charts release];
    [seriesOpen release];
    [seriesHigh release];
    [seriesLow release];
    [seriesClose release];
    [dateAxisArray release];
    [super dealloc];
}

@end
