//
//  MSToolOutInInfosQueryViewController.m
//  MSTreasuryManager
//
//  Created by 邓利文 on 2016/10/20.
//  Copyright © 2016年 邓利文. All rights reserved.
//

#import "MSToolOutInInfosQueryViewController.h"
#import "MSBaseDatePickerView.h"

static NSString * const kToolInfoCell = @"toolInfoCell";
static NSString * const kToolResultInfoCell = @"toolResInfoCell";

typedef enum : NSUInteger {
    MSToolSearchTypeName = 0,
    MSToolSearchTypeDate,
} MSToolSearchType;

@interface MSToolOutInInfosQueryViewController () <MSBaseDatePickerViewDelegate>

@property (nonatomic, strong) MSBaseDatePickerView *datePickerView;
@property (nonatomic, assign) MSToolCellIndexOfType type;

@end

@implementation MSToolOutInInfosQueryViewController

- (instancetype)initWithType:(MSToolCellIndexOfType)type {
    if (self = [super init]) {
        _type = type;
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = self.type == MSToolCellIndexOfTypeBorrowList ? @"借出记录查询" : @"借入记录查询";
    
    self.searchController.searchBar.scopeButtonTitles = @[@"工具名称",@"时间"];
    // Do any additional setup after loading the view.
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


#pragma mark - UISearchBarDelegate
- (void)searchBarSearchButtonClicked:(UISearchBar *)searchBar {
    [self hideDatePickerView];
}

- (void)searchBarCancelButtonClicked:(UISearchBar *)searchBar {
    [self hideDatePickerView];
}

- (void)searchBar:(UISearchBar *)searchBar selectedScopeButtonIndexDidChange:(NSInteger)selectedScope {
    MSToolSearchType type = selectedScope;
    switch (type) {
        case MSToolSearchTypeName:
        {
            searchBar.text = nil;
            [self hideDatePickerView];
        }
            break;
        case MSToolSearchTypeDate:
        {
            searchBar.text = @"";
            [self showDatePickerView];
        }
    }
}

- (void)updateSearchResultsForSearchController:(UISearchController *)searchController {
    //    self.resultViewController.tableView.hidden = YES;
    
}

- (void)didDismissSearchController:(UISearchController *)searchController {
    //搜索结束后是否重置选项
    searchController.searchBar.selectedScopeButtonIndex = 0;
}

#pragma mark - MSBaseDatePickerViewDelegate
- (void)datePickerView:(MSBaseDatePickerView *)datePicker submitWithDate:(NSDate *)date {
    NSLog(@"date:%@",date);
    [self hideDatePickerView];
    self.searchController.searchBar.text = @"2015-09-01";
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
            make.height.mas_equalTo(200);
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
