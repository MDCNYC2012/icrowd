//
//  icGrain.h
//  icrowd
//
//  Created by Nick Kaye on 4/29/12.
//  Copyright (c) 2012 Outright Mental. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class icSession, icUser;

@interface icGrain : NSManagedObject

@property (nonatomic, retain) NSDate * date;
@property (nonatomic, retain) NSNumber * feeling;
@property (nonatomic, retain) NSNumber * id;
@property (nonatomic, retain) NSNumber * intensity;
@property (nonatomic, retain) icUser *user;
@property (nonatomic, retain) icSession *session;

@end
