//
//  MSToolInfoAddViewController.m
//  MSTreasuryManager
//
//  Created by 邓利文 on 2016/10/14.
//  Copyright © 2016年 邓利文. All rights reserved.
//

#import "MSToolInfoFillInViewController.h"
#import "MSBaseButton.h"
#import "MSToolInfoFillInSection.h"
#import "MSLoginViewController.h"
#import "MSNetworking+Tool.h"

@interface MSToolInfoFillInViewController ()

@property (nonatomic, strong) UIScrollView *scrollView;
@property (nonatomic, strong) YZInputView *toolNameInput;

@end

@implementation MSToolInfoFillInViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
//    
//    [MSLoginViewController loginSuccess:^{
//        
//    } failure:^{
//        [self.navigationController popViewControllerAnimated:NO];
//    }];
//    
    self.title = @"工器具信息填写";
    self.scrollView = [[UIScrollView alloc]init];
    [self.view addSubview:self.scrollView];
    self.scrollView.backgroundColor = kBackgroundColor;
    
    [self setupSections];
    
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(dismissKeyboardAction)];
    [self.view addGestureRecognizer:tap];
}

- (void)setupSections {
    UIView *bgView = ({
        UIView *view = [[UIView alloc]init];
        [self.scrollView addSubview:view];
        
        view;
    });
    
    MSToolInfoFillInSection *section1 = [[MSToolInfoFillInSection alloc]initWithTitle:@"工器具名称" placeholder:@"请输入工器具名称"];
    [bgView addSubview:section1];
    self.toolNameInput = section1.fillInView;
    [section1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(0);
        make.top.mas_equalTo(20);
        make.width.mas_equalTo(kSCREEN_WIDTH);
    }];

    
    [bgView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.mas_equalTo(kSCREEN_WIDTH);
        make.bottom.equalTo(section1.mas_bottom).offset(20);
    }];
    
    
    [self.scrollView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.view);
        make.edges.equalTo(bgView);
    }];
    
    MSBaseButton *btn = [[MSBaseButton alloc]initWithTitle:@"提    交"];
    [self.view addSubview:btn];
    [btn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(self.view.mas_bottom).offset(-60);
        make.left.mas_equalTo(20);
        make.height.mas_equalTo(40);
        make.width.mas_equalTo(kSCREEN_WIDTH - 40);
    }];
    [btn addTarget:self action:@selector(submitBtnClicked:) forControlEvents:(UIControlEventTouchUpInside)];
}

- (void)submitBtnClicked:(UIButton *)sender {
    [SVProgressHUD show];
    [MSNetworking addTool:self.toolNameInput.text success:^(NSDictionary *object) {
       
        [SVProgressHUD showSuccessWithStatus:@"添加成功"];
        self.toolNameInput.text = nil;
    } failure:^(NSError *error) {
        self.toolNameInput.text = nil;
        [SVProgressHUD showErrorWithStatus:@"添加失败"];
    }];
}

- (void)dismissKeyboardAction {
    [self.view endEditing:YES];
}

@end
