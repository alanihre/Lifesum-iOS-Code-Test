//
//  FoodCategoryViewController.m
//  Lifesum Code Test
//
//  Created by Alan Ihre on 2015-11-03.
//  Copyright © 2015 Ihre IT. All rights reserved.
//

#import "FoodCategoryViewController.h"
#import "DataImporter.h"
#import <SVProgressHUD.h>
#import "DataStoreManager.h"
#import "FoodCategory.h"
#import "StoryboardConstants.h"
#import "FoodViewController.h"
#import "FoodSearchResultsViewController.h"
#import "FoodDetailsViewController.h"
#import "FoodCategoryTableViewCell.h"
#import "CustomNavigationController.h"

@implementation FoodCategoryViewController{
    NSFetchedResultsController *_fetchedResultsController;
    BOOL _resultsFetchingPaused;
    UISearchController *_searchController;
    NSString *_languageAttributeName;
    NSString *_languageIdentifier;
}

#pragma mark - View Controller Lifecycle

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    [self checkCurrentLanguageSupported];
    [self setupFetchResultsController];
    [self setupSearchResultsController];
    
    if (![self dataImported]) {
        [self importData];
    }
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    [self setResultsFetchingPaused:NO];
}

- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    
    [self setResultsFetchingPaused:YES];
}

- (void)dealloc
{
    //To fix iOS 9 bug in UISearchController's dealloc function that deallocs some gestures which in turn calls loadView on the view controller
    [_searchController.view removeFromSuperview];
}

#pragma mark - Data Import

- (BOOL)dataImported
{
    return [[[NSUserDefaults standardUserDefaults] objectForKey:@"DataImported"] boolValue];
}

- (void)importData
{
    [SVProgressHUD showWithStatus:NSLocalizedString(@"importing_data_hud_text", nil) maskType:SVProgressHUDMaskTypeGradient];
    
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^(void){
        
        __block NSError *importError;
        DataImporter *dataImporter = [DataImporter new];
        [dataImporter import:&importError];
        
        dispatch_async(dispatch_get_main_queue(), ^(void){
            
            if(importError){
                [SVProgressHUD showErrorWithStatus:@"Error when importing data"];
                NSLog(@"Import error: %@", importError);
            } else {
                NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
                [userDefaults setObject:@(YES) forKey:@"DataImported"];
                [userDefaults synchronize];
                
                [SVProgressHUD dismiss];
            }
            
        });
        
    });
}

# pragma mark - Setup Methods

- (void)setupFetchResultsController
{
    NSFetchRequest *fetchRequest = [[NSFetchRequest alloc] initWithEntityName:@"FoodCategory"];
    
    NSSortDescriptor *sortDescriptorCategory = [NSSortDescriptor sortDescriptorWithKey:@"category" ascending:YES];
    if (_languageIdentifier) {
        NSSortDescriptor *sortDescriptorLocalized = [NSSortDescriptor sortDescriptorWithKey:_languageAttributeName ascending:YES];
        [fetchRequest setSortDescriptors:@[sortDescriptorLocalized, sortDescriptorCategory]];
    } else {
        [fetchRequest setSortDescriptors:@[sortDescriptorCategory]];
    }

    NSManagedObjectContext *managedObjectContext = [[DataStoreManager sharedManager] managedObjectContext];
    
    _fetchedResultsController = [[NSFetchedResultsController alloc] initWithFetchRequest:fetchRequest managedObjectContext:managedObjectContext sectionNameKeyPath:nil cacheName:nil];
    _fetchedResultsController.delegate = self;
    [_fetchedResultsController performFetch:NULL];
}

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
        _languageAttributeName = [FoodCategory attributeNameForLanguageIdentifier:languageIdentifier];
        _languageIdentifier = languageIdentifier;
    } else {
        _languageAttributeName = nil;
        _languageIdentifier = nil;
    }
}

#pragma mark - UITableViewDataSource

- (NSInteger)numberOfSectionsInTableView:(UITableView*)tableView
{
    return _fetchedResultsController.sections.count;
}

- (NSInteger)tableView:(UITableView*)tableView numberOfRowsInSection:(NSInteger)sectionIndex
{
    id<NSFetchedResultsSectionInfo> section = _fetchedResultsController.sections[sectionIndex];
    return section.numberOfObjects;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    FoodCategoryTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:foodCategoryTableViewCell forIndexPath:indexPath];
    
    FoodCategory *foodCategory = [_fetchedResultsController objectAtIndexPath:indexPath];
    [cell setLanguageIdentifier:_languageIdentifier];
    [cell setFoodCategory:foodCategory];
    
    return cell;
}

#pragma mark UITableViewDelegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (_searchController.isActive) {
        [self performSegueWithIdentifier:showFoodDetailsViewControllerFromFoodCategoryViewControllerSearchResults sender:self];
    }
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}

