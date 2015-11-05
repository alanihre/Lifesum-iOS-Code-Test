//
//  DataMapper.m
//  Lifesum Code Test
//
//  Created by Alan Ihre on 2015-11-01.
//  Copyright © 2015 Ihre IT. All rights reserved.
//

#import "DataMapper.h"

@implementation DataMapper

NSString * const kDataMapperErrorDomain = @"com.lifesumCodeTest.DataMapper";

- (id)init
{
    
    self = [super init];
    
    if (self) {
        NSAssert([self conformsToProtocol:@protocol(DataMapperProtocol)], @"%@ does not conform to the DataMapperProtocol protocol", [self class]);
    }
    
    return self;
    
}

- (void)mapData:(NSDictionary *)data ontoObject:(NSObject *)object error:(NSError **)error
{
    
    if (!data) {
        *error = [NSError errorWithDomain:kDataMapperErrorDomain code:100 userInfo:@{NSLocalizedDescriptionKey: @"Data argument is nil"}];
        return;
    }
    if (!object) {
        *error = [NSError errorWithDomain:kDataMapperErrorDomain code:101 userInfo:@{NSLocalizedDescriptionKey: @"Object argument is nil"}];
        return;
    }
        
    NSDictionary *mapping = [self performSelector:@selector(dataMapping)];
    
    [mapping enumerateKeysAndObjectsUsingBlock:^(NSString *dataKey, NSString *objectKey, BOOL *stop) {
        id value = [data objectForKey:dataKey];
        if (value) {
            if ([value isEqual:[NSNull null]]) {
                return;
            }
            [object setValue:value forKey:objectKey];
        }
    }];
    
}

@end
