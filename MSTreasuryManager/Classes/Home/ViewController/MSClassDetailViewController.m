//
//  MSClassDetailViewController.m
//  MSTreasuryManager
//
//  Created by 邓利文 on 2017/2/14.
//  Copyright © 2017年 邓利文. All rights reserved.
//

#import "MSClassDetailViewController.h"
#import "MSClassHeaderView.h"

static NSString *const kClassDetailCellIdentifier = @"kClassDetailCell";

@interface MSClassDetailViewController ()

@property (nonatomic, strong) MSClassHeaderView *headerView;

@end

@implementation MSClassDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.title = self.classModel.name;
    self.headerView = [[MSClassHeaderView alloc]initWithFrame:CGRectMake(0, -kHeaderViewHeight, kSCREEN_WIDTH, kHeaderViewHeight)];
    [self.tableView addSubview:self.headerView];
    self.tableView.contentInset = UIEdgeInsetsMake(kHeaderViewHeight, 0, 0, 0);
    [self fillData];
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
    [self.headerView fillWithClassModel:self.classModel];
    [self.tableView reloadData];
}

#pragma mark - UITableViewDataSource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 2;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {

    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:kClassDetailCellIdentifier];
    if (!cell) {
        cell = [[UITableViewCell alloc]initWithStyle:(UITableViewCellStyleValue1) reuseIdentifier:kClassDetailCellIdentifier];
        cell.textLabel.numberOfLines = 0;
        [cell setSelectionStyle:(UITableViewCellSelectionStyleNone)];
        cell.textLabel.font = [UIFont systemFontOfSize:14];
    }
    
    if (indexPath.section == 0) {
        cell.textLabel.text = self.classModel.ideal;    //理念
    }else {
        cell.textLabel.text = self.classModel.introduction; //简介
    }
    
    return cell;
    
}

#pragma mark - UITableViewDelegate
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section {
    return section == 0 ? @"班组理念" : @"班组简介";
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return 40;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    return CGFLOAT_MIN;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    NSString *text = indexPath.section == 0 ? self.classModel.ideal : self.classModel.introduction;
    
    CGSize textSize = [text ms_sizeWithFont:[UIFont systemFontOfSize:14] constrainedToSize:CGSizeMake(kSCREEN_WIDTH - 30, 9999) lineBreakMode:(NSLineBreakByWordWrapping)];
    return MAX(textSize.height + 30, 44);
}

@end
