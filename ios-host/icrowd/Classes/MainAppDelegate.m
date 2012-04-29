#import "HTTPServer.h"
#import "DDLog.h"
#import "DDTTYLogger.h"

#import "MainAppDelegate.h"
#import "icViewController.h"
#import "icDataManager.h"
#import "icNetstatViewController.h"
#import "icReportDashboardViewController.h"
#import "icReportLinechartViewController.h"
#import "icHTTPConnection.h"
#import "icHTTPServer.h"
#import "icConnectionManager.h"

// Log levels: off, error, warn, info, verbose
static const int ddLogLevel = LOG_LEVEL_VERBOSE;


@implementation MainAppDelegate

/*
 */
#pragma mark properties
@synthesize window = _window;
@synthesize tabBarController = _tabBarController;

@synthesize cloudStatusViewDelegate = _cloudStatusViewDelegate;
@synthesize cloudNodesViewDelegate = _cloudNodesViewDelegate;
@synthesize dashboardViewDelegate = _dashboardViewDelegate;
@synthesize linechartViewDelegate = _linechartViewDelegate;

/*
 */
#pragma mark core data stack

-(icDataManager *) dataManager
{
    return [icDataManager singleton];
}

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    // init Loggind
    [self startLogging];
    
    // init Data Manager
    [self startDataManager];
    
    // init Connection Manager
    [self startConnectionManager];
    
    // init HTTP server
    [self startHttpServer];
    
    // init view controllers
    [self startViewControllers];
    
    // init update interval
    [self startUpdateInterval];
    
    return YES;
}

-(BOOL)startLogging
{
    // Configure our logging framework.
	// To keep things simple and fast, we're just going to log to the Xcode console.
	[DDLog addLogger:[DDTTYLogger sharedInstance]];
}

-(BOOL)startDataManager
{
    // naturally trigger the custom init method
    [icDataManager singleton];
}

-(BOOL)startConnectionManager
{
    // naturally trigger the custom init method
    [icConnectionManager singleton];
}

-(BOOL)startHttpServer
{
	// Create server using our custom MyHTTPServer class
	httpServer = [[icHTTPServer alloc] init];
}

-(BOOL)startViewControllers
{
    // init window
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    
    // init navigation controller for "cloud status" tab
    icNetstatViewController *viewOneController = [[icNetstatViewController alloc] initWithNibName:@"icNetstatViewController" bundle:nil];
    UINavigationController * navOneController = [[UINavigationController alloc] init];
    [navOneController.navigationBar setBarStyle:UIBarStyleBlack];
    [navOneController pushViewController: viewOneController animated:NO];
    self.cloudStatusViewDelegate = viewOneController;
    
    // init navigation controller for "cloud nodes" tab
    icNetstatUserTableViewController *viewTwoController = [[icNetstatUserTableViewController alloc] initWithNibName:@"icNetstatUserTableViewController" bundle:nil];
    UINavigationController * navTwoController = [[UINavigationController alloc] init];
    [navTwoController.navigationBar setBarStyle:UIBarStyleBlack];
    [navTwoController pushViewController: viewTwoController animated:NO];
    self.cloudNodesViewDelegate = viewTwoController;
    
    // init navigation controller for "dashboard" tab
    icReportDashboardViewController *viewThreeController = [[icReportDashboardViewController alloc] initWithNibName:@"icReportDashboardViewController" bundle:nil];    
    UINavigationController * navThreeController = [[UINavigationController alloc] init];
    [navThreeController.navigationBar setBarStyle:UIBarStyleBlack];
    [navThreeController pushViewController: viewThreeController animated:NO];
    self.dashboardViewDelegate = viewThreeController;
    
    // init navigation controller for "linechart" tab
    icReportLinechartViewController *viewFourController = [[icReportLinechartViewController alloc] initWithNibName:@"icReportLinechartViewController" bundle:nil];    
    UINavigationController * navFourController = [[UINavigationController alloc] init];
    [navFourController.navigationBar setBarStyle:UIBarStyleBlack];
    [navFourController pushViewController: viewFourController animated:NO];
    self.linechartViewDelegate = viewFourController;
    
    
    // init tab bar controller
    self.tabBarController = [[UITabBarController alloc] init];
    self.tabBarController.viewControllers = [[NSMutableArray alloc] initWithObjects:
                                             navOneController,
                                             navTwoController, 
                                             // navThreeController,
                                             // navFourController,
                                             nil];
    self.window.rootViewController = self.tabBarController;
    //    self.tabBarController.delegate = self.singleton;
    
    [self.window makeKeyAndVisible];
}

/*
 */
#pragma mark update interval

static NSTimer * __updateIntervalTimer;

-(BOOL)startUpdateInterval
{
   __updateIntervalTimer = [NSTimer scheduledTimerWithTimeInterval: IC_REPORT_UPDATE_INTERVAL_SECONDS
                                     target: self
                                   selector: @selector(doUpdateInterval:)
                                   userInfo: nil
                                    repeats: YES];
}

-(void)doUpdateInterval:(id)sender
{
    [self.cloudStatusViewDelegate mainDidUpdateInterval];
    [self.cloudNodesViewDelegate mainDidUpdateInterval];
    [self.dashboardViewDelegate mainDidUpdateInterval];
    [self.linechartViewDelegate mainDidUpdateInterval];
}

@end
