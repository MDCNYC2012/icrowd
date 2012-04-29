//
//  PieChartViewController.h
//  PieChart
//
//  Created by Simon Withington on 11/01/2012.
//  Copyright 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <ShinobiCharts/ShinobiChart.h>
#import "PieChartDataSource.h"

@interface PieChartViewController : UIViewController {
    ShinobiChart *pieChart, *donutChart;
    
    // The datasource for the charts
    PieChartDataSource *datasource;
}

@end
