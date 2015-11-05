//
//  FoodDataMapper.h
//  Lifesum Code Test
//
//  Created by Alan Ihre on 2015-11-01.
//  Copyright © 2015 Ihre IT. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "DataMapper.h"
#import "Food.h"

@interface FoodDataMapper : DataMapper <DataMapperProtocol>

- (NSDictionary *)dataMapping;

- (void)mapData:(NSDictionary *)data ontoObject:(Food *)object error:(NSError **)error;

@end
