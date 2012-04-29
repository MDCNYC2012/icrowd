#import "MainAppDelegate.h"
#import "icViewController.h"
#import "icDataManager.h"
#import "icNetstatViewController.h"
#import "icReportDashboardViewController.h"
#import "HTTPServer.h"
#import "DDLog.h"
#import "DDTTYLogger.h"

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
    NSLog(@"Noooo");    
    
    // init HTTP server
    [self startHttpServer];
    
    // init view controllers
    [self startViewControllers];
    
    return YES;
}

-(BOOL)startViewControllers
{
    // init window
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    
    // create VCs
    // #warning TODO link these tabs to the root nibs of "Set Targets" and "Go To There" tabs respectively.
    UIViewController *tabOneController = [[icNetstatViewController alloc] initWithNibName:@"icNetstatViewController" bundle:nil];
    
    // init navigation controller for "Set Targets" tab, and push the root view into it
    //    UINavigationController * tabOneController = [[UINavigationController alloc] init];
    //    [tabOneController pushViewController: viewController1 animated:NO];
    
    // init view controller for "Go To There" tab
    UIViewController * tabTwoController = [[icReportDashboardViewController alloc] initWithNibName:@"icReportDashboardViewController" bundle:nil];    
    
    // init tab bar controllers
    self.tabBarController = [[UITabBarController alloc] init];
    self.tabBarController.viewControllers = [[NSMutableArray alloc] initWithObjects:tabOneController, tabTwoController,nil];
    self.window.rootViewController = self.tabBarController;
    //    self.tabBarController.delegate = self.singleton;
    
    [self.window makeKeyAndVisible];
}

-(BOOL)startHttpServer
{
    
	// Configure our logging framework.
	// To keep things simple and fast, we're just going to log to the Xcode console.
	[DDLog addLogger:[DDTTYLogger sharedInstance]];
	
	// Create server using our custom MyHTTPServer class
	httpServer = [[HTTPServer alloc] init];
	
	// Tell the server to broadcast its presence via Bonjour.
	// This allows browsers such as Safari to automatically discover our service.
	[httpServer setType:@"_http._tcp."];
	
	// Normally there's no need to run our server on any specific port.
	// Technologies like Bonjour allow clients to dynamically discover the server's port at runtime.
	// However, for easy testing you may want force a certain port so you can just hit the refresh button.
	[httpServer setPort:12345];
	
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


@end
