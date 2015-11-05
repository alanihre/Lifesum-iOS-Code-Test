//
//  ExerciseDetailsViewController.h
//  Lifesum Code Test
//
//  Created by Alan Ihre on 2015-11-04.
//  Copyright © 2015 Ihre IT. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import <CoreData/CoreData.h>
#import "Exercise.h"

@interface ExerciseDetailsViewController : UIViewController

@property (strong, nonatomic) IBOutlet UIScrollView *scrollView;
@property (nonatomic, strong) Exercise *exercise;
@property (strong, nonatomic) IBOutlet UILabel *caloriesLabel;

@end
