//
//  PieChartAppDelegate.h
//  PieChart
//
//  Copyright 2012 Scott Logic Ltd. All rights reserved.
//

#import <UIKit/UIKit.h>

@class PieChartViewController;

@interface PieChartAppDelegate : NSObject <UIApplicationDelegate>

@property (nonatomic, retain) IBOutlet UIWindow *window;

@property (nonatomic, retain) IBOutlet PieChartViewController *viewController;

@end
