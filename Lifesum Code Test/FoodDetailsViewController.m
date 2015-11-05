//
//  FoodDetailsViewController.m
//  Lifesum Code Test
//
//  Created by Alan Ihre on 2015-11-04.
//  Copyright © 2015 Ihre IT. All rights reserved.
//

#import "FoodDetailsViewController.h"
#import "CustomNavigationController.h"
#import "BLKFlexibleHeightBar.h"
#import "SquareCashStyleBehaviorDefiner.h"
#import "ColorConstants.h"
#import "SquareCashStyleBar.h"
#import "DietDataService.h"

static const float ChartLineWidth = 5.0f;

@implementation FoodDetailsViewController

@synthesize food = _food;

#pragma mark - View Controller Lifecycle

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.view.backgroundColor = COLOR_LIFESUM_LIGHT_BEIGE;
    
    [self setupFlexibleBar];
    [self setupFoodScoreView];
    [self setupLabels];
    [self setupCharts];
    
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    [self.navigationController setNavigationBarHidden:YES animated:YES];
}

- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    
    [self.navigationController setNavigationBarHidden:NO animated:YES];
}

- (void)viewDidAppear:(BOOL)animated
{
    [(CustomNavigationController *)self.navigationController setPreventNavigationBarShowing:NO];
}

- (void)viewDidLayoutSubviews
{
    [super viewDidLayoutSubviews];
    
    CGFloat contentHeight = CGRectGetMaxY(self.potassiumLabel.frame) + 20;
    self.scrollView.contentSize = CGSizeMake(self.scrollView.frame.size.width, contentHeight);
}

- (void)closeViewController:(id)sender
{
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)setFood:(Food *)food
{
    _food = food;
    
    self.title = _food.title;
}

#pragma mark - Setup methods

- (void)setupFlexibleBar
{
    //Using SquareCashStyleBar provided with the BLKFlexibleHeightBar with some modifications made by me for this project
    SquareCashStyleBar *flexibleBar = [[SquareCashStyleBar alloc] initWithFrame:CGRectMake(0.0, 0.0, CGRectGetWidth(self.view.frame), 150.0) title:self.title];
    
    SquareCashStyleBehaviorDefiner *behaviorDefiner = [[SquareCashStyleBehaviorDefiner alloc] init];
    [behaviorDefiner addSnappingPositionProgress:0.0 forProgressRangeStart:0.0 end:0.5];
    [behaviorDefiner addSnappingPositionProgress:1.0 forProgressRangeStart:0.5 end:1.0];
    behaviorDefiner.snappingEnabled = YES;
    behaviorDefiner.elasticMaximumHeightAtTop = YES;
    flexibleBar.behaviorDefiner = behaviorDefiner;
    
    self.scrollView.delegate = (id<UIScrollViewDelegate>)flexibleBar.behaviorDefiner;
    
    [self.view addSubview:flexibleBar];
    
    // Add close button - it's pinned to the top left corner, so it doesn't need to respond to bar height changes
    UIButton *closeButton = [UIButton buttonWithType:UIButtonTypeCustom];
    closeButton.frame = CGRectMake(5.0, 25.0, 30.0, 30.0);
    closeButton.tintColor = [UIColor whiteColor];
    [closeButton setImage:[UIImage imageNamed:@"backArrow"] forState:UIControlStateNormal];
    [closeButton addTarget:self action:@selector(closeViewController:) forControlEvents:UIControlEventTouchUpInside];
    [flexibleBar addSubview:closeButton];
    
}

- (void)setupFoodScoreView
{
    float foodScore = [DietDataService calculateFoodScoreByFood:self.food];
    
    if (foodScore > 0) {
        self.ratingView.backgroundColor = [UIColor clearColor];
        self.ratingView.starImage = [UIImage imageNamed:@"star-template"];
        self.ratingView.starHighlightedImage = [UIImage imageNamed:@"star-highlighted-template"];
        self.ratingView.maxRating = 5.0;
        self.ratingView.horizontalMargin = 12;
        self.ratingView.editable = NO;
        self.ratingView.displayMode = EDStarRatingDisplayFull;
        self.ratingView.rating = foodScore;
    } else {
        self.ratingView.hidden = YES;
    }
}

