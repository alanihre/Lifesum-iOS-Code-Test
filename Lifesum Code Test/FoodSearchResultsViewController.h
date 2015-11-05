//
//  FoodSearchResultsViewController.h
//  Lifesum Code Test
//
//  Created by Alan Ihre on 2015-11-04.
//  Copyright © 2015 Ihre IT. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface FoodSearchResultsViewController : UIViewController <UITableViewDataSource>

@property (nonatomic, strong) IBOutlet UITableView *tableView;
@property (nonatomic, strong) NSArray *searchResults;

@end
