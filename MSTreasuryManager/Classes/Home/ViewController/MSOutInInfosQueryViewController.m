//
//  MSOutInInfosQueryViewController.m
//  MSTreasuryManager
//
//  Created by 邓利文 on 2016/10/13.
//  Copyright © 2016年 邓利文. All rights reserved.
//

#import "MSOutInInfosQueryViewController.h"
#import "MSBaseDatePickerView.h"
#import "MSOutInInfoCell.h"
#import "MSSearchResultViewController.h"
#import "MSOutInInfoDetailViewController.h"
#import "MSNetworking+Material.h"

typedef enum : NSUInteger {
    MSSearchTypeName = 0,
    MSSearchTypeDate,
    MSSearchTypePerson,
} MSSearchType;

static NSString * const kCellIdentifier = @"OutInInfosQuery";
static NSString * const kResCellIdentifier = @"OutInInfosResult";

@interface MSOutInInfosQueryViewController () <UISearchBarDelegate, UISearchControllerDelegate, UISearchResultsUpdating,MSBaseDatePickerViewDelegate>

@property (nonatomic, assign) MSCellIndexOfType type;
@property (nonatomic, strong) UISearchController *searchController;
@property (nonatomic, strong) MSBaseDatePickerView *datePickerView;
@property (nonatomic, strong) MSSearchResultViewController *resultViewController;

@property (nonatomic, strong) NSMutableArray *totalList;
@property (nonatomic, strong) NSMutableArray *searchList;

@property (nonatomic, assign) NSInteger queryCate;
@property (nonatomic, assign) NSInteger pageNo;
@property (nonatomic, assign) NSInteger searchPageNo;

@end

@implementation MSOutInInfosQueryViewController

- (void)dealloc {
    [self.searchController.view removeFromSuperview];
}

