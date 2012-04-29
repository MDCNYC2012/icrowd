//
//  LargeDataSetViewController.h
//  LargeDataSet
//
//  Copyright 2012 Scott Logic Ltd. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <ShinobiCharts/ShinobiChart.h>
#import "LargeDataSetDataSource.h"

@interface LargeDataSetViewController : UIViewController <SChartDelegate> {
    ShinobiChart *chart;
    
    // The data source for the chart
    LargeDataSetDataSource *datasource;
    
    
    // A switch to toggle box zoom mode
    UISwitch *boxZoomSwitch;
    
    // Whether or not box zoom mode is currently enabled
    BOOL boxZoomEnabled;
}

@end
