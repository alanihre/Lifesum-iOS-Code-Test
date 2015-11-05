//
//  FoodCategory.h
//  Lifesum Code Test
//
//  Created by Alan Ihre on 2015-11-02.
//  Copyright © 2015 Ihre IT. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>
#import "Food.h"

@class Food;

@interface FoodCategory : NSManagedObject

@property (nonatomic, strong) NSString *category;
@property (nonatomic, strong) NSNumber *headCategoryId;
@property (nonatomic, strong) NSString *name_fi;
@property (nonatomic, strong) NSString *name_it;
@property (nonatomic, strong) NSString *name_pt;
@property (nonatomic, strong) NSString *name_no;
@property (nonatomic, strong) NSNumber *servingsCategory;
@property (nonatomic, strong) NSString *name_pl;
@property (nonatomic, strong) NSString *name_da;
@property (nonatomic, strong) NSNumber *oid;
@property (nonatomic, strong) NSNumber *photoVersion;
@property (nonatomic, strong) NSDate *lastUpdated;
@property (nonatomic, strong) NSString *name_nl;
@property (nonatomic, strong) NSString *name_fr;
@property (nonatomic, strong) NSString *name_ru;
@property (nonatomic, strong) NSString *name_sv;
@property (nonatomic, strong) NSString *name_es;
@property (nonatomic, strong) NSString *name_de;
@property (nonatomic, strong) NSSet<Food *>  *food;

+ (NSString *)entityName;

+ (NSArray *)supportedLanguages;
+ (NSString *)attributeNameForLanguageIdentifier:(NSString *)languageIdentifier;
+ (NSString *)categoryTitleForFoodCategory:(FoodCategory *)category byLanguageIdentifier:(NSString *)languageIdentifier;

- (void)addFoodObject:(Food *)value;
- (void)removeFoodObject:(Food *)value;
- (void)addFoodObjects:(NSSet<Food *> *)values;
- (void)removeFoodObjects:(NSSet<Food *> *)values;

@end
