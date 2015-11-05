//
//  FoodCategoryViewController.h
//  Lifesum Code Test
//
//  Created by Alan Ihre on 2015-11-03.
//  Copyright © 2015 Ihre IT. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import <CoreData/CoreData.h>

@interface FoodCategoryViewController : UIViewController <UITableViewDelegate, UITableViewDataSource, NSFetchedResultsControllerDelegate, UISearchControllerDelegate, UISearchResultsUpdating>

@property (strong, nonatomic) IBOutlet UITableView *tableView;

@property (nonatomic, strong) UISearchController *searchController;

@end
