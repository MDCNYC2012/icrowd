//
//  LogViewController.h
//  LogChart
//
//  Copyright (c) 2012 Scott Logic Ltd. All rights reserved.
//

#import <UIKit/UIKit.h>

@class ShinobiChart, LogDatasource;

@interface LogViewController : UIViewController {
    
    ShinobiChart            *chart;
    LogDatasource    *datasource;
}

@end
