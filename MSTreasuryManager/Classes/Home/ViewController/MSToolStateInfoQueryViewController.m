//
//  MSToolStateInfoQueryViewController.m
//  MSTreasuryManager
//
//  Created by apple on 16/10/14.
//  Copyright © 2016年 邓利文. All rights reserved.
//

#import "MSToolStateInfoQueryViewController.h"

static NSString *const kToolInfoCell = @"ToolInfoCell";
static NSString *const kToolResultInfoCell = @"ToolResultInfoCell";

typedef enum : NSUInteger {
    MSToolSearchTypeName = 0,
    MSToolSearchTypeInStore,
    MSToolSearchTypeOutStore,
} MSToolSearchType;

@interface MSToolStateInfoQueryViewController ()

@property (nonatomic, strong) NSArray *dataList;
@property (nonatomic, strong) NSArray *resultList;

@end

@implementation MSToolStateInfoQueryViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"工器具状态查询";
    self.searchController.searchBar.scopeButtonTitles = @[@"工具名称",@"在库",@"借出"];
}
#pragma mark - UITableViewDataSource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
//    return 10;
    if (tableView == self.tableView) {
        return 20;
    }
    return 10;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (tableView == self.tableView) {
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:kToolInfoCell];
        if (!cell) {
            cell = [[UITableViewCell alloc]initWithStyle:(UITableViewCellStyleDefault) reuseIdentifier:kToolInfoCell];
        }
        cell.textLabel.text = @"全部内容";
        return cell;
    }else {
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:kToolResultInfoCell];
        if (!cell) {
            cell = [[UITableViewCell alloc]initWithStyle:(UITableViewCellStyleDefault) reuseIdentifier:kToolResultInfoCell];
        }
        cell.textLabel.text = @"筛选内容";
        return cell;
    }

}

#pragma mark - UITableViewDelegate
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
}

-(void)searchBar:(UISearchBar *)searchBar selectedScopeButtonIndexDidChange:(NSInteger)selectedScope {
    MSToolSearchType type = selectedScope;
    switch (type) {
        case MSToolSearchTypeName:
        {
            searchBar.text = nil;
        }
            break;
        case MSToolSearchTypeInStore:
        {
            searchBar.text = @"在库";
        }
            break;
        case MSToolSearchTypeOutStore:
        {
            searchBar.text = @"借出";
        }
            break;
        default:
            break;
    }
}

- (void)updateSearchResultsForSearchController:(UISearchController *)searchController {
    //    self.resultViewController.tableView.hidden = YES;
    
}

- (void)didDismissSearchController:(UISearchController *)searchController {
    //搜索结束后是否重置选项
    searchController.searchBar.selectedScopeButtonIndex = 0;
}
@end
