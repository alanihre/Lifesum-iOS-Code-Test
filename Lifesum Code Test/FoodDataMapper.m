//
//  FoodDataMapper.m
//  Lifesum Code Test
//
//  Created by Alan Ihre on 2015-11-01.
//  Copyright © 2015 Ihre IT. All rights reserved.
//

#import "FoodDataMapper.h"

@implementation FoodDataMapper

- (NSDictionary *)dataMapping
{
    static NSDictionary *mapping = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        mapping = @{
                 @"title": @"title",
                 @"downloaded": @"downloaded",
                 @"pcsingram": @"pcsInGram",
                 @"language": @"language",
                 @"source_id": @"sourceId",
                 @"showmeasurement": @"showMeasurement",
                 @"cholesterol": @"cholesterol",
                 @"gramsperserving": @"gramsPerServing",
                 @"sugar": @"sugar",
                 @"fiber": @"fiber",
                 @"mlingram": @"mlInGram",
                 @"pcstext": @"pcsText",
                 @"addedbyuser": @"addedByUser",
                 @"fat": @"fat",
                 @"sodium": @"sodium",
                 @"deleted": @"removed",
                 @"hidden": @"hidden",
                 @"custom": @"custom",
                 @"calories": @"calories",
                 @"oid": @"oid",
                 @"servingcategory": @"servingCategory",
                 @"saturatedfat": @"saturatedFat",
                 @"potassium": @"potassium",
                 @"brand": @"brand",
                 @"carbohydrates": @"carbohydrates",
                 @"typeofmeasurement": @"typeOfMeasurement",
                 @"protein": @"protein",
                 @"defaultsize": @"defaultSize",
                 @"showonlysametype": @"showOnlySameType",
                 @"unsaturatedfat": @"unsaturatedFat",

                 };
    });
    return mapping;
}

- (void)mapData:(NSDictionary *)data ontoObject:(Food *)object error:(NSError **)error
{
    
    [super mapData:data ontoObject:object error:error];
    
    NSNumber *lastUpdated = [data objectForKey:@"lastupdated"];
    if (lastUpdated) {
        NSDate *lastUpdatedDate = [NSDate dateWithTimeIntervalSince1970:[lastUpdated integerValue]];
        object.lastUpdated = lastUpdatedDate;
    }
}

@end
