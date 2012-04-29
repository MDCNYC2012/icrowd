#import "HTTPServer.h"
#import "DDLog.h"
#import "DDTTYLogger.h"

#import "MainAppDelegate.h"
#import "icViewController.h"
#import "icDataManager.h"
#import "icNetstatViewController.h"
#import "icReportDashboardViewController.h"
#import "icHTTPConnection.h"
#import "icHTTPServer.h"
#import "icConnectionManager.h"

// Log levels: off, error, warn, info, verbose
static const int ddLogLevel = LOG_LEVEL_VERBOSE;


@implementation MainAppDelegate

@synthesize window = _window;
@synthesize tabBarController = _tabBarController;

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
    UIViewController *viewOneController = [[icNetstatViewController alloc] initWithNibName:@"icNetstatViewController" bundle:nil];
    UINavigationController * navOneController = [[UINavigationController alloc] init];
    [navOneController.navigationBar setBarStyle:UIBarStyleBlack];
    [navOneController pushViewController: viewOneController animated:NO];
    
    // init navigation controller for "cloud nodes" tab
    UIViewController *viewTwoController = [[icNetstatUserTableViewController alloc] initWithNibName:@"icNetstatUserTableViewController" bundle:nil];
    UINavigationController * navTwoController = [[UINavigationController alloc] init];
    [navTwoController.navigationBar setBarStyle:UIBarStyleBlack];
    [navTwoController pushViewController: viewTwoController animated:NO];
    
    // init navigation controller for "dashboard" tab
    UIViewController *viewThreeController = [[icReportDashboardViewController alloc] initWithNibName:@"icReportDashboardViewController" bundle:nil];    
    UINavigationController * navThreeController = [[UINavigationController alloc] init];
    [navThreeController.navigationBar setBarStyle:UIBarStyleBlack];
    [navThreeController pushViewController: viewThreeController animated:NO];
    
    // init tab bar controller
    self.tabBarController = [[UITabBarController alloc] init];
    self.tabBarController.viewControllers = [[NSMutableArray alloc] initWithObjects:navOneController, navTwoController,navThreeController,nil];
    self.window.rootViewController = self.tabBarController;
    //    self.tabBarController.delegate = self.singleton;
    
    [self.window makeKeyAndVisible];
}

@end
