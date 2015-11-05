//
//  Exercise.m
//  Lifesum Code Test
//
//  Created by Alan Ihre on 2015-11-02.
//  Copyright © 2015 Ihre IT. All rights reserved.
//

#import "Exercise.h"

@implementation Exercise

@dynamic name_pl;
@dynamic hidden;
@dynamic removed;
@dynamic downloaded;
@dynamic name_da;
@dynamic photoVersion;
@dynamic custom;
@dynamic name_pt;
@dynamic oid;
@dynamic name_no;
@dynamic name_sv;
@dynamic name_es;
@dynamic lastUpdated;
@dynamic name_ru;
@dynamic addedByUser;
@dynamic name_de;
@dynamic title;
@dynamic name_fr;
@dynamic name_nl;
@dynamic calories;
@dynamic name_it;

+ (NSString *)entityName
{
    return @"Exercise";
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
        return @"title";
    }
    return [NSString stringWithFormat:@"name_%@", languageIdentifier];
}

+ (NSString *)titleForExercise:(Exercise *)exercise byLanguageIdentifier:(NSString *)languageIdentifier
{
    
    if (languageIdentifier && [[Exercise supportedLanguages] containsObject:languageIdentifier]) {
        NSString *attributeName = [Exercise attributeNameForLanguageIdentifier:languageIdentifier];
        NSString *localizedTitle = [exercise valueForKey:attributeName];
        if (localizedTitle) {
            return localizedTitle;
        }
    }
    
    return [exercise title];
    
}

+ (NSPredicate *)predicateWithLanguageAttributeName:(NSString *)languageAttributeName filteredByTitle:(NSString *)title
{
    NSMutableString *predicateString = [NSMutableString new];
    
    if (title) {
        NSString *titlePart = [NSString stringWithFormat:@"title CONTAINS[cd] '%@'", title];
        if (languageAttributeName) {
            [predicateString appendFormat:@"(%@ OR %@ CONTAINS[cd] '%@')", titlePart, languageAttributeName, title];
        } else {
            [predicateString appendString:titlePart];
        }
    }
    
    if (predicateString.length > 0) {
        [predicateString appendString:@" AND "];
    }
    [predicateString appendString:@"hidden == NO AND removed == NO"];
    
    NSPredicate *predicate = [NSPredicate predicateWithFormat:[predicateString copy]];
    return predicate;
}

@end
