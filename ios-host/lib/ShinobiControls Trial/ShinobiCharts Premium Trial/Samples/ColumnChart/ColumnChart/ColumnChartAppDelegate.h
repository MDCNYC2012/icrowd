//
//  ColumnChartAppDelegate.h
//  ColumnChart
//
//  Copyright 2011 Scott Logic Ltd. All rights reserved.
//

#import <UIKit/UIKit.h>

@class ColumnChartViewController;

@interface ColumnChartAppDelegate : NSObject <UIApplicationDelegate>

@property (nonatomic, retain) IBOutlet UIWindow *window;

@property (nonatomic, retain) IBOutlet ColumnChartViewController *viewController;

@end
