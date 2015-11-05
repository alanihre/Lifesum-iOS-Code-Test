//
//  DietDataService.h
//  Lifesum Code Test
//
//  Created by Alan Ihre on 2015-11-05.
//  Copyright © 2015 Ihre IT. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Food.h"

@interface DietDataService : NSObject

+ (float)calculateFoodScoreByFood:(Food *)food;

@end
