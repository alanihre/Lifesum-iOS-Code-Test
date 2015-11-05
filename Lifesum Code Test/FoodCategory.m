//
//  FoodCategory.m
//  Lifesum Code Test
//
//  Created by Alan Ihre on 2015-11-02.
//  Copyright © 2015 Ihre IT. All rights reserved.
//

#import "FoodCategory.h"

@implementation FoodCategory

@dynamic category;
@dynamic headCategoryId;
@dynamic name_fi;
@dynamic name_it;
@dynamic name_pt;
@dynamic name_no;
@dynamic servingsCategory;
@dynamic name_pl;
@dynamic name_da;
@dynamic oid;
@dynamic photoVersion;
@dynamic lastUpdated;
@dynamic name_nl;
@dynamic name_fr;
@dynamic name_ru;
@dynamic name_sv;
@dynamic name_es;
@dynamic name_de;
@dynamic food;

+ (NSString *)entityName
{
    return @"FoodCategory";
}

+ (NSArray *)supportedLanguages
{
    static NSArray *languages = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        languages = @[
                      @"fi",
                      @"it",
                      @"pt",
                      @"no",
                      @"pl",
                      @"da",
                      @"nl",
                      @"fr",
                      @"ru",
                      @"sv",
                      @"es",
                      @"de",
                      @"en",
                      ];
    });
    return languages;
}

+ (NSString *)attributeNameForLanguageIdentifier:(NSString *)languageIdentifier
{
    if ([languageIdentifier isEqualToString:@"en"]) {
        return @"category";
    }
    return [NSString stringWithFormat:@"name_%@", languageIdentifier];
}

+ (NSString *)categoryTitleForFoodCategory:(FoodCategory *)category byLanguageIdentifier:(NSString *)languageIdentifier
{
    
    if (languageIdentifier && [[FoodCategory supportedLanguages] containsObject:languageIdentifier]) {
        NSString *attributeName = [FoodCategory attributeNameForLanguageIdentifier:languageIdentifier];
        NSString *localizedTitle = [category valueForKey:attributeName];
        if (localizedTitle) {
            return localizedTitle;
        }
    }

    return [category category];

}

- (NSMutableSet *)mutableFoodSet
{
    return [self mutableSetValueForKey:@"food"];
}

- (void)addFoodObject:(Food *)value
{
    [[self mutableFoodSet] addObject:value];
}

- (void)removeFoodObject:(Food *)value
{
    [[self mutableFoodSet] removeObject:value];
}
- (void)addFoodObjects:(NSSet<Food *> *)values
{
    [[self mutableFoodSet] unionSet:values];
}
- (void)removeFoodObjects:(NSSet<Food *> *)values
{
    [[self mutableFoodSet] minusSet:values];
}

@end
