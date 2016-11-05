//
//  MSSearchStoreViewController.m
//  MSTreasuryManager
//
//  Created by 邓利文 on 2016/11/2.
//  Copyright © 2016年 邓利文. All rights reserved.
//

#import "MSSearchStoreViewController.h"

static NSString *const kNomalCellId = @"kNomalCellId";

@interface MSSearchStoreViewController ()

@property (nonatomic, strong) NSArray *stores;

@end

@implementation MSSearchStoreViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.title = @"选择位置";
    self.stores = [NSMutableArray arrayWithArray:@[@"二副库房",@"退库库房",@"系统库房"]];
    [self.tableView reloadData];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - UITableViewDataSource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.stores.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {

    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:kNomalCellId];
    if (!cell) {
        cell = [[UITableViewCell alloc]initWithStyle:(UITableViewCellStyleDefault) reuseIdentifier:kNomalCellId];
    }
    NSString *title = self.stores[indexPath.row];
    [cell.textLabel setText:title];
    return cell;
}

#pragma mark - UITableViewDelegate
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    if ([self.delegate respondsToSelector:@selector(searchViewController:didSelectDic:)]) {
        NSString *storeName = self.stores[indexPath.row];
        NSDictionary *dic = @{kPlaceNameKey:storeName,
                              kPlaceIdKey:@(indexPath.row+1)};
        [self.delegate searchViewController:-1 didSelectDic:dic];
        [self.navigationController popViewControllerAnimated:YES];
    }
}

@end
