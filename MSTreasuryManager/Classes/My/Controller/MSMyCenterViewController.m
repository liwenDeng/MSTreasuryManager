//
//  MSMyCenterViewController.m
//  MSTreasuryManager
//
//  Created by 邓利文 on 2016/10/25.
//  Copyright © 2016年 邓利文. All rights reserved.
//

#import "MSMyCenterViewController.h"
#import "MSMyCenterHeaderView.h"
#import "MSAccountManager.h"
#import "MSLoginView.h"
#import "MSNetworking.h"
#import "NSString+Code.h"

static NSString * const kHeaderCell = @"headerCell";
static NSString * const kNomalCell = @"normalCell";

@interface MSMyCenterViewController () <MSLoginViewDelegate>

@property (nonatomic, strong) MSLoginView *loginView;

@end

@implementation MSMyCenterViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = kBackgroundColor;

}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    if (![[MSAccountManager sharedManager] hasLogin]) {
        [self showLoginView];
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - UITableViewDataSource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 3;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    if (indexPath.section == 0) {
        MSMyCenterHeaderView *header = [tableView dequeueReusableCellWithIdentifier:kHeaderCell];
        if (!header) {
            header = [[MSMyCenterHeaderView alloc]initWithStyle:(UITableViewCellStyleDefault) reuseIdentifier:kHeaderCell];
        }
        [header setSelectionStyle:(UITableViewCellSelectionStyleNone)];
        [header fillWithuserName:[MSAccountManager sharedManager].userName];
        return header;
    }else {
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:kNomalCell];
        if (!cell) {
            cell = [[UITableViewCell alloc]initWithStyle:(UITableViewCellStyleValue1) reuseIdentifier:kNomalCell];
        }
        if (indexPath.section == 1) {
            cell.textLabel.text = @"版本信息";
            cell.detailTextLabel.text = @"1.0";
        }
        if (indexPath.section == 2) {
            cell.textLabel.text = @"退出登录";
            cell.detailTextLabel.text = @"";
        }
        
        [cell setSelectionStyle:(UITableViewCellSelectionStyleNone)];
        return cell;
    }
    
}

#pragma mark - UITableViewDelegate
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:NO];
    if (indexPath.section == 2) {
        [self logOut];
    }else {

    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return 15.0f;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section == 0) {
        return [MSMyCenterHeaderView cellHeight];
    }
    return 44.0f;
}

- (void)showLoginView {
    
    if (!self.loginView.superview) {
        [self.view addSubview:self.loginView];
    }
    [self.loginView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.top.mas_equalTo(0);
        make.size.equalTo(self.view);
    }];
    [self.view bringSubviewToFront:self.loginView];
}

- (void)hideLoginView {
    if (self.loginView.superview) {
        [self.loginView removeFromSuperview];
    }
}

- (MSLoginView *)loginView {
    if (!_loginView) {
        _loginView = [[MSLoginView alloc]init];
        _loginView.delegate = self;
        [_loginView hideCancleButton];
    }
    return _loginView;
}

- (void)logOut {
    [SVProgressHUD show];
    [MSNetworking logoutSuccess:^(NSDictionary *object) {
        [SVProgressHUD showSuccessWithStatus:@""];
        //退出登录
        [self showLoginView];
    } failure:^(NSError *error) {
        [SVProgressHUD showErrorWithStatus:@""];
    }];
}

#pragma mark - MSLoginViewDelegate
- (void)loginView:(MSLoginView *)loginView loginButtonClicked:(UIButton *)sender userName:(NSString *)userName password:(NSString *)password {

    [SVProgressHUD show];
    [MSNetworking loginUserName:userName password:password success:^(NSDictionary *object) {
         [self hideLoginView];
        [SVProgressHUD showSuccessWithStatus:@""];
    } failure:^(NSError *error) {
        [SVProgressHUD showErrorWithStatus:@"登录失败"];
    }];
    
}

- (void)loginView:(MSLoginView *)loginView cancleButtonClicked:(UIButton *)sender {

}

- (void)loginView:(MSLoginView *)loginView loginSuccessed:(BOOL)successed {
    
}

@end
