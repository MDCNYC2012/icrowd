//
//  icHTTPServer.m
//  icrowd
//
//  Created by Nick Kaye on 4/28/12.
//  Copyright (c) 2012 Outright Mental. All rights reserved.
//

#import "DDLog.h"
#import "DDTTYLogger.h"

#import "icHTTPServer.h"
#import "icHTTPConnection.h"

@implementation icHTTPServer

-(icHTTPServer *) init
{
    self = [super init];
    if (!self) return self;
    
	// Tell the server to broadcast its presence via Bonjour.
	// This allows browsers such as Safari to automatically discover our service.
	[self setType:@"_http._tcp."];
	
	// We're going to extend the base HTTPConnection class with our icHTTPConnection class.
	// This allows us to do all kinds of customizations.
	[self setConnectionClass:[icHTTPConnection class]];
    
	// Normally there's no need to run our server on any specific port.
	// Technologies like Bonjour allow clients to dynamically discover the server's port at runtime.
	// However, for easy testing you may want force a certain port so you can just hit the refresh button.
	[self setPort:IOS_HOST_SERVER_PORT];
	
	// Serve files from our embedded Web folder
	NSString *webPath = [[[NSBundle mainBundle] resourcePath] stringByAppendingPathComponent:@"Web"];
	omLogDev(@"Setting document root: %@", webPath);
	
	[self setDocumentRoot:webPath];
	
	// Start the server (and check for problems)
	
	NSError *error;
	if([self start:&error])
	{
		omLogDev(@"Started HTTP Server on port %hu", [self listeningPort]);
	}
	else
	{
		omLogDev(@"Error starting HTTP Server: %@", error);
	}
    
    return self;
}

@end
