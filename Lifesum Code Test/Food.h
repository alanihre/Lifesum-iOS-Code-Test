//
//  Food.h
//  Lifesum Code Test
//
//  Created by Alan Ihre on 2015-11-02.
//  Copyright © 2015 Ihre IT. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>
#import "FoodCategory.h"

@class FoodCategory;

@interface Food : NSManagedObject

@property (nonatomic, strong) NSString *title;
@property (nonatomic, strong) NSNumber *downloaded;
@property (nonatomic, strong) NSNumber *pcsInGram;
@property (nonatomic, strong) NSString *language;
@property (nonatomic, strong) NSNumber *sourceId;
@property (nonatomic, strong) NSNumber *showMeasurement;
@property (nonatomic, strong) NSNumber *cholesterol;
@property (nonatomic, strong) NSNumber *gramsPerServing;
@property (nonatomic, strong) NSNumber *sugar;
@property (nonatomic, strong) NSNumber *fiber;
@property (nonatomic, strong) NSNumber *mlInGram;
@property (nonatomic, strong) NSString *pcsText;
@property (nonatomic, strong) NSDate *lastUpdated;
@property (nonatomic, strong) NSNumber *addedByUser;
@property (nonatomic, strong) NSNumber *fat;
@property (nonatomic, strong) NSNumber *sodium;
@property (nonatomic, strong) NSNumber *removed;
@property (nonatomic, strong) NSNumber *hidden;
@property (nonatomic, strong) NSNumber *custom;
@property (nonatomic, strong) NSNumber *calories;
@property (nonatomic, strong) NSNumber *oid;
@property (nonatomic, strong) NSNumber *servingCategory;
@property (nonatomic, strong) NSNumber *saturatedFat;
@property (nonatomic, strong) NSNumber *potassium;
@property (nonatomic, strong) NSString *brand;
@property (nonatomic, strong) NSNumber *carbohydrates;
@property (nonatomic, strong) NSNumber *typeOfMeasurement;
@property (nonatomic, strong) NSNumber *protein;
@property (nonatomic, strong) NSNumber *defaultSize;
@property (nonatomic, strong) NSNumber *showOnlySameType;
@property (nonatomic, strong) NSNumber *unsaturatedFat;
@property (nonatomic, strong) FoodCategory *category;

+ (NSString *)entityName;

+ (NSPredicate *)predicateWithLanguageIdentifier:(NSString *)languageIdentifier filteredByTitle:(NSString *)title;

@end
