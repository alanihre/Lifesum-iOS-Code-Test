//
//  FoodTableViewCell.m
//  Lifesum Code Test
//
//  Created by Alan Ihre on 2015-11-05.
//  Copyright © 2015 Ihre IT. All rights reserved.
//

#import "FoodTableViewCell.h"

@implementation FoodTableViewCell

@synthesize food = _food;

- (void)setFood:(Food *)food
{
    _food = food;
    
    self.textLabel.text = _food.title;
    
    if (_food.calories) {
        self.detailTextLabel.text = [NSString stringWithFormat:@"%ld kcal", (long)[_food.calories integerValue]];
    }else{
        self.detailTextLabel.text = nil;
    }

}

@end
