//
//  icSession.h
//  icrowd
//
//  Created by Nick Kaye on 4/29/12.
//  Copyright (c) 2012 Outright Mental. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class icGrain;

@interface icSession : NSManagedObject

@property (nonatomic, retain) NSDate * dateBegin;
@property (nonatomic, retain) NSDate * dateEnd;
@property (nonatomic, retain) NSString * name;
@property (nonatomic, retain) NSSet *grain;
@end

@interface icSession (CoreDataGeneratedAccessors)

- (void)addGrainObject:(icGrain *)value;
- (void)removeGrainObject:(icGrain *)value;
- (void)addGrain:(NSSet *)values;
- (void)removeGrain:(NSSet *)values;

@end
