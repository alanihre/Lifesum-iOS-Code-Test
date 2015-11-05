//
//  DataImporter.m
//  Lifesum Code Test
//
//  Created by Alan Ihre on 2015-11-02.
//  Copyright © 2015 Ihre IT. All rights reserved.
//

#import "DataImporter.h"
#import "JSONImporter.h"
#import "DataStoreManager.h"
#import "FoodDataMapper.h"
#import "FoodCategoryDataMapper.h"
#import "ExerciseDataMapper.h"
#import "FoodCategory.h"

//Write operations to database are made in batches of 100 objects. This is to avoid that the UI becomes unresponsive when the main thread has to load a lot of items but to still not execute I/O operations too frequent.
static const int DataImportBatchSize = 100;

@implementation DataImporter{
    NSManagedObjectContext *_managedObjectContext;
    NSMutableDictionary *_foodCategoryMapping;
}

- (void)import:(NSError **)error
{
    _managedObjectContext = [[DataStoreManager sharedManager] newPrivateContext];
    
    //Creating a dictonary with food category oids as key and the categories as values.
    //This is used because it is much faster to use categories already in memory than fetching each one individually by oid.
    _foodCategoryMapping = [NSMutableDictionary new];

    [self importFoodCategories:&*error];//This needs to be ran before importFood in order for the food-category relation to be set
    [self importFood:&*error];
    [self importExercises:&*error];
    
}

- (void)importFood:(NSError **)error
{
    NSArray *foodArray = [JSONImporter importJSONArrayWithFileName:@"foodStatic" error:&*error];
    if (*error) {
        return;
    }
    
    FoodDataMapper *dataMapper = [FoodDataMapper new];
    NSMutableArray *mappedObjects = [NSMutableArray new];
    
    int idx = 0;
    for (NSDictionary *data in foodArray) {
        
        idx++;
        
        __block Food *foodObject = nil;
        [_managedObjectContext performBlockAndWait:^{
            foodObject = [NSEntityDescription insertNewObjectForEntityForName:[Food entityName] inManagedObjectContext:_managedObjectContext];
        }];
        
        NSError *mappingError;
        [dataMapper mapData:data ontoObject:foodObject error:&mappingError];
        if (mappingError) {
            NSLog(@"Error when importing data. Continuing with next object. Error: %@", mappingError);
            continue;
        }
        
        NSNumber *categoryId = [data objectForKey:@"categoryid"];
        if (categoryId) {
            FoodCategory *category = [_foodCategoryMapping objectForKey:categoryId];
            if (category) {
                foodObject.category = category;
            }
        }
        
        [mappedObjects addObject:foodObject];
        
        if (idx % DataImportBatchSize == 0) {
            [[DataStoreManager sharedManager] persistInContext:_managedObjectContext error:&*error];
        }
    }

    [[DataStoreManager sharedManager] persistInContext:_managedObjectContext error:&*error];
    
    NSLog(@"Imported food");

}

- (void)importFoodCategories:(NSError **)error
{
    NSArray *categoriesArray = [JSONImporter importJSONArrayWithFileName:@"categoriesStatic" error:&*error];
    if (*error) {
        return;
    }
    
    FoodCategoryDataMapper *dataMapper = [FoodCategoryDataMapper new];
    NSMutableArray *mappedObjects = [NSMutableArray new];
    
    int idx = 0;
    for (NSDictionary *data in categoriesArray) {
        
        idx++;
        
        __block FoodCategory *foodCategoryObject = nil;
        [_managedObjectContext performBlockAndWait:^{
            foodCategoryObject = [NSEntityDescription insertNewObjectForEntityForName:[FoodCategory entityName] inManagedObjectContext:_managedObjectContext];
        }];
        
        NSError *mappingError;
        [dataMapper mapData:data ontoObject:foodCategoryObject error:&mappingError];
        if (mappingError) {
            NSLog(@"Error when importing data. Continuing with next object. Error: %@", mappingError);
            continue;
        }
        
        [mappedObjects addObject:foodCategoryObject];
        
        NSNumber *oid = foodCategoryObject.oid;
        if (oid) {
            [_foodCategoryMapping setObject:foodCategoryObject forKey:oid];
        }
        
        if (idx % DataImportBatchSize == 0) {
            [[DataStoreManager sharedManager] persistInContext:_managedObjectContext error:&*error];
        }
    }
    
    [[DataStoreManager sharedManager] persistInContext:_managedObjectContext error:&*error];
    
    NSLog(@"Imported food categories");
    
}

- (void)importExercises:(NSError **)error
{
    NSArray *exercisesArray = [JSONImporter importJSONArrayWithFileName:@"exercisesStatic" error:&*error];
    if (*error) {
        return;
    }
    
    ExerciseDataMapper *dataMapper = [ExerciseDataMapper new];
    NSMutableArray *mappedObjects = [NSMutableArray new];
    
    int idx = 0;
    for (NSDictionary *data in exercisesArray) {
        
        idx++;

        __block Exercise *exerciseObject = nil;
        [_managedObjectContext performBlockAndWait:^{
            exerciseObject = [NSEntityDescription insertNewObjectForEntityForName:[Exercise entityName] inManagedObjectContext:_managedObjectContext];
        }];
        
        NSError *mappingError;
        [dataMapper mapData:data ontoObject:exerciseObject error:&mappingError];
        if (mappingError) {
            NSLog(@"Error when importing data. Continuing with next object. Error: %@", mappingError);
            continue;
        }
        
        [mappedObjects addObject:exerciseObject];
        
        if (idx % DataImportBatchSize == 0) {
            [[DataStoreManager sharedManager] persistInContext:_managedObjectContext error:&*error];
        }
    }
    
    [[DataStoreManager sharedManager] persistInContext:_managedObjectContext error:&*error];
    
    NSLog(@"Imported exercises");
    
}

@end
