//
//  MSSearchTableViewController.m
//  MSTreasuryManager
//
//  Created by apple on 16/10/10.
//  Copyright © 2016年 邓利文. All rights reserved.
//

#import "MSSearchTableViewController.h"
#import "MSSearchResultViewController.h"

@interface MSSearchTableViewController() <UITableViewDataSource,UITableViewDelegate,UISearchControllerDelegate,UISearchResultsUpdating,UISearchBarDelegate>

@property (nonatomic, strong) MSSearchResultViewController *resultViewController;
@property (nonatomic, strong) UISearchController *searchController;

@property (nonatomic, strong) NSMutableArray *dataList;
@property (nonatomic, strong) NSMutableArray *searchList;
@property (nonatomic, strong) NSString *cureHistoryDeleteBtnString; //删除按钮字样

@end

@implementation MSSearchTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.

    //    self.tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 20, kSCREEN_WIDTH, kSCREENH_HEIGHT)];

    
    [self createSearch];
    
    NSArray *arr1 = @[@"1",@"2",@"3",@"4",@"5",@"6",@"7",@"8",@"9",@"10",@"11",@"12"];
    NSArray *arr2 = @[];
    
    self.dataList = [NSMutableArray arrayWithArray:arr1];//数据数组
    self.searchList = [NSMutableArray arrayWithArray:arr2];//search到的数组
    
}

- (void)dealloc {
    [self.searchController.view removeFromSuperview];
}

#pragma mark- TableView

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 60;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}

//设置区域的行数
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    if (tableView == self.tableView) {
        //        _tableView.hidden = NO;
        return [self.dataList count];
    }else{
        //        _tableView.hidden = YES;
        return [self.searchList count];
    }
}

//返回单元格内容
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{

    
    if (tableView == self.tableView) {
        static NSString *flag=@"cellFlag";
        UITableViewCell *cell=[tableView dequeueReusableCellWithIdentifier:flag];
        
        if (cell==nil) {
            cell=[[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:flag];
            //取消选中状态
            //        [cell setSelectionStyle:UITableViewCellSelectionStyleNone];
            cell.backgroundColor = [UIColor colorWithRed:arc4random()%255/256.0f green:arc4random()%255/256.0f  blue:arc4random()%255/256.0f  alpha:1];
        }

        [cell.textLabel setText:self.dataList[indexPath.row]];
        return cell;
    }else {
        static NSString *flag=@"resultCellFlag";
        UITableViewCell *cell=[tableView dequeueReusableCellWithIdentifier:flag];
        
        if (cell==nil) {
            cell=[[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:flag];
            //取消选中状态
            //        [cell setSelectionStyle:UITableViewCellSelectionStyleNone];
            cell.backgroundColor = [UIColor colorWithRed:arc4random()%255/256.0f green:arc4random()%255/256.0f  blue:arc4random()%255/256.0f  alpha:1];
        }

        [cell.textLabel setText:self.searchList[indexPath.row]];
        return cell;
    }

}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    self.searchController.active = NO;
    [self.navigationController popViewControllerAnimated:YES];

}

#pragma mark- SearchController
- (void)createSearch{
    
    self.resultViewController = [[MSSearchResultViewController alloc]init];
    self.resultViewController.tableView.delegate = self;
    self.resultViewController.tableView.dataSource = self;
    
    self.searchController = [[UISearchController alloc] initWithSearchResultsController:self.resultViewController];
    self.searchController.searchResultsUpdater = self;
    self.searchController.delegate = self;
    self.searchController.searchBar.delegate = self;
    
    self.searchController.dimsBackgroundDuringPresentation = NO;//是否添加半透明覆盖层
    self.searchController.hidesNavigationBarDuringPresentation = YES;//是否隐藏导航栏
    self.definesPresentationContext = YES;

    [self.searchController.searchBar sizeToFit];
//    self.searchController.searchBar.frame = CGRectMake(self.searchController.searchBar.frame.origin.x, self.searchController.searchBar.frame.origin.y, self.searchController.searchBar.frame.size.width, 44.0);
    self.tableView.tableHeaderView = self.searchController.searchBar;
    
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
    self.searchList= [NSMutableArray arrayWithArray:[self.dataList filteredArrayUsingPredicate:preicate]];
    
    [self.resultViewController.tableView reloadData];
}

//
#pragma mark - UISearchControllerDelegate
- (void)willPresentSearchController:(UISearchController *)searchController
{
    NSLog(@"willPresentSearchController");
}

- (void)didPresentSearchController:(UISearchController *)searchController
{
    NSLog(@"didPresentSearchController");
}

- (void)willDismissSearchController:(UISearchController *)searchController
{
    NSLog(@"willDismissSearchController");
}

- (void)didDismissSearchController:(UISearchController *)searchController
{
    NSLog(@"didDismissSearchController");
}

- (void)presentSearchController:(UISearchController *)searchController
{
    NSLog(@"presentSearchController");
}

#pragma mark - UISearchBarDelegate
-(BOOL)searchBarShouldBeginEditing:(UISearchBar *)searchBar{
    NSLog(@"开始编辑");
    return YES;
}

-(BOOL)searchBarShouldEndEditing:(UISearchBar *)searchBar{
    NSLog(@"结束编辑");
    return YES;
}

-(BOOL)searchBar:(UISearchBar *)searchBar shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text{
    NSLog(@"正在编辑");
    return YES;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
