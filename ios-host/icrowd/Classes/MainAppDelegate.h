#import "global.h"
#import <UIKit/UIKit.h>

@class icViewController;
@class HTTPServer;
@class icDataManager;

@interface MainAppDelegate : NSObject <UIApplicationDelegate>
{
	HTTPServer *httpServer;	
}

#pragma mark properties
@property (strong, nonatomic) UIWindow *window;
@property (strong, nonatomic) UITabBarController *tabBarController;

-(BOOL)startDataManager;
-(BOOL)startHttpServer;
-(BOOL)startViewControllers;

#pragma mark core data stack
-(icDataManager *) dataManager;

@end

