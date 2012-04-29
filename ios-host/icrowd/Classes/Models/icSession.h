//
//  icSession.h
//  icrowd
//
//  Created by Nick Kaye on 4/28/12.
//  Copyright (c) 2012 Outright Mental. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class icGrain;

@interface icSession : NSManagedObject

@property (nonatomic, retain) NSString * name;
@property (nonatomic, retain) NSDate * dateBegin;
@property (nonatomic, retain) NSDate * dateEnd;
@property (nonatomic, retain) icGrain *grain;

@end
