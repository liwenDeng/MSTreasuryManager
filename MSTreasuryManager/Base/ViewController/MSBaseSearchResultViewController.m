//
//  MSBaseSearchResultViewController.m
//  MSTreasuryManager
//
//  Created by apple on 16/10/15.
//  Copyright © 2016年 邓利文. All rights reserved.
//

#import "MSBaseSearchResultViewController.h"

@interface MSBaseSearchResultViewController ()

@end

@implementation MSBaseSearchResultViewController

- (instancetype)init {
    if (self = [super init]) {
        _tableView = [[UITableView alloc]initWithFrame:self.view.bounds style:(UITableViewStylePlain)];
        [self.view addSubview:_tableView];
    }
    return self;
}

@end
