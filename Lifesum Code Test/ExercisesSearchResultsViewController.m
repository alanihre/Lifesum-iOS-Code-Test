//
//  ExercisesSearchResultsViewController.m
//  Lifesum Code Test
//
//  Created by Alan Ihre on 2015-11-04.
//  Copyright © 2015 Ihre IT. All rights reserved.
//

#import "ExercisesSearchResultsViewController.h"
#import "Exercise.h"
#import "StoryboardConstants.h"
#import "ExerciseTableViewCell.h"

@implementation ExercisesSearchResultsViewController{
    NSString *_languageIdentifier;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    [self checkCurrentLanguageSupported];
}

- (void)checkCurrentLanguageSupported
{
    NSString *languageIdentifier = [[NSLocale currentLocale] objectForKey:NSLocaleLanguageCode];
    BOOL currentLanguageSupported = [[Exercise supportedLanguages] containsObject:languageIdentifier];
    if (currentLanguageSupported) {
        _languageIdentifier = languageIdentifier;
    } else {
        _languageIdentifier = nil;
    }
}

#pragma mark - UITableViewDataSource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [self.searchResults count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    ExerciseTableViewCell *cell = [self.tableView dequeueReusableCellWithIdentifier:exerciseTableViewCell forIndexPath:indexPath];
    
    Exercise *exercise = [self.searchResults objectAtIndex:indexPath.row];
    [cell setLanguageIdentifier:_languageIdentifier];
    [cell setExercise:exercise];
    
    return cell;
    
}

@end
