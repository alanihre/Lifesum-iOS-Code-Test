//
//  Food.m
//  Lifesum Code Test
//
//  Created by Alan Ihre on 2015-11-02.
//  Copyright © 2015 Ihre IT. All rights reserved.
//

#import "Food.h"

@implementation Food

@dynamic title;
@dynamic downloaded;
@dynamic pcsInGram;
@dynamic language;
@dynamic sourceId;
@dynamic showMeasurement;
@dynamic cholesterol;
@dynamic gramsPerServing;
@dynamic sugar;
@dynamic fiber;
@dynamic mlInGram;
@dynamic pcsText;
@dynamic lastUpdated;
@dynamic addedByUser;
@dynamic fat;
@dynamic sodium;
@dynamic removed;
@dynamic hidden;
@dynamic custom;
@dynamic calories;
@dynamic oid;
@dynamic servingCategory;
@dynamic saturatedFat;
@dynamic potassium;
@dynamic brand;
@dynamic carbohydrates;
@dynamic typeOfMeasurement;
@dynamic protein;
@dynamic defaultSize;
@dynamic showOnlySameType;
@dynamic unsaturatedFat;
@dynamic category;

+ (NSString *)entityName
{
    return @"Food";
}

+ (NSPredicate *)predicateWithLanguageIdentifier:(NSString *)languageIdentifier
{
    return [Food predicateWithLanguageIdentifier:languageIdentifier filteredByTitle:nil];
}


+ (NSPredicate *)predicateWithLanguageIdentifier:(NSString *)languageIdentifier filteredByTitle:(NSString *)title
{
    NSMutableString *predicateString = [NSMutableString new];
    
    if (title) {
        [predicateString appendFormat:@"title CONTAINS[cd] '%@'", title];
    }
    
    if (languageIdentifier) {
        if (predicateString.length > 0) {
            [predicateString appendString:@" AND "];
        }
        [predicateString appendFormat:@"language BEGINSWITH '%@'", languageIdentifier];
    }
    
    if (predicateString.length > 0) {
        [predicateString appendString:@" AND "];
    }
    [predicateString appendString:@"hidden == NO AND removed == NO"];
    
    NSPredicate *predicate = [NSPredicate predicateWithFormat:[predicateString copy]];
    return predicate;
}

@end
