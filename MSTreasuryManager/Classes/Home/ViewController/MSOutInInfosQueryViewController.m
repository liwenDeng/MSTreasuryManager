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
@property (nonatomic, strong) NSArray *searchList;
@property (nonatomic, strong) MSBaseDatePickerView *datePickerView;
@property (nonatomic, strong) MSSearchResultViewController *resultViewController;

@end

@implementation MSOutInInfosQueryViewController

- (instancetype)initWithType:(MSCellIndexOfType)type {
    if (self = [super init]) {
        self.type = type;
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
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
    NSString *stitle = self.type == MSCellIndexOfTypeOutInfosQuery ? @"出库时间" : @"入库时间";
    self.searchController.searchBar.scopeButtonTitles = @[@"物资名称",stitle,@"经办人"];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - HTTP Request
- (void)loadMore {
    
}

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
        return 10;
    }
    return 2;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (tableView == self.tableView) {
        MSOutInInfoCell *cell = [tableView dequeueReusableCellWithIdentifier:kCellIdentifier];
        if (!cell) {
            cell = [[MSOutInInfoCell alloc]initWithStyle:(UITableViewCellStyleDefault) reuseIdentifier:kCellIdentifier];
        }
        return cell;
    }
    
    MSOutInInfoCell *cell = [tableView dequeueReusableCellWithIdentifier:kResCellIdentifier];
    if (!cell) {
        cell = [[MSOutInInfoCell alloc]initWithStyle:(UITableViewCellStyleDefault) reuseIdentifier:kResCellIdentifier];
    }
    return cell;

}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 46;
}

#pragma mark - UITableViewDelegate
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    NSLog(@"clicked");
    MSOutInInfoDetailViewController *vc = [[MSOutInInfoDetailViewController alloc]initWithType:self.type];
    [self.navigationController pushViewController:vc animated:YES];
}

#pragma mark - UISearchBarDelegate
- (void)searchBarSearchButtonClicked:(UISearchBar *)searchBar {
    [self hideDatePickerView];
}

- (void)searchBarCancelButtonClicked:(UISearchBar *)searchBar {
    [self hideDatePickerView];
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
    searchController.searchBar.selectedScopeButtonIndex = 0;
}

#pragma mark - UISearchResultsUpdating
- (void)updateSearchResultsForSearchController:(UISearchController *)searchController {
    [self.resultViewController.tableView reloadData];
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
                make.top.equalTo(self.mas_bottomLayoutGuideBottom).offset(-200);
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
                make.top.equalTo(self.mas_bottomLayoutGuideBottom).offset(0);
            }];
            [self.view layoutIfNeeded];
        } completion:^(BOOL finished) {
            self.datePickerView.hidden = YES;
        }];
    }
}

@end
