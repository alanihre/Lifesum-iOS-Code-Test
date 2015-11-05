//
//  ExerciseDetailsViewController.m
//  Lifesum Code Test
//
//  Created by Alan Ihre on 2015-11-04.
//  Copyright © 2015 Ihre IT. All rights reserved.
//

#import "ExerciseDetailsViewController.h"
#import "BLKFlexibleHeightBar.h"
#import "SquareCashStyleBehaviorDefiner.h"
#import "ColorConstants.h"
#import "SquareCashStyleBar.h"
#import "CustomNavigationController.h"

@implementation ExerciseDetailsViewController

@synthesize exercise = _exercise;

#pragma mark - View Controller Lifecycle

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.view.backgroundColor = COLOR_LIFESUM_LIGHT_BEIGE;
    
    self.caloriesLabel.text = [NSString stringWithFormat:@"%ld kcal", (long)[_exercise.calories integerValue]];
    
    [self setupFlexibleBar];
    
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

- (void)closeViewController:(id)sender
{
    [self.navigationController popViewControllerAnimated:YES];
}

- (NSString *)currentLanguageIdentifierIfSupported
{
    NSString *languageIdentifier = [[NSLocale currentLocale] objectForKey:NSLocaleLanguageCode];
    BOOL currentLanguageSupported = [[Exercise supportedLanguages] containsObject:languageIdentifier];
    if (currentLanguageSupported) {
        return languageIdentifier;
    } else {
        return nil;
    }
}

- (void)setExercise:(Exercise *)exercise
{
    _exercise = exercise;
    
    self.title = [Exercise titleForExercise:_exercise byLanguageIdentifier:[self currentLanguageIdentifierIfSupported]];
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

@end
