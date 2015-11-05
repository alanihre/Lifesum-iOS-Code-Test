//
//  DataStoreManager.h
//  Bilapp
//
//  Created by Alan Ihre on 2015-11-02.
//  Copyright © 2015 Ihre IT. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@interface DataStoreManager : NSObject

@property (nonatomic, strong, readonly) NSManagedObjectContext *managedObjectContext;

+ (DataStoreManager *)sharedManager;

- (void)initalize;
- (void)persist:(NSError **)error;
- (void)persistInContext:(NSManagedObjectContext *)managedObjectContext error:(NSError **)error;
- (NSManagedObjectContext *)newPrivateContext;

@end
