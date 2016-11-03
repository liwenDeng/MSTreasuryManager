//
//  MSSearchResultViewController.m
//  MSTreasuryManager
//
//  Created by 邓利文 on 2016/10/13.
//  Copyright © 2016年 邓利文. All rights reserved.
//

#import "MSSearchResultViewController.h"

@interface MSSearchResultViewController ()

@end

@implementation MSSearchResultViewController

- (instancetype)init {
    if (self = [super init]) {
        _tableView = [[UITableView alloc]initWithFrame:self.view.bounds style:(UITableViewStylePlain)];
        [self.view addSubview:_tableView];
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
