//
//  MSBaseSearchTableViewController.m
//  MSTreasuryManager
//
//  Created by apple on 16/10/15.
//  Copyright © 2016年 邓利文. All rights reserved.
//

#import "MSBaseSearchTableViewController.h"

static NSString *const kSearchCell = @"SearchCell";
static NSString *const kResultCell = @"ResultCell";

@implementation MSBaseSearchTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.resultViewController = [[MSBaseSearchResultViewController alloc]init];
    self.searchController = [[UISearchController alloc]initWithSearchResultsController:self.resultViewController];
    
    self.resultViewController.tableView.dataSource = self;
    self.resultViewController.tableView.delegate = self;
    
    self.searchController.searchResultsUpdater = self;
    [self.searchController.searchBar sizeToFit];
    self.tableView.tableHeaderView = self.searchController.searchBar;
    
    self.searchController.delegate = self;
    self.searchController.dimsBackgroundDuringPresentation = NO; // default is YES
    self.searchController.searchBar.delegate = self; // so we can monitor text changes + others
    self.searchController.searchBar.enablesReturnKeyAutomatically = NO;
    self.definesPresentationContext = YES;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 0;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (tableView == self.tableView) {
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:kSearchCell];
        if (!cell) {
            cell = [[UITableViewCell alloc]initWithStyle:(UITableViewCellStyleDefault) reuseIdentifier:kSearchCell];
        }
        return cell;
    }else {
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:kResultCell];
        if (!cell) {
            cell = [[UITableViewCell alloc]initWithStyle:(UITableViewCellStyleDefault) reuseIdentifier:kResultCell];
        }
        return cell;
    }
    
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 44;
}

#pragma mark - UISearchControllerDelegate
- (void)presentSearchController:(UISearchController *)searchController {
    
}

- (void)willPresentSearchController:(UISearchController *)searchController {
    // do something before the search controller is presented
}

- (void)didPresentSearchController:(UISearchController *)searchController {
    // do something after the search controller is presented
}

- (void)willDismissSearchController:(UISearchController *)searchController {
    // do something before the search controller is dismissed
}

- (void)didDismissSearchController:(UISearchController *)searchController {
    // do something after the search controller is dismissed
    
    //搜索结束后是否重置选项
//    searchController.searchBar.selectedScopeButtonIndex = 0;
}

#pragma mark - UISearchBarDelegate
- (BOOL)searchBarShouldBeginEditing:(UISearchBar *)searchBar {
    return YES;
}

- (void)searchBarTextDidBeginEditing:(UISearchBar *)searchBar {

}

- (BOOL)searchBarShouldEndEditing:(UISearchBar *)searchBar {
    return YES;
}
- (void)searchBarTextDidEndEditing:(UISearchBar *)searchBar{

}

- (void)searchBar:(UISearchBar *)searchBar textDidChange:(NSString *)searchText{

}

- (BOOL)searchBar:(UISearchBar *)searchBar shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text {
    return YES;
}

- (void)searchBarSearchButtonClicked:(UISearchBar *)searchBar {

}

- (void)searchBarBookmarkButtonClicked:(UISearchBar *)searchBar{

}

- (void)searchBarCancelButtonClicked:(UISearchBar *)searchBar {

}

- (void)searchBarResultsListButtonClicked:(UISearchBar *)searchBar {

}

- (void)searchBar:(UISearchBar *)searchBar selectedScopeButtonIndexDidChange:(NSInteger)selectedScope {

}

#pragma mark - UISearchResultsUpdating
- (void)updateSearchResultsForSearchController:(UISearchController *)searchController {
//    [self.resultViewController.tableView reloadData];
}

@end
