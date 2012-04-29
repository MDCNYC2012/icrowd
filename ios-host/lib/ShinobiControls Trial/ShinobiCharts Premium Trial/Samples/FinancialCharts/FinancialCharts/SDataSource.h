//
//  VBDataSource.h
//
//  Copyright 2012 Scott Logic Ltd. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <ShinobiCharts/ShinobiChart.h>

@interface SDataSource : NSObject <SChartDatasource> {
    // Charts that use this data source
    NSMutableArray          *charts;

    //y values
    NSMutableArray          *seriesOpen;
    NSMutableArray          *seriesHigh;
    NSMutableArray          *seriesLow;
    NSMutableArray          *seriesClose;
    
    //x values
    NSMutableArray          *dateAxisArray;
    
}

-(void)addChart:(ShinobiChart *)chart;

@end
