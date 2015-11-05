//
//  FoodSearchResultsViewController.m
//  Lifesum Code Test
//
//  Created by Alan Ihre on 2015-11-04.
//  Copyright © 2015 Ihre IT. All rights reserved.
//

#import "FoodSearchResultsViewController.h"
#import "Food.h"
#import "StoryboardConstants.h"
#import "FoodDetailsViewController.h"
#import "FoodTableViewCell.h"

@implementation FoodSearchResultsViewController

#pragma mark - UITableViewDataSource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [self.searchResults count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    FoodTableViewCell *cell = [self.tableView dequeueReusableCellWithIdentifier:foodTableViewCell forIndexPath:indexPath];
    
    Food *food = [self.searchResults objectAtIndex:indexPath.row];
    [cell setFood:food];
    
    return cell;
    
}

@end