- (id)selectedItem
{
    if (_searchController.active) {
        FoodSearchResultsViewController *searchResultsViewController = (FoodSearchResultsViewController *)_searchController.searchResultsController;
        NSIndexPath *indexPath = searchResultsViewController.tableView.indexPathForSelectedRow;
        return indexPath ? [searchResultsViewController.searchResults objectAtIndex:indexPath.row] : nil;
    }else{
        NSIndexPath *indexPath = self.tableView.indexPathForSelectedRow;
        return indexPath ? [_fetchedResultsController objectAtIndexPath:indexPath] : nil;
    }
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    [super prepareForSegue:segue sender:sender];
    
    if ([segue.identifier isEqualToString:showFoodViewControllerSegue]) {
        FoodViewController *destinationViewController = segue.destinationViewController;
        destinationViewController.foodCategory = [self selectedItem];
    }else if ([segue.identifier isEqualToString:showFoodDetailsViewControllerFromFoodCategoryViewControllerSearchResults]) {
        [(CustomNavigationController *)self.navigationController setPreventNavigationBarShowing:YES];
        FoodDetailsViewController *destinationViewController = segue.destinationViewController;
        destinationViewController.food = [self selectedItem];
    }
}

#pragma mark - NSFetchedResultsControllerDelegate

- (void)controllerWillChangeContent:(NSFetchedResultsController *)controller
{
    [self.tableView beginUpdates];
}

- (void)controllerDidChangeContent:(NSFetchedResultsController *)controller
{
    [self.tableView endUpdates];
}

- (void)controller:(NSFetchedResultsController *)controller didChangeObject:(id)anObject atIndexPath:(NSIndexPath *)indexPath forChangeType:(NSFetchedResultsChangeType)type newIndexPath:(NSIndexPath *)newIndexPath
{
    if (type == NSFetchedResultsChangeInsert) {
        [self.tableView insertRowsAtIndexPaths:@[newIndexPath] withRowAnimation:UITableViewRowAnimationAutomatic];
    } else if (type == NSFetchedResultsChangeMove) {
        [self.tableView moveRowAtIndexPath:indexPath toIndexPath:newIndexPath];
    } else if (type == NSFetchedResultsChangeDelete) {
        [self.tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationAutomatic];
    }
}

- (void)setResultsFetchingPaused:(BOOL)paused
{
    if (paused == _resultsFetchingPaused) {
        return;
    }
    _resultsFetchingPaused = paused;
    
    if (paused) {
        _fetchedResultsController.delegate = nil;
    } else {
        _fetchedResultsController.delegate = self;
        [_fetchedResultsController performFetch:NULL];
        [self.tableView reloadData];
    }
}

#pragma mark - UISearchResultsUpdating

- (void)updateSearchResultsForSearchController:(UISearchController *)searchController
{
    
    //Search results controller should always be shown when searching is active, even when the search string is empty
    searchController.searchResultsController.view.hidden = NO;

    NSString *searchString = [_searchController.searchBar text];
    
    NSArray *searchResults = [self searchResultsForSearchString:searchString];
    
    FoodSearchResultsViewController *searchResultsViewController = (FoodSearchResultsViewController *)_searchController.searchResultsController;
    searchResultsViewController.searchResults = searchResults;
    [searchResultsViewController.tableView reloadData];
    
}

- (NSArray *)searchResultsForSearchString:(NSString *)searchText
{
    
    NSFetchRequest *fetchRequest = [NSFetchRequest fetchRequestWithEntityName:[Food entityName]];
    
    NSArray *searchResults = nil;
    
    if ([searchText length] == 0) {
        searchText = nil;
    }
    
    fetchRequest.predicate = [Food predicateWithLanguageIdentifier:_languageIdentifier filteredByTitle:searchText];
    
    [fetchRequest setSortDescriptors:@[[NSSortDescriptor sortDescriptorWithKey:@"title" ascending:YES]]];
    
    NSManagedObjectContext *managedObjectContext = [[DataStoreManager sharedManager] managedObjectContext];
    NSError *error;
    searchResults = [managedObjectContext executeFetchRequest:fetchRequest error:&error];
    
    return searchResults;
    
}

#pragma mark UISearchControllerDelegate

- (void)willPresentSearchController:(UISearchController *)searchController
{
    FoodSearchResultsViewController *searchResultsViewController = (FoodSearchResultsViewController *)_searchController.searchResultsController;
    searchResultsViewController.view.hidden = NO;
    searchResultsViewController.tableView.delegate = self;
}

- (void)didPresentSearchController:(UISearchController *)searchController
{
    searchController.searchResultsController.view.hidden = NO;
}

@end
