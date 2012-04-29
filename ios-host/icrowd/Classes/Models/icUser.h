//
//  icUser.h
//  icrowd
//
//  Created by Nick Kaye on 4/29/12.
//  Copyright (c) 2012 Outright Mental. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class icGrain;

@interface icUser : NSManagedObject

@property (nonatomic, retain) NSNumber * age;
@property (nonatomic, retain) NSNumber * gender;
@property (nonatomic, retain) NSNumber * idx;
@property (nonatomic, retain) NSString * name;
@property (nonatomic, retain) NSSet *grain;
@property (nonatomic, retain) NSArray *grainSorted;
@property (nonatomic, retain) icGrain *grainMostRecent;

@end

@interface icUser (CoreDataGeneratedAccessors)

- (BOOL)hasGrain;
- (void)addGrainObject:(icGrain *)value;
- (void)removeGrainObject:(icGrain *)value;
- (void)addGrain:(NSSet *)values;
- (void)removeGrain:(NSSet *)values;

@end
