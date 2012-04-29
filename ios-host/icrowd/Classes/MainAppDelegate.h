#import "global.h"
#import <UIKit/UIKit.h>

@class icViewController;
@class HTTPServer;
@class icDataManager;
#import "icNetstatViewController.h"
#import "icNetstatUserTableViewController.h"
#import "icReportDashboardViewController.h"
#import "icReportLinechartViewController.h"

@interface MainAppDelegate : NSObject <UIApplicationDelegate>
{
	HTTPServer *httpServer;	
}

#pragma mark properties
@property (strong, nonatomic) UIWindow *window;
@property (strong, nonatomic) UITabBarController *tabBarController;
@property (nonatomic) id <icCloudStatusViewDelegate> cloudStatusViewDelegate;
@property (nonatomic) id <icCloudNodesViewDelegate> cloudNodesViewDelegate;
@property (nonatomic) id <icDashboardViewDelegate> dashboardViewDelegate;
@property (nonatomic) id <icLinechartViewDelegate> linechartViewDelegate;

#pragma mark start application
-(BOOL)startLogging;
-(BOOL)startDataManager;
-(BOOL)startConnectionManager;
-(BOOL)startHttpServer;
-(BOOL)startViewControllers;

#pragma mark update interval
-(BOOL)startUpdateInterval;
-(void)doUpdateInterval:(id)sender;

#pragma mark core data stack
-(icDataManager *) dataManager;

@end

