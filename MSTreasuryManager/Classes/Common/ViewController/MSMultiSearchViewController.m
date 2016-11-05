//
//  MSMultiSearchViewController.m
//  MSTreasuryManager
//
//  Created by 邓利文 on 2016/11/5.
//  Copyright © 2016年 邓利文. All rights reserved.
//

#import "MSMultiSearchViewController.h"
#import "MSNetworking+Material.h"
#import "MSStaffModel.h"

@interface MSMultiSearchViewController ()

@property (nonatomic, strong) NSArray *totalList;
@property (nonatomic, strong) NSMutableSet *selectedPersons;

@end

@implementation MSMultiSearchViewController

- (instancetype)initWithSearchType:(MSSearchType)type {
    if (self = [super init]) {
        _searchType = type;
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.selectedPersons = [NSMutableSet set];
    self.title = @"选择人员";
    // Do any additional setup after loading the view.
    self.tableView.allowsMultipleSelection = YES;
    [self setupSubmitButton];
    [self requestAllData];
}

- (void)setupSubmitButton {
    UIBarButtonItem *subMit = [[UIBarButtonItem alloc]initWithTitle:@"确定" style:(UIBarButtonItemStylePlain) target:self action:@selector(submitChose)];
    self.navigationItem.rightBarButtonItem = subMit;
}

- (void)requestAllData {

    [SVProgressHUD show];
    [MSNetworking getStaffListWithName:@"" pageNo:1 success:^(NSDictionary *object) {
        NSArray *list = [MSStaffModel mj_objectArrayWithKeyValuesArray:object[@"data"]];
        self.totalList = [NSMutableArray arrayWithArray:list];
        [self.tableView reloadData];
        [SVProgressHUD dismiss];
    } failure:^(NSError *error) {
        
        [SVProgressHUD dismiss];
        [SVProgressHUD showErrorWithStatus:@"获取数据失败"];
    }];
}

- (void)submitChose {
    if ([self.delegate respondsToSelector:@selector(searchViewController:didSelectSet:)]) {
        [self.delegate searchViewController:self.searchType didSelectSet:self.selectedPersons];
    }
    [self.navigationController popViewControllerAnimated:YES];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:kSearchCell];
    if (!cell) {
        cell = [[UITableViewCell alloc]initWithStyle:(UITableViewCellStyleDefault) reuseIdentifier:kSearchCell];
    }
    MSStaffModel *model = self.totalList[indexPath.row];
    [cell.textLabel setText:model.name];
    
    if ([self.selectedPersons containsObject:model.name]) {
        [cell setAccessoryType:(UITableViewCellAccessoryCheckmark)];
        [tableView selectRowAtIndexPath:indexPath animated:NO scrollPosition:(UITableViewScrollPositionNone)];
    }else {
        [cell setAccessoryType:(UITableViewCellAccessoryNone)];
        [tableView deselectRowAtIndexPath:indexPath animated:NO];
    }
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView cellForRowAtIndexPath:indexPath];
    MSStaffModel *model = self.totalList[indexPath.row];
    [self.selectedPersons addObject:model.name];
    [cell setAccessoryType:(UITableViewCellAccessoryCheckmark)];
}

- (void)tableView:(UITableView *)tableView didDeselectRowAtIndexPath:(nonnull NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView cellForRowAtIndexPath:indexPath];
    MSStaffModel *model = self.totalList[indexPath.row];
    [self.selectedPersons removeObject:model.name];
    [cell setAccessoryType:(UITableViewCellAccessoryNone)];
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.totalList.count;
}

@end
