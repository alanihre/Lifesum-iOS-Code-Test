//
//  ExerciseTableViewCell.m
//  Lifesum Code Test
//
//  Created by Alan Ihre on 2015-11-05.
//  Copyright © 2015 Ihre IT. All rights reserved.
//

#import "ExerciseTableViewCell.h"

@implementation ExerciseTableViewCell

@synthesize exercise = _exercise;

- (void)setExercise:(Exercise *)exercise
{
    _exercise = exercise;
    
    self.textLabel.text = [Exercise titleForExercise:_exercise byLanguageIdentifier:self.languageIdentifier];
    
}

@end
