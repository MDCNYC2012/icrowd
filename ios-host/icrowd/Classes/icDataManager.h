//
//  omDataManager.h
//  ontimeTests
//
//  Created by Nick Kaye on 4/22/12.
//  Copyright (c) 2012 Outright Mental. All rights reserved.
//

#import "global.h"
#import <Foundation/Foundation.h>

#pragma mark classes
@class icUser;

#pragma mark interface
@interface icDataManager : NSObject

#pragma mark properties
@property (readonly, strong, nonatomic) NSManagedObjectContext *managedObjectContext;
@property (readonly, strong, nonatomic) NSManagedObjectModel *managedObjectModel;
@property (readonly, strong, nonatomic) NSPersistentStoreCoordinator *persistentStoreCoordinator;

#pragma mark singleton
+(icDataManager *) singleton;

#pragma TARGET model
@property (nonatomic, retain) NSMutableArray *userArray; 
-(NSMutableArray *) readAll: (NSString *) entityName;
-(icUser *) userCreateNew;

#pragma mark core data stack
-(BOOL) save;
- (void)saveContext;
- (NSURL *)applicationDocumentsDirectory;

@end
