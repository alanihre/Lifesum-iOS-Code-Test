//
//  ExercisesViewController.m
//  Lifesum Code Test
//
//  Created by Alan Ihre on 2015-11-04.
//  Copyright © 2015 Ihre IT. All rights reserved.
//

#import "ExercisesViewController.h"
#import "DataStoreManager.h"
#import "Exercise.h"
#import "StoryboardConstants.h"
#import "ExercisesSearchResultsViewController.h"
#import "ExerciseDetailsViewController.h"
#import "ExerciseTableViewCell.h"
#import "CustomNavigationController.h"

@implementation ExercisesViewController{
    NSFetchedResultsController *_fetchedResultsController;
    BOOL _resultsFetchingPaused;
    UISearchController *_searchController;
    NSString *_languageAttributeName;
    NSString *_languageIdentifier;
    NSIndexPath *_selectedIndexPath;
}

#pragma mark - View Controller Lifecycle

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    [self checkCurrentLanguageSupported];
    [self setupFetchResultsController];
    [self setupSearchResultsController];
    
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

# pragma mark - Setup Methods

- (void)setupFetchResultsController
{
    NSFetchRequest *fetchRequest = [[NSFetchRequest alloc] initWithEntityName:@"Exercise"];
    
    fetchRequest.predicate = [Exercise predicateWithLanguageAttributeName:nil filteredByTitle:nil];
    
    NSSortDescriptor *sortDescriptorTitle = [NSSortDescriptor sortDescriptorWithKey:@"title" ascending:YES];
    if (_languageIdentifier) {
        NSSortDescriptor *sortDescriptorLocalized = [NSSortDescriptor sortDescriptorWithKey:_languageAttributeName ascending:YES];
        [fetchRequest setSortDescriptors:@[sortDescriptorLocalized, sortDescriptorTitle]];
    } else {
        [fetchRequest setSortDescriptors:@[sortDescriptorTitle]];
    }
    
    NSManagedObjectContext *managedObjectContext = [[DataStoreManager sharedManager] managedObjectContext];
    
    _fetchedResultsController = [[NSFetchedResultsController alloc] initWithFetchRequest:fetchRequest managedObjectContext:managedObjectContext sectionNameKeyPath:nil cacheName:nil];
    _fetchedResultsController.delegate = self;
    [_fetchedResultsController performFetch:NULL];
}

- (void)setupSearchResultsController
{
    
    ExercisesSearchResultsViewController *searchResultsViewController = [[self storyboard] instantiateViewControllerWithIdentifier:exercisesSearchResultsViewController];
        
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
    BOOL currentLanguageSupported = [[Exercise supportedLanguages] containsObject:languageIdentifier];
    if (currentLanguageSupported) {
        _languageAttributeName = [Exercise attributeNameForLanguageIdentifier:languageIdentifier];
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
    
    ExerciseTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:exerciseTableViewCell forIndexPath:indexPath];
    
    Exercise *exercise = [_fetchedResultsController objectAtIndexPath:indexPath];
    [cell setLanguageIdentifier:_languageIdentifier];
    [cell setExercise:exercise];
    
    return cell;
}

#pragma mark UITableViewDelegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    _selectedIndexPath = indexPath;
    [self performSegueWithIdentifier:showExerciseDetailsViewControllerSegue sender:self];
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    [super prepareForSegue:segue sender:sender];
    if ([segue.identifier isEqualToString:showExerciseDetailsViewControllerSegue]) {
        [(CustomNavigationController *)self.navigationController setPreventNavigationBarShowing:YES];
        ExerciseDetailsViewController *destinationViewController = segue.destinationViewController;
        Exercise *selectedItem = [self selectedItem];
        destinationViewController.exercise = selectedItem;
    }
}

- (void)hideNavBar
{
    [self.navigationController setNavigationBarHidden:YES animated:NO];
}

- (id)selectedItem
{
    if (_searchController.active) {
        ExercisesSearchResultsViewController *searchResultsViewController = (ExercisesSearchResultsViewController *)_searchController.searchResultsController;
        return _selectedIndexPath ? [searchResultsViewController.searchResults objectAtIndex:_selectedIndexPath.row] : nil;
    }else{
        return _selectedIndexPath ? [_fetchedResultsController objectAtIndexPath:_selectedIndexPath] : nil;
    }

}

#pragma mark - NSFetchedResultsControllerDelegate

- (void)controllerWillChangeContent:(NSFetchedResultsController*)controller
{
    [self.tableView beginUpdates];
}

- (void)controllerDidChangeContent:(NSFetchedResultsController*)controller
{
    [self.tableView endUpdates];
}

- (void)controller:(NSFetchedResultsController*)controller didChangeObject:(id)anObject atIndexPath:(NSIndexPath*)indexPath forChangeType:(NSFetchedResultsChangeType)type newIndexPath:(NSIndexPath*)newIndexPath
{
    if (type == NSFetchedResultsChangeInsert) {
        [self.tableView insertRowsAtIndexPaths:@[newIndexPath] withRowAnimation:UITableViewRowAnimationAutomatic];
    } else if (type == NSFetchedResultsChangeMove) {
        [self.tableView moveRowAtIndexPath:indexPath toIndexPath:newIndexPath];
    } else if (type == NSFetchedResultsChangeDelete) {
        [self.tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationAutomatic];
    } else {
        NSAssert(NO,@"");
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
    
    NSString *searchString = [_searchController.searchBar text];
    
    NSArray *searchResults = [self searchResultsForSearchString:searchString];
    
    ExercisesSearchResultsViewController *searchResultsViewController = (ExercisesSearchResultsViewController *)_searchController.searchResultsController;
    searchResultsViewController.searchResults = searchResults;
    [searchResultsViewController.tableView reloadData];

}

- (NSArray *)searchResultsForSearchString:(NSString *)searchText
{
    
    NSArray *searchResults = nil;
    
    if ((searchText == nil) || [searchText length] == 0) {
        searchResults = _fetchedResultsController.fetchedObjects;
    } else {
        //Searching in memory and not in Core Data since objects are already loaded into memory
        NSPredicate *predicate = [Exercise predicateWithLanguageAttributeName:_languageAttributeName filteredByTitle:searchText];
        searchResults = [_fetchedResultsController.fetchedObjects filteredArrayUsingPredicate:predicate];
    }

    return searchResults;

}

#pragma mark UISearchControllerDelegate

- (void)willPresentSearchController:(UISearchController *)searchController
{
    ExercisesSearchResultsViewController *searchResultsViewController = (ExercisesSearchResultsViewController *)_searchController.searchResultsController;
    searchResultsViewController.tableView.delegate = self;
}

@end
