//
//  FoodViewController.m
//  Lifesum Code Test
//
//  Created by Alan Ihre on 2015-11-03.
//  Copyright © 2015 Ihre IT. All rights reserved.
//

#import "FoodViewController.h"
#import "DataStoreManager.h"
#import "Food.h"
#import "StoryboardConstants.h"
#import "FoodDetailsViewController.h"
#import "FoodSearchResultsViewController.h"
#import "FoodTableViewCell.h"
#import "CustomNavigationController.h"

@implementation FoodViewController{
    NSArray *_food;
    UISearchController *_searchController;
    NSString *_languageIdentifier;
    NSIndexPath *_selectedIndexPath;
}

@synthesize foodCategory = _foodCategory;

#pragma mark - View Controller Lifecycle

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    [self checkCurrentLanguageSupported];
    [self setupSearchResultsController];

}

- (void)dealloc
{
    //To fix iOS 9 bug in UISearchController's dealloc function that deallocs some gestures which in turn calls loadView on the view controller
    [_searchController.view removeFromSuperview];
}

- (void)setFoodCategory:(FoodCategory *)foodCategory
{
    _foodCategory = foodCategory;
    
    [self checkCurrentLanguageSupported];
    
    self.title = [FoodCategory categoryTitleForFoodCategory:_foodCategory byLanguageIdentifier:_languageIdentifier];
    
    _food = [_foodCategory.food allObjects];
    NSPredicate *predicate = [Food predicateWithLanguageIdentifier:_languageIdentifier filteredByTitle:nil];
    _food = [_food filteredArrayUsingPredicate:predicate];
    
    NSSortDescriptor *sortDescription = [NSSortDescriptor sortDescriptorWithKey:@"title" ascending:YES];
    _food = [_food sortedArrayUsingDescriptors:@[sortDescription]];
    
    [self.tableView reloadData];
}

# pragma mark - Setup Methods

- (void)setupSearchResultsController
{
    
    FoodSearchResultsViewController *searchResultsViewController = [[self storyboard] instantiateViewControllerWithIdentifier:foodSearchResultsViewController];
    
    _searchController = [[UISearchController alloc] initWithSearchResultsController:searchResultsViewController];
    
    _searchController.searchResultsUpdater = self;
    _searchController.delegate = self;
    
    _searchController.dimsBackgroundDuringPresentation = NO;
    
    [_searchController.searchBar sizeToFit];
    
    self.tableView.tableHeaderView = _searchController.searchBar;
    
    self.definesPresentationContext = YES;
    
}

- (void)checkCurrentLanguageSupported
{
    NSString *languageIdentifier = [[NSLocale currentLocale] objectForKey:NSLocaleLanguageCode];
    BOOL currentLanguageSupported = [[FoodCategory supportedLanguages] containsObject:languageIdentifier];
    if (currentLanguageSupported) {
        _languageIdentifier = languageIdentifier;
    } else {
        _languageIdentifier = nil;
    }
}


#pragma mark - UITableViewDataSource

- (NSInteger)tableView:(UITableView*)tableView numberOfRowsInSection:(NSInteger)sectionIndex
{
    return _food.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    FoodTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:foodTableViewCell forIndexPath:indexPath];
    
    Food *food = [_food objectAtIndex:indexPath.row];
    [cell setFood:food];
    
    return cell;
}

#pragma mark UITableViewDelegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    _selectedIndexPath = indexPath;
    [self performSegueWithIdentifier:showFoodDetailsViewControllerSegue sender:self];
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}

- (id)selectedItem
{
    if (_searchController.active) {
        FoodSearchResultsViewController *searchResultsViewController = (FoodSearchResultsViewController *)_searchController.searchResultsController;
        return _selectedIndexPath ? [searchResultsViewController.searchResults objectAtIndex:_selectedIndexPath.row] : nil;
    } else {
        return _selectedIndexPath ? [_food objectAtIndex:_selectedIndexPath.row] : nil;
    }
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    [super prepareForSegue:segue sender:sender];
    if ([segue.identifier isEqualToString:showFoodDetailsViewControllerSegue]) {
        [(CustomNavigationController *)self.navigationController setPreventNavigationBarShowing:YES];
        FoodDetailsViewController *destinationViewController = segue.destinationViewController;
        destinationViewController.food = [self selectedItem];
    }
}

#pragma mark - UISearchResultsUpdating

- (void)updateSearchResultsForSearchController:(UISearchController *)searchController
{
        
    NSString *searchString = [_searchController.searchBar text];
    
    NSArray *searchResults = [self searchResultsForSearchString:searchString];
    
    FoodSearchResultsViewController *searchResultsViewController = (FoodSearchResultsViewController *)_searchController.searchResultsController;
    searchResultsViewController.searchResults = searchResults;
    [searchResultsViewController.tableView reloadData];
    
}

- (NSArray *)searchResultsForSearchString:(NSString *)searchText
{
    
    NSArray *searchResults = nil;
    
    if ((searchText == nil) || [searchText length] == 0) {
        searchResults = _food;
    } else {
        //Searching in memory and not in Core Data since objects are already loaded into memory
        NSPredicate *predicate = [Food predicateWithLanguageIdentifier:_languageIdentifier filteredByTitle:searchText];
        
        searchResults = [_food filteredArrayUsingPredicate:predicate];
    }
    
    return searchResults;
    
}
#pragma mark UISearchControllerDelegate

- (void)willPresentSearchController:(UISearchController *)searchController
{
    FoodSearchResultsViewController *searchResultsViewController = (FoodSearchResultsViewController *)_searchController.searchResultsController;
    searchResultsViewController.tableView.delegate = self;
}

@end
