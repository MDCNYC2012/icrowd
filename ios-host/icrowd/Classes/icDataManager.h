//
//  omDataManager.h
//  ontimeTests
//
//  Created by Nick Kaye on 4/22/12.
//  Copyright (c) 2012 Outright Mental. All rights reserved.
//

#import "global.h"
#import <Foundation/Foundation.h>
#import "icNetstatUserTableViewController.h"
#import "icNetstatViewController.h"

#pragma mark classes
@class icUser;
@class icGrain;

#pragma mark interface
@interface icDataManager : NSObject

#pragma mark properties
@property (readonly, strong, nonatomic) NSManagedObjectContext *managedObjectContext;
@property (readonly, strong, nonatomic) NSManagedObjectModel *managedObjectModel;
@property (readonly, strong, nonatomic) NSPersistentStoreCoordinator *persistentStoreCoordinator;
@property (nonatomic, strong) NSMutableArray *userArray; 

#pragma mark singleton
+(icDataManager *) singleton;

#pragma TARGET model
-(icUser *) userCreateWithName:(NSString *)n andAge:(NSNumber *)a andGender:(NSNumber *)g;
-(NSMutableArray *) userReadAll;

#pragma mark GRAIN model
-(icGrain *) grainCreateForUserId:(NSNumber *)uIdx andFeeling:(NSNumber *)f andIntensity:(NSNumber *)i;

#pragma mark DANGER ... flush database
-(void)flushDatabase;

#pragma mark core data stack
-(BOOL) save;
-(void)saveContext;
-(void)managedObjectModelInitNew;
-(void)persistentStoreCoordinatorInitNew;
-(void)managedObjectContextInitNew;
-(NSURL *)applicationDocumentsDirectory;

@end
