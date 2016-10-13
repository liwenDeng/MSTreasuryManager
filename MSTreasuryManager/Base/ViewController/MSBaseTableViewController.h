//
//  MSBaseTableViewController.h
//  MSTreasuryManager
//
//  Created by 邓利文 on 2016/10/13.
//  Copyright © 2016年 邓利文. All rights reserved.
//

#import "MSBaseViewController.h"
#import <MJRefresh.h>

@interface MSBaseTableViewController : MSBaseViewController <UITableViewDelegate,UITableViewDataSource>

@property (nonatomic, strong) UITableView *tableView;

@end
