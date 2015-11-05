//
//  ExerciseTableViewCell.h
//  Lifesum Code Test
//
//  Created by Alan Ihre on 2015-11-05.
//  Copyright © 2015 Ihre IT. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import "Exercise.h"

@interface ExerciseTableViewCell : UITableViewCell

@property (nonatomic, strong) Exercise *exercise;
@property (nonatomic, strong) NSString *languageIdentifier;

@end
