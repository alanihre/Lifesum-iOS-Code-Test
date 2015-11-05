//
//  FoodCategoryDataMapper.h
//  Lifesum Code Test
//
//  Created by Alan Ihre on 2015-11-02.
//  Copyright © 2015 Ihre IT. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "DataMapper.h"
#import "FoodCategory.h"

@interface FoodCategoryDataMapper : DataMapper <DataMapperProtocol>

- (NSDictionary *)dataMapping;

- (void)mapData:(NSDictionary *)data ontoObject:(FoodCategory *)object error:(NSError **)error;

@end
