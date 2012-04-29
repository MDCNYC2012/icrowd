//
//  LargeDataSetAppDelegate.h
//  LargeDataSet
//
//  Copyright 2012 Scott Logic Ltd. All rights reserved.
//

#import <UIKit/UIKit.h>

@class LargeDataSetViewController;

@interface LargeDataSetAppDelegate : NSObject <UIApplicationDelegate>

@property (nonatomic, retain) IBOutlet UIWindow *window;

@property (nonatomic, retain) IBOutlet LargeDataSetViewController *viewController;

@end
