//
//  icGrain.h
//  icrowd
//
//  Created by Nick Kaye on 4/28/12.
//  Copyright (c) 2012 Outright Mental. All rights reserved.
//

#import "global.h"
#import "icSession.h"
#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class icUser;

@interface icGrain : NSManagedObject

@property (nonatomic, retain) NSNumber * idx;
@property (nonatomic, retain) NSNumber * feeling;
@property (nonatomic, retain) NSNumber * intensity;
@property (nonatomic, retain) NSDate * date;
@property (nonatomic, retain) icUser *user;
@property (nonatomic, retain) icSession *session;

@end
