//
//  FoodCategoryTableViewCell.m
//  Lifesum Code Test
//
//  Created by Alan Ihre on 2015-11-05.
//  Copyright © 2015 Ihre IT. All rights reserved.
//

#import "FoodCategoryTableViewCell.h"

@implementation FoodCategoryTableViewCell

@synthesize foodCategory = _foodCategory;

- (void)setFoodCategory:(FoodCategory *)foodCategory
{
    _foodCategory = foodCategory;
    
    self.textLabel.text = [FoodCategory categoryTitleForFoodCategory:_foodCategory byLanguageIdentifier:self.languageIdentifier];

}

@end
