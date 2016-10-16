//
//  MSBaseSearchTableViewController.h
//  MSTreasuryManager
//
//  Created by apple on 16/10/15.
//  Copyright © 2016年 邓利文. All rights reserved.
//

#import "MSBaseTableViewController.h"
#import "MSBaseSearchResultViewController.h"

@interface MSBaseSearchTableViewController : MSBaseTableViewController <UISearchBarDelegate, UISearchControllerDelegate, UISearchResultsUpdating>

@property (nonatomic, strong) UISearchController *searchController;
@property (nonatomic, strong) MSBaseSearchResultViewController *resultViewController;

@end
