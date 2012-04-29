//
//  icUser.h
//  icrowd
//
//  Created by Nick Kaye on 4/28/12.
//  Copyright (c) 2012 Outright Mental. All rights reserved.
//

#import "global.h"
#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class icGrain;

@interface icUser : NSManagedObject

@property (nonatomic, retain) NSNumber * idx;
@property (nonatomic, retain) NSString * name;
@property (nonatomic, retain) NSNumber * gender;
@property (nonatomic, retain) NSNumber * age;
@property (nonatomic, retain) icGrain *grain;

@end
