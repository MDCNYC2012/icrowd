#import "MainAppDelegate.h"
#import "icViewController.h"
#import "icDataManager.h"
#import "icNetstatViewController.h"
#import "icReportDashboardViewController.h"
#import "HTTPServer.h"
#import "DDLog.h"
#import "DDTTYLogger.h"
#import "icHTTPConnection.h"
#import "icHTTPServer.h"

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
    
    // init Data Manager
    [self startDataManager];
    
    // init HTTP server
    [self startHttpServer];
    
    // init view controllers
    [self startViewControllers];
    
    return YES;
}

-(BOOL)startDataManager
{
    // naturally trigger the custom init method
    [icDataManager singleton];
}

-(BOOL)startHttpServer
{
    
	// Configure our logging framework.
	// To keep things simple and fast, we're just going to log to the Xcode console.
	[DDLog addLogger:[DDTTYLogger sharedInstance]];
	
	// Create server using our custom MyHTTPServer class
	httpServer = [[icHTTPServer alloc] init];
	
	// Tell the server to broadcast its presence via Bonjour.
	// This allows browsers such as Safari to automatically discover our service.
	[httpServer setType:@"_http._tcp."];
	
	// We're going to extend the base HTTPConnection class with our icHTTPConnection class.
	// This allows us to do all kinds of customizations.
	[httpServer setConnectionClass:[icHTTPConnection class]];

	// Normally there's no need to run our server on any specific port.
	// Technologies like Bonjour allow clients to dynamically discover the server's port at runtime.
	// However, for easy testing you may want force a certain port so you can just hit the refresh button.
	[httpServer setPort:8080];
	
	// Serve files from our embedded Web folder
	NSString *webPath = [[[NSBundle mainBundle] resourcePath] stringByAppendingPathComponent:@"Web"];
	DDLogInfo(@"Setting document root: %@", webPath);
	
	[httpServer setDocumentRoot:webPath];
	
	// Start the server (and check for problems)
	
	NSError *error;
	if([httpServer start:&error])
	{
		DDLogInfo(@"Started HTTP Server on port %hu", [httpServer listeningPort]);
	}
	else
	{
		DDLogError(@"Error starting HTTP Server: %@", error);
	}
}

-(BOOL)startViewControllers
{
    // init window
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    
    // init navigation controller for "cloud" tab
    UIViewController *viewOneController = [[icNetstatViewController alloc] initWithNibName:@"icNetstatViewController" bundle:nil];
    UINavigationController * navOneController = [[UINavigationController alloc] init];
    [navOneController.navigationBar setBarStyle:UIBarStyleBlack];
    [navOneController pushViewController: viewOneController animated:NO];
    
    // init navigation controller for "dashboard" tab
    UIViewController *viewTwoController = [[icReportDashboardViewController alloc] initWithNibName:@"icReportDashboardViewController" bundle:nil];    
    UINavigationController * navTwoController = [[UINavigationController alloc] init];
    [navTwoController.navigationBar setBarStyle:UIBarStyleBlack];
    [navTwoController pushViewController: viewTwoController animated:NO];
    
    // init tab bar controller
    self.tabBarController = [[UITabBarController alloc] init];
    self.tabBarController.viewControllers = [[NSMutableArray alloc] initWithObjects:navOneController, navTwoController,nil];
    self.window.rootViewController = self.tabBarController;
    //    self.tabBarController.delegate = self.singleton;
    
    [self.window makeKeyAndVisible];
}

@end
