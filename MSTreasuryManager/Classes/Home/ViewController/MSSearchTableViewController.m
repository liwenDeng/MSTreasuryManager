//
//  MSSearchTableViewController.m
//  MSTreasuryManager
//
//  Created by apple on 16/10/10.
//  Copyright © 2016年 邓利文. All rights reserved.
//

#import "MSSearchTableViewController.h"

@interface MSSearchTableViewController() <UITableViewDataSource,UITableViewDelegate,UISearchControllerDelegate,UISearchResultsUpdating,UISearchBarDelegate>

@property (nonatomic, strong) UISearchController *searchController;
@property (nonatomic, strong) UITableView* tableView;
@property (nonatomic, strong) NSMutableArray *dataList;
@property (nonatomic, strong) NSMutableArray *searchList;
@property (nonatomic, strong) NSString *cureHistoryDeleteBtnString; //删除按钮字样

@end

@implementation MSSearchTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.

    self.tableView = [[UITableView alloc]initWithFrame:self.view.bounds];
    //    self.tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 20, kSCREEN_WIDTH, kSCREENH_HEIGHT)];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    [self.view addSubview:self.tableView ];
    
    [self createSearch];
    
    NSArray *arr1 = @[@"1",@"2",@"3",@"4",@"5",@"6",@"7",@"8",@"9",@"10",@"11",@"12"];
    NSArray *arr2 = @[];
    
    self.dataList = [NSMutableArray arrayWithArray:arr1];//数据数组
    self.searchList = [NSMutableArray arrayWithArray:arr2];//search到的数组
    
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
    
    if (self.searchController.active) {
        //        _tableView.hidden = NO;
        return [self.searchList count];
    }else{
        //        _tableView.hidden = YES;
        return [self.dataList count];
    }
}

//返回单元格内容
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *flag=@"cellFlag";
    UITableViewCell *cell=[tableView dequeueReusableCellWithIdentifier:flag];
    if (cell==nil) {
        cell=[[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:flag];
        //取消选中状态
        //        [cell setSelectionStyle:UITableViewCellSelectionStyleNone];
        cell.backgroundColor = [UIColor colorWithRed:arc4random()%255/256.0f green:arc4random()%255/256.0f  blue:arc4random()%255/256.0f  alpha:1];
    }
    if (self.searchController.active) {
        //        _tableView.hidden = NO;
        [cell.textLabel setText:self.searchList[indexPath.row]];
    }
    else{
        //        _tableView.hidden = YES;
        [cell.textLabel setText:self.dataList[indexPath.row]];
    }
    //
    
    
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
//    SecondViewController *sec = [[SecondViewController alloc] init];
//    if (_searchList.count != 0) {
//        sec.number = _searchList[indexPath.row];
//    }else{
//        sec.number = _dataList[indexPath.row];
//    }
//    //_searchController.active = NO;
//    //这样的话就可以实现下边跳转到sec页面的方法了，因为取消了它的活跃，能看到有个动作是直接回到了最初的界面，然后才执行的跳转方法
//    NSLog(@"sec.number = %@",sec.number);
//    //下边这五个方法貌似没什么卵用。会在此时同时打印出来
//    [self willPresentSearchController:_searchController];
//    [self didPresentSearchController:_searchController];
//    [self willDismissSearchController:_searchController];
//    [self didDismissSearchController:_searchController];
//    [self presentSearchController:_searchController];
//    [self.searchController dismissViewControllerAnimated:YES completion:^{
//        [self.navigationController popViewControllerAnimated:YES];
//    }];
//    self.searchController.active = NO;
    [self.navigationController popViewControllerAnimated:YES];
    [self.searchController dismissViewControllerAnimated:NO completion:nil];
//    if (self.searchController.active) {
//        [self.searchController dismissViewControllerAnimated:NO completion:nil];
//    }
}

// 6.添加多个按钮在Cell
- (NSArray *)tableView:(UITableView *)tableView editActionsForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    self.cureHistoryDeleteBtnString = @"删除";
    // 添加一个删除按钮
    UITableViewRowAction *deleteRowAction = [UITableViewRowAction rowActionWithStyle:UITableViewRowActionStyleDestructive title:self.cureHistoryDeleteBtnString handler:^(UITableViewRowAction *action, NSIndexPath *indexPath) {
        NSLog(@"删除本行");
        /*
         // 1.删除数据源
         [self.dataArray removeObject:lastModel];
         
         // 2.删除数据库
         NSArray *lastPointModels = [manager selectModelArrayInDatabase:localDatabaseName table:@"tcmt_cure_acupoints" modelName:@"LastPointModel" selectFactor:[NSString stringWithFormat:@"WHERE cure_id = '%@'", lastModel.cure_id]];
         for (LastPointModel *lastPointModel in lastPointModels) {
         [manager deleteModelWithDatabase:localDatabaseName table:@"tcmt_cure_acupoints" model:lastPointModel];
         
         }
         [manager deleteModelWithDatabase:localDatabaseName table:@"tcmt_cure" model:lastModel];
         
         
         // 3.更新UI
         [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationAutomatic];
         
         // 4.是否显示infoLabel
         if (self.dataArray.count == 0) {
         self.infoLabel.text = _cureHistoryInfoLabelString;
         self.infoLabel.hidden = NO;
         }
         */
    }];
    return @[deleteRowAction];
}


#pragma mark- SearchController
- (void)createSearch{
    self.searchController = [[UISearchController alloc] initWithSearchResultsController:nil];
    self.searchController.searchResultsUpdater = self;
    self.searchController.searchBar.delegate = self;//*****这个很重要，一定要设置并引用了代理之后才能调用searchBar的常用方法*****
    self.searchController.dimsBackgroundDuringPresentation = NO;//是否添加半透明覆盖层
    self.searchController.hidesNavigationBarDuringPresentation = YES;//是否隐藏导航栏
    self.searchController.searchBar.frame = CGRectMake(self.searchController.searchBar.frame.origin.x, self.searchController.searchBar.frame.origin.y, self.searchController.searchBar.frame.size.width, 44.0);
    self.tableView.tableHeaderView = self.searchController.searchBar;
    
}

//展示搜索结果
-(void)updateSearchResultsForSearchController:(UISearchController *)searchController {
    NSString *searchString = [self.searchController.searchBar text];
    
    NSPredicate *preicate = [NSPredicate predicateWithFormat:@"SELF CONTAINS[c] %@", searchString];
    if (self.searchList!= nil) {
        [self.searchList removeAllObjects];
    }
    //过滤数据
    self.searchList= [NSMutableArray arrayWithArray:[self.dataList filteredArrayUsingPredicate:preicate]];
    //刷新表格
    [self.tableView reloadData];
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

//以下的两个方法必须设置_searchController.searchBar.delegate 才可以
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
