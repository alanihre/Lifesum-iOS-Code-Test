//
//  DataStoreManager.m
//  Bilapp
//
//  Created by Alan Ihre on 2015-11-02.
//  Copyright © 2015 Ihre IT. All rights reserved.
//

#import "DataStoreManager.h"

@interface DataStoreManager ()

@property (nonatomic, strong, readwrite) NSManagedObjectContext *managedObjectContext;
@property (nonatomic,strong) NSPersistentStoreCoordinator *persistentStoreCoordinator;

@end

@implementation DataStoreManager

- (void)initalize
{
    [self setupManagedObjectContext];
}

+ (DataStoreManager *)sharedManager
{
    static DataStoreManager *sharedManager;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        sharedManager = [[self alloc] init];
    });
    return sharedManager;
}

- (void)setupManagedObjectContext
{
    self.managedObjectContext = [[NSManagedObjectContext alloc] initWithConcurrencyType:NSMainQueueConcurrencyType];
    self.persistentStoreCoordinator = [[NSPersistentStoreCoordinator alloc] initWithManagedObjectModel:[self managedObjectModel]];
    
    NSError *error = nil;
    [_persistentStoreCoordinator addPersistentStoreWithType:NSSQLiteStoreType configuration:nil URL:[self storeURL] options:nil error:&error];
    if (error) {
        NSLog(@"Error when setting up manager object context: %@", error);
    }
    self.managedObjectContext.persistentStoreCoordinator = self.persistentStoreCoordinator;
    
    //Observe changes in all managed objects contexts
    [[NSNotificationCenter defaultCenter] addObserverForName:NSManagedObjectContextDidSaveNotification object:nil queue:nil usingBlock:^(NSNotification *note)
    {
        NSManagedObjectContext *managedObjectContext = self.managedObjectContext;
        //If changed managed object context is not the main one merge the changes into the main one
        if (note.object != managedObjectContext)
            [managedObjectContext performBlock:^(){
                [managedObjectContext mergeChangesFromContextDidSaveNotification:note];
            }];
    }];

}

- (void)persist:(NSError **)error
{
    [self persistInContext:self.managedObjectContext error:&*error];
}

- (void)persistInContext:(NSManagedObjectContext *)managedObjectContext error:(NSError **)error
{
    [managedObjectContext save:&*error];
}

- (NSManagedObjectModel *)managedObjectModel
{
    return [[NSManagedObjectModel alloc] initWithContentsOfURL:[self modelURL]];
}

- (NSURL *)storeURL
{
    NSURL *documentsDirectory = [[NSFileManager defaultManager] URLForDirectory:NSDocumentDirectory inDomain:NSUserDomainMask appropriateForURL:nil create:YES error:NULL];
    return [documentsDirectory URLByAppendingPathComponent:@"database.sqlite"];
}

- (NSURL *)modelURL
{
    return [[NSBundle mainBundle] URLForResource:@"DataModel" withExtension:@"momd"];
}


- (NSManagedObjectContext *)newPrivateContext
{
    NSManagedObjectContext *context = [[NSManagedObjectContext alloc] initWithConcurrencyType:NSPrivateQueueConcurrencyType];
    context.persistentStoreCoordinator = self.persistentStoreCoordinator;
    return context;
}

@end
