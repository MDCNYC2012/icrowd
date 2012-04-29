//
//  omDataManager.m
//  ontimeTests
//
//  Created by Nick Kaye on 4/22/12.
//  Copyright (c) 2012 Outright Mental. All rights reserved.
//
// TODO: line 114 need to implement write-through CoreData for grain with user-relation
#pragma mark -

#import "icDataManager.h"
#import "icUser.h"
#import "icGrain.h"

@implementation icDataManager

/*
 */
#pragma mark properties

@synthesize managedObjectContext = __managedObjectContext;
@synthesize managedObjectModel = __managedObjectModel;
@synthesize persistentStoreCoordinator = __persistentStoreCoordinator;
@synthesize userArray = _userArray;
static int __userIndex;

/*
 */
#pragma mark singleton

static id __instance;

+(icDataManager *) singleton
{
    if (__instance!=nil) return __instance;
    __instance = [icDataManager new];
    return __instance;
}

/*
 */
#pragma mark initializer

-(icDataManager *) init
{
    self = [super init];
    if (!self) return self;
    return self;
}

/*
 */
#pragma USER model

-(NSMutableArray *) userReadAll
{
    
    // Define our table/entity to use
    NSEntityDescription *entity = [NSEntityDescription entityForName: @"User" inManagedObjectContext:self.managedObjectContext];
    
    // Setup the fetch request
    NSFetchRequest *request = [[NSFetchRequest alloc] init];
    [request setEntity:entity]; 
    
    // Define how we will sort the records
    NSSortDescriptor *sortDescriptor = [[NSSortDescriptor alloc] initWithKey:@"idx" ascending:YES];
    NSArray *sortDescriptors = [NSArray arrayWithObject:sortDescriptor];
    [request setSortDescriptors:sortDescriptors];
    
    // Fetch the records and handle an error
    NSError *error;
    NSMutableArray *outcome = [[self.managedObjectContext executeFetchRequest:request error:&error] mutableCopy]; 
    if (!self.userArray) {
        // Handle the error.
        // This is a serious error and should advise the user to restart the application
    }     
    
    // store the largest count found for the next new idx
    int userCount = [outcome count];
    if (userCount > __userIndex)
        __userIndex = userCount;
    return outcome;
}

-(icUser *) userCreateWithName:(NSString *)n andAge:(NSNumber *)a andGender:(NSNumber *)g
{
    icUser * user = (icUser *)[NSEntityDescription insertNewObjectForEntityForName:@"User" inManagedObjectContext:self.managedObjectContext];
    user.idx = [[NSNumber alloc]initWithInt:++__userIndex];
    user.name = n;
    user.age = a;
    user.gender = g;
    // if save failure, fail
    if (![self save]) return nil;
    [self.userArray addObject:user];
    return user;
}

/*
 */
#pragma mark GRAIN model

-(icGrain *) grainCreateForUserId:(NSNumber *)uIdx andFeeling:(NSNumber *)f andIntensity:(NSNumber *)i
{
#pragma mark THE FOLLOWING CODE IS TERRIBLE. FIND THE CORRECT WAY TO DO THIS, WRITING STRAIGHT THROUGH IF POSSIBLE
    // fetch the User we are going to create a grain for
    NSEntityDescription *entity = [NSEntityDescription entityForName:@"User" inManagedObjectContext:self.managedObjectContext];
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"idx = %@",uIdx];
    NSFetchRequest *request = [[NSFetchRequest alloc] init];
    [request setEntity: entity]; 
    [request setPredicate: predicate];
    
    // Fetch the records and handle an error
    NSError *error;
    NSMutableArray *mutableFetchResults = [[self.managedObjectContext executeFetchRequest:request error:&error] mutableCopy];
    if (!mutableFetchResults || ![mutableFetchResults count]>0)
        return nil;
        // Handle the error.
        // This is a serious error and should advise the user to restart the application
    
    // get the user model from the fetch
    icUser * user = [mutableFetchResults objectAtIndex:0];
    
    // create a grain for that user
    icGrain * grain = (icGrain *)[NSEntityDescription insertNewObjectForEntityForName:@"Grain" inManagedObjectContext:self.managedObjectContext];
    grain.user = user;
    grain.feeling = f;
    grain.intensity = i;
    grain.date = [[NSDate alloc] init];
    // if save failure, fail
    if (![self save]) return nil;
    return grain;
}

#pragma mark DANGER ... flush database

-(void)flushDatabase
{
    NSArray * stores = [self.persistentStoreCoordinator persistentStores];
    NSPersistentStore *store = [stores objectAtIndex:0];
    NSError *error;
    NSURL *storeURL = store.URL;
    [self.persistentStoreCoordinator removePersistentStore:store error:&error];
    omLogDev(@"removeItemAtPath:%@",storeURL.path);
    [[NSFileManager defaultManager] removeItemAtPath:storeURL.path error:&error];
    [self managedObjectModelInitNew];
    [self persistentStoreCoordinatorInitNew];
    [self managedObjectContextInitNew];
    [self.userArray removeAllObjects];
}

