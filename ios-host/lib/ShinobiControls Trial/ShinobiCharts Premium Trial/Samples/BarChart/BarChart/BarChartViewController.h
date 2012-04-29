//
//  BarChartViewController.h
//  BarChart
//
//  Copyright 2011 Scott Logic Ltd. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <ShinobiCharts/ShinobiChart.h>
#import "BarChartDataSource.h"

@interface BarChartViewController : UIViewController {
    ShinobiChart *chart;
    BarChartDataSource *datasource;
}

@property (nonatomic, retain) UIButton *animateButton;

- (IBAction)animateBars:(id)sender;

@end
