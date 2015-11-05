//
//  ExerciseDataMapper.m
//  Lifesum Code Test
//
//  Created by Alan Ihre on 2015-11-02.
//  Copyright © 2015 Ihre IT. All rights reserved.
//

#import "ExerciseDataMapper.h"

@implementation ExerciseDataMapper

- (NSDictionary *)dataMapping
{
    static NSDictionary *mapping = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        mapping = @{
                    @"name_pl": @"name_pl",
                    @"hidden": @"hidden",
                    @"deleted": @"removed",
                    @"downloaded": @"downloaded",
                    @"name_da": @"name_da",
                    @"photo_version": @"photoVersion",
                    @"custom": @"custom",
                    @"name_pt": @"name_pt",
                    @"oid": @"oid",
                    @"name_no": @"name_no",
                    @"name_sv": @"name_sv",
                    @"name_es": @"name_es",
                    @"name_ru": @"name_ru",
                    @"addedbyuser": @"addedByUser",
                    @"name_de": @"name_de",
                    @"title": @"title",
                    @"name_fr": @"name_fr",
                    @"name_nl": @"name_nl",
                    @"calories": @"calories",
                    @"name_it": @"name_it",
                    
                    };
    });
    return mapping;
}

- (void)mapData:(NSDictionary *)data ontoObject:(Exercise *)object error:(NSError **)error
{
    [super mapData:data ontoObject:object error:error];
    
    NSNumber *lastUpdated = [data objectForKey:@"lastupdated"];
    if (lastUpdated) {
        NSDate *lastUpdatedDate = [NSDate dateWithTimeIntervalSince1970:[lastUpdated integerValue]];
        object.lastUpdated = lastUpdatedDate;
    }
}


@end