#pragma mark - Core Data stack

- (void)saveContext
{
    NSError *error = nil;
    NSManagedObjectContext *managedObjectContext = self.managedObjectContext;
    if (managedObjectContext != nil) {
        if ([managedObjectContext hasChanges] && ![managedObjectContext save:&error]) {
            // Replace this implementation with code to handle the error appropriately.
            // abort() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development. 
            NSLog(@"Unresolved error %@, %@", error, [error userInfo]);
            abort();
        } 
    }
}

-(BOOL) save
{
    NSError *error;
    
    if(![self.managedObjectContext save:&error]){
        
        //This is a serious error saying the record
        //could not be saved. Advise the user to
        //try again or restart the application. 
        return false;
    }    
    return true;
}

// Returns the managed object model for the application.
// If the model doesn't already exist, it is created from the application's model.
- (NSManagedObjectModel *)managedObjectModel
{
    if (__managedObjectModel != nil)
        return __managedObjectModel;
    [self managedObjectModelInitNew];
    return __managedObjectModel;
}

-(void)managedObjectModelInitNew
{

    NSURL *modelURL = [[NSBundle mainBundle] URLForResource:@"icrowd" withExtension:@"momd"];

    __managedObjectModel = [[NSManagedObjectModel alloc] initWithContentsOfURL:modelURL];

    /*
     omLogDev(@"Managed Object Model: %@",__managedObjectModel);
     NSString *logAll = @"Managed Object Model Entities:\n";
     for ( icUser *target in __managedObjectModel.entities)
     logAll = [logAll stringByAppendingFormat: @"%@\n", target];
     omLogDev(logAll);
     */

}

// Returns the persistent store coordinator for the application.
// If the coordinator doesn't already exist, it is created and the application's store added to it.
- (NSPersistentStoreCoordinator *)persistentStoreCoordinator
{
    if (__persistentStoreCoordinator != nil)
        return __persistentStoreCoordinator;
    [self persistentStoreCoordinatorInitNew];    
    return __persistentStoreCoordinator;
}

-(void)persistentStoreCoordinatorInitNew
{
    NSURL *storeURL = [[self applicationDocumentsDirectory] URLByAppendingPathComponent:@"icrowd.sqlite"];
    
    NSError *error = nil;
    __persistentStoreCoordinator = [[NSPersistentStoreCoordinator alloc] initWithManagedObjectModel:self.managedObjectModel];
    if (![__persistentStoreCoordinator addPersistentStoreWithType:NSSQLiteStoreType configuration:nil URL:storeURL options:nil error:&error]) {
        omLogDev(@"FAILED to obtain the persistent store coordinator!");
        /*
         Replace this implementation with code to handle the error appropriately.
         
         abort() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development. 
         
         Typical reasons for an error here include:
         * The persistent store is not accessible;
         * The schema for the persistent store is incompatible with current managed object model.
         Check the error message to determine what the actual problem was.
         
         
         If the persistent store is not accessible, there is typically something wrong with the file path. Often, a file URL is pointing into the application's resources directory instead of a writeable directory.
         
         If you encounter schema incompatibility errors during development, you can reduce their frequency by:
         * Simply deleting the existing store:
         [[NSFileManager defaultManager] removeItemAtURL:storeURL error:nil]
         
         * Performing automatic lightweight migration by passing the following dictionary as the options parameter: 
         [NSDictionary dictionaryWithObjectsAndKeys:[NSNumber numberWithBool:YES], NSMigratePersistentStoresAutomaticallyOption, [NSNumber numberWithBool:YES], NSInferMappingModelAutomaticallyOption, nil];
         
         Lightweight migration will only work for a limited set of schema changes; consult "Core Data Model Versioning and Data Migration Programming Guide" for details.
         
         */
        NSLog(@"Unresolved error %@, %@", error, [error userInfo]);
        abort();
    }
    
}

// Returns the managed object context for the application.
// If the context doesn't already exist, it is created and bound to the persistent store coordinator for the application.
- (NSManagedObjectContext *)managedObjectContext
{
    if (__managedObjectContext != nil) {
        return __managedObjectContext;
    }    
    [self managedObjectContextInitNew];
    return __managedObjectContext;
}

-(void)managedObjectContextInitNew
{
    NSPersistentStoreCoordinator *coordinator = [self persistentStoreCoordinator];
    if (coordinator != nil) {
        __managedObjectContext = [[NSManagedObjectContext alloc] init];
        [__managedObjectContext setPersistentStoreCoordinator:coordinator];
    }    
}

#pragma mark - Application's Documents directory

// Returns the URL to the application's Documents directory.
- (NSURL *)applicationDocumentsDirectory
{
    return [[[NSFileManager defaultManager] URLsForDirectory:NSDocumentDirectory inDomains:NSUserDomainMask] lastObject];
}

@end
