//
//  icConnectionManager.h
//  icrowd
//
//  Created by Nick Kaye on 4/29/12.
//  Copyright (c) 2012 Outright Mental. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "icNetstatViewController.h"

@interface icConnectionManager : NSObject

#pragma mark properties

#pragma mark singleton
+(icConnectionManager *) singleton;

#pragma mark get my ip address
-(NSString *)getIPAddress;

@end
