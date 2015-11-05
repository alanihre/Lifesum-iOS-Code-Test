//
//  FoodCategoryTableViewCell.h
//  Lifesum Code Test
//
//  Created by Alan Ihre on 2015-11-05.
//  Copyright © 2015 Ihre IT. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import "FoodCategory.h"

@interface FoodCategoryTableViewCell : UITableViewCell

@property (nonatomic, strong) FoodCategory *foodCategory;
@property (nonatomic, strong) NSString *languageIdentifier;

@end
