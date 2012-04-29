//
//  LineChartViewController.h
//  LineChart
//
//  Copyright 2011 Scott Logic Ltd. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <ShinobiCharts/ShinobiChart.h>
#import "LineChartDataSource.h"

@interface LineChartViewController : UIViewController <SChartDelegate> {
    
    ShinobiChart            *chart;
    LineChartDataSource     *datasource;

    UISwitch                *stepSwitch;
    UILabel                 *stepLabel;
}

@end
