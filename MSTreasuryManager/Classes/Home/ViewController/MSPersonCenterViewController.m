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

@interface MSPersonCenterViewController ()

@property (nonatomic, strong) MSPersonCenterHeaderView *headerView;
@property (nonatomic, strong) MSPersonModel *detailInfo;

@end

@implementation MSPersonCenterViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.headerView = [[MSPersonCenterHeaderView alloc]initWithFrame:CGRectMake(0, -kHeaderViewHeight, kSCREEN_WIDTH, kHeaderViewHeight)];
    [self.tableView addSubview:self.headerView];
    self.tableView.contentInset = UIEdgeInsetsMake(kHeaderViewHeight, 0, 0, 0);
    [self loadDetailInfo];
}

#pragma mark - HttpReques
- (void)loadDetailInfo {
    [SVProgressHUD show];
    [MSNetworking getPersonDetailInfoPersonId:self.mainPerson.personId success:^(NSDictionary *object) {
        self.detailInfo = [MSPersonModel mj_objectWithKeyValues:object[@"data"]];
        [SVProgressHUD dismiss];
    } failure:^(NSError *error) {
        [SVProgressHUD dismiss];
    }];
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


@end
