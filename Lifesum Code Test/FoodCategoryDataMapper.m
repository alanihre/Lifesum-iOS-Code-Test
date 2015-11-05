//
//  FoodCategoryDataMapper.m
//  Lifesum Code Test
//
//  Created by Alan Ihre on 2015-11-02.
//  Copyright © 2015 Ihre IT. All rights reserved.
//

#import "FoodCategoryDataMapper.h"

@implementation FoodCategoryDataMapper

- (NSDictionary *)dataMapping
{
    static NSDictionary *mapping = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        mapping = @{
                    @"category": @"category",
                    @"headcategoryid": @"headCategoryId",
                    @"name_fi": @"name_fi",
                    @"name_it": @"name_it",
                    @"name_pt": @"name_pt",
                    @"name_no": @"name_no",
                    @"servingscategory": @"servingsCategory",
                    @"name_pl": @"name_pl",
                    @"name_da": @"name_da",
                    @"oid": @"oid",
                    @"photo_version": @"photoVersion",
                    @"name_nl": @"name_nl",
                    @"name_fr": @"name_fr",
                    @"name_ru": @"name_ru",
                    @"name_sv": @"name_sv",
                    @"name_es": @"name_es",
                    @"name_de": @"name_de",
                    };
    });
    return mapping;
}

- (void)mapData:(NSDictionary *)data ontoObject:(FoodCategory *)object error:(NSError **)error
{
    [super mapData:data ontoObject:object error:error];
    
    NSNumber *lastUpdated = [data objectForKey:@"lastupdated"];
    if (lastUpdated) {
        NSDate *lastUpdatedDate = [NSDate dateWithTimeIntervalSince1970:[lastUpdated integerValue]];
        object.lastUpdated = lastUpdatedDate;
    }

}

@end
