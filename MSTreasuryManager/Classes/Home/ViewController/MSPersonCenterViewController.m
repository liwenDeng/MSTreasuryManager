//
//  MSPersonCenterViewController.m
//  MSTreasuryManager
//
//  Created by apple on 17/1/14.
//  Copyright © 2017年 邓利文. All rights reserved.
//

#import "MSPersonCenterViewController.h"
#import "MSPersonCenterHeaderView.h"
#import "MSNetworking+HomeApi.h"
#import "MSPersonCenterCell.h"
#import "NSString+Util.h"

static NSString *const kPersonCellIdentifier = @"PersonCel";
static NSString *const kPersonIntroCellIdentifier = @"IntroduceCell";

@interface MSPersonCenterViewController ()

@property (nonatomic, strong) MSPersonCenterHeaderView *headerView;
//@property (nonatomic, strong) MSPersonModel *detailInfo;
@property (nonatomic, strong) NSArray *titleArray;
@property (nonatomic, strong) NSArray *valueArray;

@end

@implementation MSPersonCenterViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.title = @"个人资料";
    self.headerView = [[MSPersonCenterHeaderView alloc]initWithFrame:CGRectMake(0, -kHeaderViewHeight, kSCREEN_WIDTH, kHeaderViewHeight)];
    [self.tableView addSubview:self.headerView];
    self.tableView.contentInset = UIEdgeInsetsMake(kHeaderViewHeight, 0, 0, 0);
//    [self loadDetailInfo];
    [self fillData];
}

#pragma mark - HttpReques
- (void)loadDetailInfo {
//    [SVProgressHUD show];
//    [MSNetworking getPersonDetailInfoPersonId:self.mainPerson.personId success:^(NSDictionary *object) {
//        self.detailInfo = [MSPersonModel mj_objectWithKeyValues:object[@"data"]];
//        [SVProgressHUD dismiss];
//        [self fillData];
//    } failure:^(NSError *error) {
//        [SVProgressHUD dismiss];
//    }];
}


#pragma mark - ScrollViewDelegate
- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    //获取偏移量
    CGPoint offset = scrollView.contentOffset;
    //判断是否改变
    if (offset.y < -kHeaderViewHeight) {
        CGRect rect = self.self.headerView.frame;
        //我们只需要改变图片的y值和高度即可
        rect.origin.y = offset.y;
        rect.size.height = ABS(offset.y);
        self.headerView.frame = rect;
    }else {
        self.headerView.frame = CGRectMake(0, -kHeaderViewHeight, kSCREEN_WIDTH, kHeaderViewHeight);
    }
}

- (void)fillData {
    [self.headerView fillWithPerson:self.mainPerson];
    self.valueArray = @[self.mainPerson.team,self.mainPerson.job,self.mainPerson.phone];
    [self.tableView reloadData];
}

#pragma mark - UITableViewDataSource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 2;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return section == 0 ? self.titleArray.count : 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section == 0) {
        MSPersonCenterCell *cell = [tableView dequeueReusableCellWithIdentifier:kPersonCellIdentifier];
        if (!cell) {
            cell = [[MSPersonCenterCell alloc]initWithStyle:(UITableViewCellStyleValue1) reuseIdentifier:kPersonCellIdentifier];
        }
        NSString *title = self.titleArray[indexPath.row];
        NSString *value = @"";
        if (self.valueArray.count > indexPath.row) {
            value = self.valueArray[indexPath.row];
        }
        [cell fillWithTitle:title value:value];
        
        return cell;
    }else {
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:kPersonIntroCellIdentifier];
        if (!cell) {
            cell = [[UITableViewCell alloc]initWithStyle:(UITableViewCellStyleValue1) reuseIdentifier:kPersonIntroCellIdentifier];
            cell.textLabel.numberOfLines = 0;
            [cell setSelectionStyle:(UITableViewCellSelectionStyleNone)];
            cell.textLabel.font = [UIFont systemFontOfSize:14];
        }
        cell.textLabel.text = @"测试撒打开大家撒可大家来看撒娇的卢卡斯就离开大家来喀什的撒娇的卢卡斯建档立卡就是测试撒打开大家撒可大家来看撒娇的卢卡斯就离开大家来喀什的撒娇的卢卡斯建档立卡就是测试撒打开大家撒可大家来看撒娇的卢卡斯就离开大家来喀什的撒娇的卢卡斯建档立卡就是测试撒打开大家撒可大家来看撒娇的卢卡斯就离开大家来喀什的撒娇的卢卡斯建档立卡就是";
        return cell;
    }
}

#pragma mark - UITableViewDelegate
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section {
    return section == 0 ? @"基本资料" : @"个人简介";
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return 40;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    return CGFLOAT_MIN;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section == 0) {
        return 44;
    }
    CGSize textSize = [@"测试撒打开大家撒可大家来看撒娇的卢卡斯就离开大家来喀什的撒娇的卢卡斯建档立卡就是测试撒打开大家撒可大家来看撒娇的卢卡斯就离开大家来喀什的撒娇的卢卡斯建档立卡就是测试撒打开大家撒可大家来看撒娇的卢卡斯就离开大家来喀什的撒娇的卢卡斯建档立卡就是测试撒打开大家撒可大家来看撒娇的卢卡斯就离开大家来喀什的撒娇的卢卡斯建档立卡就是" ms_sizeWithFont:[UIFont systemFontOfSize:14] constrainedToSize:CGSizeMake(kSCREEN_WIDTH - 30, 9999) lineBreakMode:(NSLineBreakByWordWrapping)];
    return MAX(textSize.height + 30, 44);
}

- (NSArray *)titleArray {
    if (!_titleArray) {
        _titleArray = @[@"班  组",@"职  务",@"电  话"];
    }
    return _titleArray;
}

@end
