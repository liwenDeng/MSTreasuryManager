//
//  MSOutInInfosQueryViewController.m
//  MSTreasuryManager
//
//  Created by 邓利文 on 2016/10/13.
//  Copyright © 2016年 邓利文. All rights reserved.
//

#import "MSOutInInfosQueryViewController.h"
#import "MSBaseDatePickerView.h"

typedef enum : NSUInteger {
    MSSearchTypeName = 0,
    MSSearchTypeDate,
    MSSearchTypePerson,
} MSSearchType;

@interface MSOutInInfosQueryViewController () <UISearchBarDelegate, UISearchControllerDelegate, UISearchResultsUpdating,MSBaseDatePickerViewDelegate>

@property (nonatomic, assign) MSCellIndexOfType type;
@property (nonatomic, strong) UISearchController *searchController;
@property (nonatomic, strong) NSArray *searchList;
@property (nonatomic, strong) MSBaseDatePickerView *datePickerView;
@property (nonatomic, assign) MSSearchType currentSearchType;

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
    
    self.currentSearchType = MSSearchTypeName;
    self.searchController = [[UISearchController alloc]initWithSearchResultsController:nil];
    self.searchController.searchResultsUpdater = self;
    [self.searchController.searchBar sizeToFit];
    self.tableView.tableHeaderView = self.searchController.searchBar;
    
    self.searchController.delegate = self;
    self.searchController.dimsBackgroundDuringPresentation = NO; // default is YES
    self.searchController.searchBar.delegate = self; // so we can monitor text changes + others
    self.definesPresentationContext = YES;
    NSString *stitle = self.type == MSCellIndexOfTypeOutInfosQuery ? @"出库时间" : @"入库时间";
    self.searchController.searchBar.scopeButtonTitles = @[@"物资名称",stitle,@"经办人"];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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
    self.currentSearchType = type;
    switch (type) {
        case MSSearchTypeName:
        {
            [self hideDatePickerView];
            [searchBar becomeFirstResponder];
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
            [searchBar becomeFirstResponder];
        }
            break;
        default:
            break;
    }
}

- (BOOL)searchBarShouldBeginEditing:(UISearchBar *)searchBar {
    if (searchBar.selectedScopeButtonIndex == MSSearchTypeDate && !self.datePickerView.hidden) {
        return NO;
    }
    return YES;
}

- (void)searchBarTextDidBeginEditing:(UISearchBar *)searchBar {
    if (searchBar.selectedScopeButtonIndex == MSSearchTypeDate) {
        [self showDatePickerView];
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
}

#pragma mark - UISearchResultsUpdating
- (void)updateSearchResultsForSearchController:(UISearchController *)searchController {
    
}

#pragma mark - MSBaseDatePickerViewDelegate
- (void)datePickerView:(MSBaseDatePickerView *)datePicker submitWithDate:(NSDate *)date {
    NSLog(@"date:%@",date);
    [self hideDatePickerView];
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
        [self.searchController.searchBar endEditing:YES];
        self.datePickerView.hidden = NO;
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