- (void)setupLabels
{
    self.caloriesLabel.text = [NSString stringWithFormat:@"%ld kcal", (long)[_food.calories integerValue]];
    self.proteinLabel.text = [NSString stringWithFormat:@"%ld g", (long)[_food.protein integerValue]];
    self.carbohydratesLabel.text = [NSString stringWithFormat:@"%ld g", (long)[_food.carbohydrates integerValue]];
    self.fibersLabel.text = [NSString stringWithFormat:@"%ld g", (long)[_food.fiber integerValue]];
    self.sugarLabel.text = [NSString stringWithFormat:@"%ld g", (long)[_food.sugar integerValue]];
    self.fatLabel.text = [NSString stringWithFormat:@"%ld g", (long)[_food.fat integerValue]];
    self.saturatedFatLabel.text = [NSString stringWithFormat:@"%ld g", (long)[_food.saturatedFat integerValue]];
    self.unsaturatedFatLabel.text = [NSString stringWithFormat:@"%ld g", (long)[_food.unsaturatedFat integerValue]];
    self.cholesterolLabel.text = [NSString stringWithFormat:@"%ld g", (long)[_food.cholesterol integerValue]];
    self.sodiumLabel.text = [NSString stringWithFormat:@"%ld g", (long)[_food.sodium integerValue]];
    self.potassiumLabel.text = [NSString stringWithFormat:@"%ld g", (long)[_food.potassium integerValue]];

}

- (void)setupCharts
{
    
    //Using PNCharts for the circle charts in the view. The code for PNCharts has been modified by me to disable animations
    
    float carbohydratesWeight = [_food.carbohydrates floatValue];
    float proteinWeight = [_food.protein floatValue];
    float fatWeight = [_food.fat floatValue];

    float totalWeight = proteinWeight + carbohydratesWeight + fatWeight + [_food.cholesterol floatValue] + [_food.sodium floatValue] + [_food.potassium floatValue];
    
    float carbohydratesPercent = (carbohydratesWeight / totalWeight) * 100;
    float proteinPercent = (proteinWeight / totalWeight) * 100;
    float fatPercent = (fatWeight / totalWeight) * 100;

    [_carbohydratesChart removeFromSuperview];
    _carbohydratesChart = [[PNCircleChart alloc] initWithFrame:_carbohydratesChart.frame total:@(100) current:@(carbohydratesPercent) clockwise:YES shadow:YES shadowColor:PNGrey displayCountingLabel:YES overrideLineWidth:@(ChartLineWidth)];
    _carbohydratesChart.backgroundColor = [UIColor clearColor];
    [_carbohydratesChart setStrokeColor:PNBlack];
    [self.chartContainerView addSubview:_carbohydratesChart];
    [_carbohydratesChart strokeChart];
        
    [_proteinChart removeFromSuperview];
    _proteinChart = [[PNCircleChart alloc] initWithFrame:_proteinChart.frame total:@(100) current:@(proteinPercent) clockwise:YES shadow:YES shadowColor:PNGrey displayCountingLabel:YES overrideLineWidth:@(ChartLineWidth)];
    _proteinChart.backgroundColor = [UIColor clearColor];
    [_proteinChart setStrokeColor:PNBlack];
    [self.chartContainerView addSubview:_proteinChart];
    [_proteinChart strokeChart];
    
    [_fatChart removeFromSuperview];
    _fatChart = [[PNCircleChart alloc] initWithFrame:_fatChart.frame total:@(100) current:@(fatPercent) clockwise:YES shadow:YES shadowColor:PNGrey displayCountingLabel:YES overrideLineWidth:@(ChartLineWidth)];
    _fatChart.backgroundColor = [UIColor clearColor];
    [_fatChart setStrokeColor:PNBlack];
    [self.chartContainerView addSubview:_fatChart];
    [_fatChart strokeChart];
}

@end
