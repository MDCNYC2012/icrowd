//
//  icReportLinechartDataSource.h
//  icReportLinechartDataSource
//
//  Copyright 2011 Scott Logic Ltd. All rights reserved.
//

#import "global.h"
#import <UIKit/UIKit.h>
#import <ShinobiCharts/ShinobiChart.h>
#import "icReportLinechartDataSource.h"

@interface icReportLinechartViewController : UIViewController <SChartDelegate,icLinechartViewDelegate> {
    
    icReportLinechartDataSource     *datasource;

    UISwitch                *stepSwitch;
    UILabel                 *stepLabel;
    
    BOOL __isChartSubviewAttached;
    
}

@property (nonatomic, retain) ShinobiChart *chart;

@end
