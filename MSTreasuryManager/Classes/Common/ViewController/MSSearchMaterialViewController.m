//
//  MSSearchMaterialNameViewController.m
//  MSTreasuryManager
//
//  Created by 邓利文 on 2016/10/25.
//  Copyright © 2016年 邓利文. All rights reserved.
//

#import "MSSearchMaterialViewController.h"
#import "MSNetworking+Material.h"

@interface MSSearchMaterialViewController () <MSHTTPRequestDelegate,MSCommonLoadMoreResultProtocol>

@property (nonatomic, assign) NSInteger resPageNo;

@end

@implementation MSSearchMaterialViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)loadMore {
    self.pageNo++;
    [MSNetworking getMaterialListWithName:@"" pageNo:self.pageNo success:^(NSDictionary *object) {
        
        [SVProgressHUD dismiss];
        NSArray *list = [MSMaterialModel mj_objectArrayWithKeyValuesArray:object[@"data"]];
        
        [self.tableView.mj_footer endRefreshing];
        if (list.count >= kPageSize) {
            [self.totalList addObjectsFromArray:list];
            [self.tableView reloadData];
        }else {
            [self.tableView.mj_footer endRefreshingWithNoMoreData];
        }

    } failure:^(NSError *error) {
        self.pageNo--;
        [SVProgressHUD showErrorWithStatus:@"获取数据失败"];
    }];
}

- (void)requestAllData {
    self.pageNo = 1;
    [SVProgressHUD show];
    [MSNetworking getMaterialListWithName:@"" pageNo:self.pageNo success:^(NSDictionary *object) {
        NSArray *list = [MSMaterialModel mj_objectArrayWithKeyValuesArray:object[@"data"]];
        self.totalList = [NSMutableArray arrayWithArray:list];
        [self.tableView reloadData];
        [SVProgressHUD dismiss];
    } failure:^(NSError *error) {
        
        [SVProgressHUD dismiss];
        [SVProgressHUD showErrorWithStatus:@"获取数据失败"];
    }];
}

#pragma mark - Search for result
- (void)requestSearchData {
    self.resultViewController.tableView.mj_footer.hidden = NO;
    self.resPageNo = 1;
    [SVProgressHUD show];
    [MSNetworking getMaterialListWithName:self.searchController.searchBar.text pageNo:self.resPageNo success:^(NSDictionary *object) {
        NSArray *list = [MSMaterialModel mj_objectArrayWithKeyValuesArray:object[@"data"]];
        self.searchList = [NSMutableArray arrayWithArray:list];
        [self.resultViewController.tableView reloadData];
        [SVProgressHUD dismiss];
    } failure:^(NSError *error) {
        
        [SVProgressHUD dismiss];
        [SVProgressHUD showErrorWithStatus:@"获取数据失败"];
    }];
}

- (void)loadMoreResult {
    self.resPageNo++;
    [MSNetworking getMaterialListWithName:self.searchController.searchBar.text pageNo:self.resPageNo success:^(NSDictionary *object) {
        
        [SVProgressHUD dismiss];
        NSArray *list = [MSMaterialModel mj_objectArrayWithKeyValuesArray:object[@"data"]];
        
        [self.resultViewController.tableView.mj_footer endRefreshing];
        if (list.count >= kPageSize) {
            [self.searchList addObjectsFromArray:list];
            [self.resultViewController.tableView reloadData];
        }else {
            [self.resultViewController.tableView.mj_footer endRefreshingWithNoMoreData];
        }
        
    } failure:^(NSError *error) {
        self.resPageNo--;
        [SVProgressHUD dismiss];
        [SVProgressHUD showErrorWithStatus:@"获取数据失败"];
    }];
}

#pragma mark - UITableViewDataSource
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (tableView == self.tableView) {
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:kSearchCell];
        if (!cell) {
            cell = [[UITableViewCell alloc]initWithStyle:(UITableViewCellStyleDefault) reuseIdentifier:kSearchCell];
        }
        MSMaterialModel *model = self.totalList[indexPath.row];
        [cell.textLabel setText:model.name];
        return cell;
    }else {
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:kResultCell];
        if (!cell) {
            cell = [[UITableViewCell alloc]initWithStyle:(UITableViewCellStyleDefault) reuseIdentifier:kResultCell];
        }
        MSMaterialModel *model = self.searchList[indexPath.row];
        [cell.textLabel setText:model.name];
        return cell;
    }
    
}

#pragma mark - UITableViewDelegate
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    if ([self.delegate respondsToSelector:@selector(searchViewController:didSelectModel:)]) {
        MSMaterialModel *model = nil;
        if (tableView == self.tableView) {
            model = self.totalList[indexPath.row];
        }else {
            model = self.searchList[indexPath.row];
        }
        [self.delegate searchViewController:self didSelectModel:model];
        [self.navigationController popViewControllerAnimated:YES];
    }
}

#pragma mark - UISearchResultsUpdating
//展示搜索结果
-(void)updateSearchResultsForSearchController:(UISearchController *)searchController {
    
    NSString *searchString = [self.searchController.searchBar text];
    NSPredicate *preicate = [NSPredicate predicateWithFormat:@"SELF.name CONTAINS[c] %@", searchString];
    if (self.searchList!= nil) {
        [self.searchList removeAllObjects];
    }
    //过滤数据
    self.searchList= [NSMutableArray arrayWithArray:[self.totalList filteredArrayUsingPredicate:preicate]];
    
    self.resultViewController.tableView.mj_footer.hidden = YES;
    [self.resultViewController.tableView.mj_footer resetNoMoreData];
    [self.resultViewController.tableView reloadData];
}

@end
