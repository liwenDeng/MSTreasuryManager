//
//  MSTableViewController.h
//  MSTreasuryManager
//
//  Created by apple on 17/1/14.
//  Copyright © 2017年 邓利文. All rights reserved.
//

#import "MSBaseViewController.h"

@interface MSTableViewController : MSBaseViewController <UITableViewDelegate, UITableViewDataSource>

@property (nonatomic, strong) UITableView *tableView;

- (UITableViewStyle)tableViewStyle;

@end
