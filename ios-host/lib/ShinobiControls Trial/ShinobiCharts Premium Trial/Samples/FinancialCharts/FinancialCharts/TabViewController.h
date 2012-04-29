//
//  TabViewController.h
//
//  Copyright 2012 Scott Logic Ltd. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <ShinobiCharts/ShinobiChart.h>

#import "FinancialAppDelegate.h"

@protocol FinancialAppDelegate;

@interface TabViewController : UIViewController {
    FinancialAppDelegate *delegate;
}

- (id)initWithDelegate:(FinancialAppDelegate *)_delegate;

- (void)addChart:(ShinobiChart *)chart;

- (void)removeChart:(ShinobiChart *)chart;

@end
