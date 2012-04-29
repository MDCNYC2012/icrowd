//
//  icrowdReportDashboardViewController.h
//  icrowd
//
//  Created by Nick Kaye on 4/28/12.
//  Copyright (c) 2012 Outright Mental. All rights reserved.
//

#import "global.h"
#import <UIKit/UIKit.h>
#import <ShinobiCharts/ShinobiChart.h>

@class icReportDashboardDataSource;

#pragma mark - icNetstatUserTableViewDelegate
@protocol icDashboardViewDelegate <NSObject>
-(void)mainDidUpdateInterval;
@end

@interface icReportDashboardViewController : UIViewController <icDashboardViewDelegate> {
    icReportDashboardDataSource *datasource;
    BOOL __isChartSubviewAttached;
}

@property (nonatomic, retain) UIButton *animateButton;
@property (nonatomic, retain) ShinobiChart *chart;

- (IBAction)animateBars:(id)sender;

@end
