//
//  MSCommonSearchViewController.m
//  MSTreasuryManager
//
//  Created by 邓利文 on 2016/10/17.
//  Copyright © 2016年 邓利文. All rights reserved.
//

#import "MSCommonSearchViewController.h"

@interface MSCommonSearchViewController ()

@end

@implementation MSCommonSearchViewController

- (instancetype)initWithSearchType:(MSSearchType)type {
    if (self = [super init]) {
        _searchType = type;
        _totalList = [NSMutableArray array];
        _searchList = [NSMutableArray array];
        _pageNo = 1;
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self requestAllData];
    
    if ([self respondsToSelector:@selector(loadMoreResult)]) {
        self.resultViewController.tableView.mj_footer = [MJRefreshAutoNormalFooter footerWithRefreshingTarget:self refreshingAction:@selector(loadMoreResult)];
    }
}

- (void)requestAllData {
    //test code
    NSArray *arr1 = @[@"1",@"2",@"3",@"4",@"5",@"6",@"7",@"8",@"9",@"10",@"11",@"12"];
    NSArray *arr2 = @[];
    
    self.totalList = [NSMutableArray arrayWithArray:arr1];//数据数组
    self.searchList = [NSMutableArray arrayWithArray:arr2];//search到的数组
}

- (void)requestSearchData {
    
}

#pragma mark - UITableViewDataSource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if (tableView == self.tableView) {
        return _totalList.count;
    }
    return _searchList.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (tableView == self.tableView) {
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:kSearchCell];
        if (!cell) {
            cell = [[UITableViewCell alloc]initWithStyle:(UITableViewCellStyleDefault) reuseIdentifier:kSearchCell];
        }
        [cell.textLabel setText:self.totalList[indexPath.row]];
        return cell;
    }else {
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:kResultCell];
        if (!cell) {
            cell = [[UITableViewCell alloc]initWithStyle:(UITableViewCellStyleDefault) reuseIdentifier:kResultCell];
        }
        [cell.textLabel setText:self.searchList[indexPath.row]];
        return cell;
    }
    
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 44;
}

#pragma mark - UITableViewDelegate
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
}

#pragma mark - UISearchResultsUpdating
//展示搜索结果
-(void)updateSearchResultsForSearchController:(UISearchController *)searchController {
    
    NSString *searchString = [self.searchController.searchBar text];
    NSPredicate *preicate = [NSPredicate predicateWithFormat:@"SELF CONTAINS[c] %@", searchString];
    if (self.searchList!= nil) {
        [self.searchList removeAllObjects];
    }
    //过滤数据
    self.searchList= [NSMutableArray arrayWithArray:[self.totalList filteredArrayUsingPredicate:preicate]];
    
    [self.resultViewController.tableView reloadData];
}

#pragma mark - UISearchBarDelegate
- (void)searchBarSearchButtonClicked:(UISearchBar *)searchBar {
    NSLog(@"开始搜索");
    [self requestSearchData];
}

@end
