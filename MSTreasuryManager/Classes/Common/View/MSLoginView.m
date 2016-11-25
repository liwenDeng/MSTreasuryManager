//
//  MSLoginView.m
//  MSTreasuryManager
//
//  Created by 邓利文 on 2016/10/25.
//  Copyright © 2016年 邓利文. All rights reserved.
//

#import "MSLoginView.h"
#import "MSBaseButton.h"
#import "UIImageView+CornerRadius.h"
#import "MSAccountManager.h"
#import "UITextField+Placeholder.h"

static const CGFloat kHeadIconWidth = 80;

@interface MSLoginView ()

@property (nonatomic, strong) UIImageView *headIcon;
@property (nonatomic, strong) UITextField *userNameField;
@property (nonatomic, strong) UITextField *passWordField;
@property (nonatomic, strong) UIButton *cancleBtn;
@property (nonatomic, strong) MSBaseButton *loginBtn;

@end

@implementation MSLoginView

- (void)setupSubviews {
    self.backgroundColor = [UIColor whiteColor];
    
    UIImageView *bgView = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"loginBg.jpg"]];
    [self addSubview:bgView];
    [bgView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self);
    }];
    
    _headIcon = ({
        UIImageView *view = [[UIImageView alloc]init];
        [self addSubview:view];
        
        [view mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(70);
            make.centerX.equalTo(self);
            make.size.mas_equalTo(CGSizeMake(kHeadIconWidth, kHeadIconWidth));
        }];
        [view zy_cornerRadiusRoundingRect];
        view.image = [UIImage imageNamed:@"head"];
        view;
    });
    
    UILabel *nameLabel = ({
        UILabel *label = [[UILabel alloc]init];
        [self addSubview:label];
        label.text = @"账号";
        [label sizeToFit];
        label.textColor = kTitleColor;
        [label mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(15);
            make.top.equalTo(_headIcon.mas_bottom).offset(30);
        }];
        
        label;
    });
    
    UIView *line1 = ({
        UIView *view = [[UIView alloc]init];
        [self addSubview:view];
        view.backgroundColor = kTitleColor;
        [view mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(nameLabel.mas_bottom).offset(10);
            make.left.width.equalTo(self);
            make.height.mas_equalTo(1);
        }];
        
        view;
    });
    
    _userNameField = ({
        UITextField *view = [[UITextField alloc]init];
        [view setClearButtonMode:(UITextFieldViewModeWhileEditing)];
        [self addSubview:view];
        view.placeholder = @"用户名";
        view.textColor = kTitleColor;
        [view ms_setPlaceholderColor:[UIColor grayColor]];
        [view mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(nameLabel.mas_right).offset(25);
            make.width.mas_equalTo(kSCREEN_WIDTH - 100);
            make.height.equalTo(nameLabel);
            make.centerY.equalTo(nameLabel);
        }];
        
        view;
    });
    
    UILabel *passLabel = ({
        UILabel *label = [[UILabel alloc]init];
        [self addSubview:label];
        label.text = @"密码";
        label.textColor = kTitleColor;
        [label sizeToFit];
        [label mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(15);
            make.top.equalTo(line1.mas_bottom).offset(10);
        }];
        
        label;
    });
    
    _passWordField = ({
        UITextField *view = [[UITextField alloc]init];
        [self addSubview:view];
        [view setClearButtonMode:(UITextFieldViewModeWhileEditing)];
        [view setSecureTextEntry:YES];
        view.placeholder = @"密码";
        view.textColor = kTitleColor;
        [view ms_setPlaceholderColor:[UIColor grayColor]];
        [view mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(passLabel.mas_right).offset(25);
            make.width.mas_equalTo(kSCREEN_WIDTH - 100);
            make.height.equalTo(passLabel);
            make.centerY.equalTo(passLabel);
        }];
        
        view;
    });
    
    UIView *line2 = ({
        UIView *view = [[UIView alloc]init];
        [self addSubview:view];
        view.backgroundColor = kTitleColor;
        
        [view mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(passLabel.mas_bottom).offset(10);
            make.left.width.equalTo(self);
            make.height.mas_equalTo(1);
        }];
        
        view;
    });
    
    _loginBtn = ({
        MSBaseButton *btn = [[MSBaseButton alloc]initWithTitle:@"登录"];
        [self addSubview:btn];
        [btn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(line2.mas_bottom).offset(20);
            make.left.mas_equalTo(20);
            make.width.mas_equalTo(kSCREEN_WIDTH - 40);
            make.height.mas_equalTo(40);
        }];
        [btn addTarget:self action:@selector(loginButtonClicked:) forControlEvents:(UIControlEventTouchUpInside)];
        btn;
    });
    
    _cancleBtn = ({
        UIButton *btn = [UIButton buttonWithType:(UIButtonTypeSystem)];
        [btn setTitle:@"取消" forState:(UIControlStateNormal)];
        [btn sizeToFit];
        [self addSubview:btn];
        [btn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(20);
            make.left.equalTo(nameLabel);
        }];
        [btn addTarget:self action:@selector(cancleButtonClicked:) forControlEvents:(UIControlEventTouchUpInside)];
        btn;
    });
    
}

- (void)loginButtonClicked:(UIButton *)sender {
    if ([self.delegate respondsToSelector:@selector(loginView:loginButtonClicked:userName:password:)]) {
        [self.delegate loginView:self loginButtonClicked:sender userName:self.userNameField.text password:self.passWordField.text];
    }
}

- (void)cancleButtonClicked:(UIButton *)sender {
    if ([self.delegate respondsToSelector:@selector(loginView:cancleButtonClicked:)]) {
        [self.delegate loginView:self cancleButtonClicked:sender];
    }
}

- (void)hideCancleButton {
    self.cancleBtn.hidden = YES;
}

@end