- (instancetype)initWithType:(MSCellIndexOfType)type {
    if (self = [super init]) {
        self.type = type;
        if (type == MSCellIndexOfTypeInInfosQuery) {
            self.queryCate = 1;
        }else {
            self.queryCate = 2;
        }
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // Do any additional setup after loading the view.
    self.totalList = [NSMutableArray array];
    self.searchList = [NSMutableArray array];
    self.pageNo = 1;
    self.searchPageNo = 1;
    
    NSString *title = self.type == MSCellIndexOfTypeOutInfosQuery ? @"出库记录查询" : @"入库记录查询";
    self.title = title;
    self.resultViewController = [[MSSearchResultViewController alloc]init];
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
    
    //搜索页添加上拉搜更多
    self.resultViewController.tableView.mj_footer = [MJRefreshAutoNormalFooter footerWithRefreshingTarget:self refreshingAction:@selector(loadMoreResult)];
    
    [self loadAllData];
    
//    NSString *stitle = self.type == MSCellIndexOfTypeOutInfosQuery ? @"出库时间" : @"入库时间";
//    self.searchController.searchBar.scopeButtonTitles = @[@"物资名称",stitle,@"经办人"];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - HTTP Request
- (void)loadAllData {
    self.pageNo = 1;
    [SVProgressHUD show];
    [MSNetworking getMaterialOutInListWithName:@"" cate:self.queryCate pageNo:self.pageNo success:^(NSDictionary *object) {
        NSArray *list = [MSMaterialOutInModel mj_objectArrayWithKeyValuesArray:object[@"data"]];
        self.totalList = [NSMutableArray arrayWithArray:list];
        [self.tableView reloadData];
        [SVProgressHUD dismiss];
    } failure:^(NSError *error) {
        [SVProgressHUD showErrorWithStatus:@"获取数据失败"];
    }];
}

- (void)loadMore {
    self.pageNo++;
    [MSNetworking getMaterialOutInListWithName:@"" cate:self.queryCate pageNo:self.pageNo success:^(NSDictionary *object) {
        NSArray *list = [MSMaterialOutInModel mj_objectArrayWithKeyValuesArray:object[@"data"]];

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

- (void)loadSearchData {
    self.resultViewController.tableView.mj_footer.hidden = NO;
    self.searchPageNo = 1;
    
    [MSNetworking getMaterialOutInListWithName:self.searchController.searchBar.text cate:self.queryCate pageNo:self.searchPageNo success:^(NSDictionary *object) {
        NSArray *list = [MSMaterialOutInModel mj_objectArrayWithKeyValuesArray:object[@"data"]];
        
        self.searchList = [NSMutableArray arrayWithArray:list];
        [self.resultViewController.tableView reloadData];
 
        [SVProgressHUD dismiss];
    } failure:^(NSError *error) {
        [SVProgressHUD showErrorWithStatus:@"获取数据失败"];
    }];
}

- (void)loadMoreResult {
    self.searchPageNo++;
    
    [MSNetworking getMaterialListWithName:self.searchController.searchBar.text pageNo:self.searchPageNo success:^(NSDictionary *object) {
        [self.resultViewController.tableView.mj_footer endRefreshing];
        [SVProgressHUD dismiss];
        
        NSArray *list = [MSMaterialOutInModel mj_objectArrayWithKeyValuesArray:object[@"data"]];
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

//
- (void)searchWithProductName:(NSString *)productName {

}

- (void)searchWithDate:(NSString *)date {

}

- (void)searchWithPersonName:(NSString *) personName {

}

#pragma mark - UITableViewDataSource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if (tableView == self.tableView) {
        return self.totalList.count;
    }
    return self.searchList.count;;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (tableView == self.tableView) {
        MSOutInInfoCell *cell = [tableView dequeueReusableCellWithIdentifier:kCellIdentifier];
        if (!cell) {
            cell = [[MSOutInInfoCell alloc]initWithStyle:(UITableViewCellStyleDefault) reuseIdentifier:kCellIdentifier];
        }
        MSMaterialOutInModel *model = self.totalList[indexPath.row];
        [cell fillWithOutInModel:model];
        return cell;
    }
    
    MSOutInInfoCell *cell = [tableView dequeueReusableCellWithIdentifier:kResCellIdentifier];
    if (!cell) {
        cell = [[MSOutInInfoCell alloc]initWithStyle:(UITableViewCellStyleDefault) reuseIdentifier:kResCellIdentifier];
    }
    MSMaterialOutInModel *model = self.searchList[indexPath.row];
    [cell fillWithOutInModel:model];
    return cell;

}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 48;
}

#pragma mark - UITableViewDelegate
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    MSOutInInfoDetailViewController *vc = [[MSOutInInfoDetailViewController alloc]initWithType:self.type];
    MSMaterialOutInModel *model = self.totalList[indexPath.row];
    if (tableView != self.tableView) {
        model = self.searchList[indexPath.row];
    }
    vc.materialId = model.materialId;
    vc.materialName = model.materialName;
    
    [self.navigationController pushViewController:vc animated:YES];
}

#pragma mark - UISearchBarDelegate
- (void)searchBarSearchButtonClicked:(UISearchBar *)searchBar {
//    [self hideDatePickerView];
    NSLog(@"开始搜索");
    [self loadSearchData];
}

- (void)searchBarCancelButtonClicked:(UISearchBar *)searchBar {
//    [self hideDatePickerView];
}

- (void)searchBar:(UISearchBar *)searchBar selectedScopeButtonIndexDidChange:(NSInteger)selectedScope {
    MSSearchType type = selectedScope;
    switch (type) {
        case MSSearchTypeName:
        {
            [self hideDatePickerView];
        }
            break;
        case MSSearchTypeDate:
        {
            [self showDatePickerView];
        }
            break;
        case MSSearchTypePerson:
        {
            [self hideDatePickerView];
        }
            break;
        default:
            break;
    }
}

#pragma mark - UISearchControllerDelegate
- (void)didDismissSearchController:(UISearchController *)searchController {
    // do something after the search controller is dismissed
    searchController.searchBar.selectedScopeButtonIndex = 0;
}

#pragma mark - UISearchResultsUpdating
- (void)updateSearchResultsForSearchController:(UISearchController *)searchController {
    NSString *searchString = [self.searchController.searchBar text];
    NSPredicate *preicate = [NSPredicate predicateWithFormat:@"SELF.materialName CONTAINS[c] %@", searchString];
    if (self.searchList!= nil) {
        [self.searchList removeAllObjects];
    }
    //过滤数据
    self.searchList= [NSMutableArray arrayWithArray:[self.totalList filteredArrayUsingPredicate:preicate]];
    
    self.resultViewController.tableView.mj_footer.hidden = YES;
    [self.resultViewController.tableView.mj_footer resetNoMoreData];
    [self.resultViewController.tableView reloadData];
}

#pragma mark - MSBaseDatePickerViewDelegate
- (void)datePickerView:(MSBaseDatePickerView *)datePicker submitWithDate:(NSDate *)date {
    NSLog(@"date:%@",date);
    [self hideDatePickerView];
//    self.searchController.searchBar.text = @"2015-09-01";
}

- (void)datePickerView:(MSBaseDatePickerView *)datePicker cancleWithDate:(NSDate *)date {
    [self hideDatePickerView];
}

#pragma mark - LazyLoad
- (MSBaseDatePickerView *)datePickerView {
    if (!_datePickerView) {
        _datePickerView = [[MSBaseDatePickerView alloc]init];
        [self.view addSubview:_datePickerView];
        
        [_datePickerView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(0);
            make.top.equalTo(self.mas_bottomLayoutGuideBottom);
            make.width.mas_equalTo(kSCREEN_WIDTH);
            make.height.mas_equalTo(240);
        }];
        _datePickerView.delegate = self;
        _datePickerView.hidden = YES;
        [self.view layoutIfNeeded];
    }
    return _datePickerView;
}

- (void)showDatePickerView {
    if (self.datePickerView.hidden) {
        self.datePickerView.hidden = NO;
        [self.searchController.searchBar resignFirstResponder];
        [UIView animateWithDuration:0.3 delay:0 options:(UIViewAnimationOptionCurveEaseOut) animations:^{
            [self.datePickerView mas_updateConstraints:^(MASConstraintMaker *make) {
                make.top.equalTo(self.mas_bottomLayoutGuideTop).offset(-244);
            }];
            [self.view layoutIfNeeded];
        } completion:^(BOOL finished) {
            
        }];
    }
}

- (void)hideDatePickerView {
    if (!self.datePickerView.hidden) {
        [self.searchController.searchBar becomeFirstResponder];
        [UIView animateWithDuration:0.3 delay:0 options:(UIViewAnimationOptionCurveEaseIn) animations:^{
            [self.datePickerView mas_updateConstraints:^(MASConstraintMaker *make) {
                make.top.equalTo(self.mas_bottomLayoutGuideTop).offset(0);
            }];
            [self.view layoutIfNeeded];
        } completion:^(BOOL finished) {
            self.datePickerView.hidden = YES;
        }];
    }
}

@end
