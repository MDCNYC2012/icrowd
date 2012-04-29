//
//  ColumnChartViewController.h
//  ColumnChart
//
//  Copyright 2011 Scott Logic Ltd. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <ShinobiCharts/ShinobiChart.h>
#import "ColumnChartDataSource.h"

@interface ColumnChartViewController : UIViewController {
    ShinobiChart            *chart;
    ColumnChartDataSource   *datasource;
    
    UISwitch                *stackSwitch;
    UILabel                 *stackLabel;
    
    UIButton                *animateButton;
}

@end
