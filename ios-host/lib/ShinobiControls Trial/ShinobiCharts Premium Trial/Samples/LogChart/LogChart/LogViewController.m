//
//  LogViewController.m
//  LogChart
//
//  Copyright (c) 2012 Scott Logic Ltd. All rights reserved.
//

#import "LogViewController.h"
#import "LogDatasource.h"
#import <ShinobiCharts/ShinobiChart.h>

@implementation LogViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self.view setBackgroundColor: [UIColor colorWithRed:26.f/255.f green:25.f/255.f blue:25.f/255.f alpha:1.f]];
    
    CGRect chartFrame;
    
    if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad) {
        
        UIImageView *headerView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"logo_black.png"]];
        [headerView setFrame:CGRectMake((self.view.bounds.size.width-446) /2, 0, 446, 92)];
        headerView.autoresizingMask = UIViewAutoresizingFlexibleLeftMargin | UIViewAutoresizingFlexibleRightMargin;
        [self.view addSubview:headerView];
        
        chartFrame = CGRectMake(self.view.bounds.size.width*0.05f, 
                                150.f, 
                                self.view.bounds.size.width*0.9f, 
                                self.view.bounds.size.height-200.f);
        
    } else {
        chartFrame = CGRectMake(self.view.bounds.size.width*0.05f, 
                                self.view.bounds.size.height*0.05f, 
                                self.view.bounds.size.width*0.9f, 
                                self.view.bounds.size.height*0.9f);
    }
    
    // Create the datasource
    datasource = [[LogDatasource alloc] init];
    
    // Create the chart
    chart = [[ShinobiChart alloc] initWithFrame:chartFrame 
                                      withTheme:[[SChartMidnightTheme alloc] init] 
                           withPrimaryXAxisType:SChartAxisTypeNumber 
                           withPrimaryYAxisType:SChartAxisTypeLogarithmic];

    [chart setDatasource: datasource];
    
    // Set y-axis to base 2
    [(SChartLogarithmicAxis *)chart.yAxis setBase: [NSNumber numberWithInt: 2]];
    
    // Display tickmarks at 2^0, 2^1, 2^2 etc.
    [chart.yAxis setMajorTickFrequency: [NSNumber numberWithInt: 1]];
    
    chart.xAxis.enableGesturePanning = YES;
    chart.xAxis.enableGestureZooming = YES;
    chart.xAxis.enableMomentumPanning = YES;
    chart.xAxis.enableMomentumZooming = YES;
    
    chart.yAxis.enableGesturePanning = YES;
    chart.yAxis.enableGestureZooming = YES;
    chart.yAxis.enableMomentumPanning = YES;
    chart.yAxis.enableMomentumZooming = YES;
    
    chart.xAxis.allowPanningOutOfDefaultRange = YES;
    chart.xAxis.allowPanningOutOfMaxRange = YES;
    
    chart.yAxis.allowPanningOutOfDefaultRange = YES;
    chart.yAxis.allowPanningOutOfMaxRange = YES;
    
    chart.yAxis.labelFormatString = @"%.2f";
    
    chart.gestureDoubleTapResetsZoom = YES;
    
    [chart setAutoresizingMask: ~UIViewAutoresizingNone];

    [self.view addSubview: chart];
    
    
    // Add a horizontal band annotation to highlight between 50 and 100 on the y-axis.
    SChartAnnotation *anno = [SChartAnnotation horizontalLineAtPosition: [NSNumber numberWithInt: 1] 
                                                              withXAxis: chart.xAxis 
                                                               andYAxis: chart.yAxis 
                                                              withWidth: 2.f 
                                                              withColor: [UIColor colorWithRed: 1.f green:1.f blue:1.f alpha:0.5f]];
    [chart addAnnotation: anno];
    
    // If you have a trial version, you need to enter your licence key here:
    //    chart.licenseKey = @"";
}

- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return YES;
}

@end
