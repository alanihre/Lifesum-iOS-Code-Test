//
//  FoodViewController.h
//  Lifesum Code Test
//
//  Created by Alan Ihre on 2015-11-03.
//  Copyright © 2015 Ihre IT. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import <CoreData/CoreData.h>
#import "FoodCategory.h"

@interface FoodViewController : UIViewController <UITableViewDelegate, UITableViewDataSource, NSFetchedResultsControllerDelegate, UISearchControllerDelegate, UISearchResultsUpdating>

@property (nonatomic, strong) IBOutlet UITableView *tableView;
@property (nonatomic, strong) FoodCategory *foodCategory;
@property (nonatomic, strong) UISearchController *searchController;

@end
