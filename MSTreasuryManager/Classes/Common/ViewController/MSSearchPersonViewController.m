//
//  MSSearchPersonViewController.m
//  MSTreasuryManager
//
//  Created by 邓利文 on 2016/10/24.
//  Copyright © 2016年 邓利文. All rights reserved.
//

#import "MSSearchPersonViewController.h"

@interface MSSearchPersonViewController ()

@end

@implementation MSSearchPersonViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)requestAllData {
    
}

- (void)requestSearchData {

}
#pragma mark - UITableViewDataSource
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (tableView == self.tableView) {
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:kSearchCell];
        if (!cell) {
            cell = [[UITableViewCell alloc]initWithStyle:(UITableViewCellStyleDefault) reuseIdentifier:kSearchCell];
        }
        [cell.textLabel setText:self.totalList[indexPath.row]];
        return cell;
    }else {
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:kResultCell];
        if (!cell) {
            cell = [[UITableViewCell alloc]initWithStyle:(UITableViewCellStyleDefault) reuseIdentifier:kResultCell];
        }
        [cell.textLabel setText:self.searchList[indexPath.row]];
        return cell;
    }
    
}

#pragma mark - UITableViewDelegate
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
}

#pragma mark - UISearchResultsUpdating
//展示搜索结果
-(void)updateSearchResultsForSearchController:(UISearchController *)searchController {
    
    NSString *searchString = [self.searchController.searchBar text];
    NSPredicate *preicate = [NSPredicate predicateWithFormat:@"SELF CONTAINS[c] %@", searchString];
    if (self.searchList!= nil) {
        [self.searchList removeAllObjects];
    }
    //过滤数据
    self.searchList= [NSMutableArray arrayWithArray:[self.totalList filteredArrayUsingPredicate:preicate]];
    
    [self.resultViewController.tableView reloadData];
}

#pragma mark - UISearchBarDelegate


@end
