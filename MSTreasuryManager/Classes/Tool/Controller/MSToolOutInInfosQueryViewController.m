//
//  MSToolOutInInfosQueryViewController.m
//  MSTreasuryManager
//
//  Created by 邓利文 on 2016/10/20.
//  Copyright © 2016年 邓利文. All rights reserved.
//

#import "MSToolOutInInfosQueryViewController.h"
#import "MSBaseDatePickerView.h"
#import "MSNetworking+Tool.h"
#import "MSToolDetailViewController.h"

static NSString * const kToolInfoCell = @"toolInfoCell";
static NSString * const kToolResultInfoCell = @"toolResInfoCell";

typedef enum : NSUInteger {
    MSToolSearchTypeName = 0,
    MSToolSearchTypeDate,
} MSToolSearchType;

@interface MSToolOutInInfosQueryViewController () <MSHTTPRequestDelegate,MSCommonLoadMoreResultProtocol>

@property (nonatomic, assign) MSToolCellIndexOfType type;

@property (nonatomic, assign) NSInteger status;

@end

@implementation MSToolOutInInfosQueryViewController

- (instancetype)initWithType:(MSToolCellIndexOfType)type {
    if (self = [super init]) {
        _type = type;
        if (type == MSToolCellIndexOfTypeBorrowList) {
            _status = 1; //借用记录
        }else {
            _status = 0; //归还记录
        }
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = self.type == MSToolCellIndexOfTypeBorrowList ? @"借用记录查询" : @"归还记录查询";
    
    // Do any additional setup after loading the view.
}

- (void)requestAllData {
    self.pageNo = 1;
    [SVProgressHUD show];
    [MSNetworking getToolOutInList:@"" status:self.status success:^(NSDictionary *object) {
    
        NSArray *list = [MSToolModel mj_objectArrayWithKeyValuesArray:object[@"data"]];
        self.totalList = [NSMutableArray arrayWithArray:list];
        [self.tableView reloadData];
        [SVProgressHUD dismiss];
    } failure:^(NSError *error) {

        [SVProgressHUD dismiss];
        [SVProgressHUD showErrorWithStatus:@"获取数据失败"];
        
    }];
    
}

- (void)loadMore {
    self.pageNo++;
//    [MSNetworking getToolOutInList:@"" status:self.status success:^(NSDictionary *object) {
//        
//        NSArray *list = [MSToolModel mj_objectArrayWithKeyValuesArray:object[@"data"]];
//        [self.tableView.mj_footer endRefreshing];
//        if (list.count >= kPageSize) {
//            [self.totalList addObjectsFromArray:list];
//            [self.tableView reloadData];
//        }else {
//            [self.tableView.mj_footer endRefreshingWithNoMoreData];
//        }
//        
//        [SVProgressHUD dismiss];
//    } failure:^(NSError *error) {
//        self.pageNo--;
//        [SVProgressHUD showErrorWithStatus:@"获取数据失败"];
//    }];
    
    [MSNetworking getToolList:@"" status:self.status pageNo:self.pageNo success:^(NSDictionary *object) {
        NSArray *list = [MSToolModel mj_objectArrayWithKeyValuesArray:object[@"data"]];
        [self.tableView.mj_footer endRefreshing];
        if (list.count >= kPageSize) {
            [self.totalList addObjectsFromArray:list];
            [self.tableView reloadData];
        }else {
            [self.tableView.mj_footer endRefreshingWithNoMoreData];
        }
        
        [SVProgressHUD dismiss];
    } failure:^(NSError *error) {
        self.pageNo--;
        [SVProgressHUD showErrorWithStatus:@"获取数据失败"];
    }];
}


#pragma mark - Search for result
- (void)requestSearchData {
    self.searchPageNo = 1;
    self.resultViewController.tableView.mj_footer.hidden = NO;
    [SVProgressHUD show];
    [MSNetworking getToolOutInList:self.searchController.searchBar.text status:self.status success:^(NSDictionary *object) {
        NSArray *list = [MSToolModel mj_objectArrayWithKeyValuesArray:object[@"data"]];
        self.searchList = [NSMutableArray arrayWithArray:list];
        [self.resultViewController.tableView reloadData];
        [SVProgressHUD dismiss];
    } failure:^(NSError *error) {
        
        [SVProgressHUD dismiss];
        [SVProgressHUD showErrorWithStatus:@"获取数据失败"];
    }];
}

- (void)loadMoreResult {
    self.searchPageNo++;
    [MSNetworking getToolOutInList:self.searchController.searchBar.text status:self.status success:^(NSDictionary *object) {
        NSArray *list = [MSToolModel mj_objectArrayWithKeyValuesArray:object[@"data"]];
        [self.resultViewController.tableView.mj_footer endRefreshing];
        [SVProgressHUD dismiss];
        if (list.count >= kPageSize) {
            [self.searchList addObjectsFromArray:list];
            [self.resultViewController.tableView reloadData];
        }else {
            [self.resultViewController.tableView.mj_footer endRefreshingWithNoMoreData];
        }
    } failure:^(NSError *error) {
        
        self.searchPageNo--;
        [SVProgressHUD dismiss];
        [SVProgressHUD showErrorWithStatus:@"获取数据失败"];
    }];
}

#pragma mark - UITableViewDataSource
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (tableView == self.tableView) {
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:kSearchCell];
        if (!cell) {
            cell = [[UITableViewCell alloc]initWithStyle:(UITableViewCellStyleValue1) reuseIdentifier:kSearchCell];
        }
        MSToolModel *model = self.totalList[indexPath.row];
        cell.detailTextLabel.text = model.time;
        [cell.textLabel setText:model.name];
        return cell;
    }else {
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:kResultCell];
        if (!cell) {
            cell = [[UITableViewCell alloc]initWithStyle:(UITableViewCellStyleValue1) reuseIdentifier:kResultCell];
        }
        MSToolModel *model = self.searchList[indexPath.row];
        cell.detailTextLabel.text = model.time;
        [cell.textLabel setText:model.name];
        return cell;
    }
    
}

#pragma mark - UITableViewDelegate
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {

    MSToolModel *model = nil;
    if (tableView == self.tableView) {
        model = self.totalList[indexPath.row];
    }else {
        model = self.searchList[indexPath.row];
    }
    //借用记录-->借用详情
    //归还记录--> 归还详情
    MSToolDetailViewController *detail = [[MSToolDetailViewController alloc]initWithType:_status];
    detail.logId = model.toolId;
    [self.navigationController pushViewController:detail animated:YES];
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
