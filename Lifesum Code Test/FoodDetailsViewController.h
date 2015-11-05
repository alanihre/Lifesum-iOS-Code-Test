//
//  FoodDetailsViewController.h
//  Lifesum Code Test
//
//  Created by Alan Ihre on 2015-11-04.
//  Copyright © 2015 Ihre IT. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import <CoreData/CoreData.h>
#import "Food.h"
#import <EDStarRating.h>
#import "PNCircleChart.h"

@interface FoodDetailsViewController : UIViewController

@property (nonatomic, strong) Food *food;
@property (strong, nonatomic) IBOutlet UIScrollView *scrollView;
@property (strong, nonatomic) IBOutlet UILabel *caloriesLabel;
@property (strong, nonatomic) IBOutlet EDStarRating *ratingView;
@property (strong, nonatomic) IBOutlet UILabel *proteinLabel;
@property (strong, nonatomic) IBOutlet UILabel *carbohydratesLabel;
@property (strong, nonatomic) IBOutlet UILabel *fibersLabel;
@property (strong, nonatomic) IBOutlet UILabel *sugarLabel;
@property (strong, nonatomic) IBOutlet UILabel *fatLabel;
@property (strong, nonatomic) IBOutlet UILabel *unsaturatedFatLabel;
@property (strong, nonatomic) IBOutlet UILabel *saturatedFatLabel;
@property (strong, nonatomic) IBOutlet UILabel *cholesterolLabel;
@property (strong, nonatomic) IBOutlet UILabel *sodiumLabel;
@property (strong, nonatomic) IBOutlet UILabel *potassiumLabel;
@property (strong, nonatomic) IBOutlet PNCircleChart *carbohydratesChart;
@property (strong, nonatomic) IBOutlet PNCircleChart *proteinChart;
@property (strong, nonatomic) IBOutlet PNCircleChart *fatChart;
@property (strong, nonatomic) IBOutlet UIView *chartContainerView;

@end
