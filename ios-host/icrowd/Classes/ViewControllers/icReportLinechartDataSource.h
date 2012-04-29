//
//  icReportLinechartDataSource.h
//  icReportLinechartDataSource
//
//  Copyright 2011 Scott Logic Ltd. All rights reserved.
//

#import "global.h"
#import <Foundation/Foundation.h>
#import <ShinobiCharts/ShinobiChart.h>

#pragma mark - icNetstatUserTableViewDelegate
@protocol icLinechartViewDelegate <NSObject>
-(void)mainDidUpdateInterval;
@end

@interface icReportLinechartDataSource : NSObject <SChartDatasource> {
    NSCalendar *cal; //Calendar used for constructing date objects.
    BOOL stepLineMode;
}

@property (nonatomic, retain) NSMutableArray *series1Data, *series1Dates;

-(void)toggleSeriesType;

@end
