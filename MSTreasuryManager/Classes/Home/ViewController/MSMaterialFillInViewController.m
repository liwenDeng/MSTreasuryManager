//
//  MSMaterialFillInViewController.m
//  MSTreasuryManager
//
//  Created by 邓利文 on 2016/10/8.
//  Copyright © 2016年 邓利文. All rights reserved.
//

#import "MSMaterialFillInViewController.h"
#import "YZInputView.h"
#import "MSMaterialFillInWithSearchSection.h"
#import "MSMaterialFillInNomalSection.h"

@interface MSMaterialFillInViewController ()

@property (nonatomic, strong) UIScrollView *scrollView;
@property (nonatomic, strong) YZInputView *nameInput;   //物资名称
@property (nonatomic, strong) YZInputView *paramsInput; //物资参数

@property (nonatomic, strong) UITextField *erfuField;
@property (nonatomic, strong) UITextField *tuikuField;
@property (nonatomic, strong) UITextField *sysField;

@end

@implementation MSMaterialFillInViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    [self setupSubviews];
}

- (void)setupSubviews {
    self.title = @"物资信息填写";
    self.scrollView = [[UIScrollView alloc]initWithFrame:self.view.bounds];
    [self.view addSubview:self.scrollView];
    self.scrollView.backgroundColor = kBackgroundColor;
    
    [self setupSections];
    
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(dismissKeyboard)];
    tap.cancelsTouchesInView = NO;//防止tap影响subView响应事件
    [self.view addGestureRecognizer:tap];
}

- (void)setupSections {
    MSMaterialFillInWithSearchSection *section1 = [[MSMaterialFillInWithSearchSection alloc]initWithTitle:@"物资名称" placeholder:@"请输入物资名称"];
    self.nameInput = section1.inputView;
    [self.scrollView addSubview:section1];
    [section1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(0);
        make.top.mas_equalTo(20);
        make.width.mas_equalTo(kSCREEN_WIDTH);
    }];
    
    MSMaterialFillInWithSearchSection *section2 = [[MSMaterialFillInWithSearchSection alloc]initWithTitle:@"物资技术参数" placeholder:@"请输入物资技术参数"];
    self.paramsInput = section2.inputView;
    [self.scrollView addSubview:section2];
    [section2 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(0);
        make.top.equalTo(section1.mas_bottom).offset(20);
        make.width.mas_equalTo(kSCREEN_WIDTH);
    }];
    
    UIView *titleBgView = ({
        UIView *view = [[UIView alloc]init];
        [self.scrollView addSubview:view];
        view.backgroundColor = [UIColor whiteColor];
        view;
    });
    
    UILabel *titleLabel = ({
        UILabel *label = [[UILabel alloc]init];
        [titleBgView addSubview:label];
        label.text = @"物资库存";
        label.backgroundColor = [UIColor whiteColor];
        
        label;
    });
    UIView *line = ({
        UIView *view = [[UIView alloc]init];
        [self.scrollView addSubview:view];
        line.backgroundColor = kBackgroundColor;
        view;
    });
    
    [titleBgView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(0);
        make.width.mas_equalTo(kSCREEN_WIDTH);
        make.height.mas_equalTo(44);
        make.top.equalTo(section2.mas_bottom).offset(20);
    }];
    
    [titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(15);
        make.right.equalTo(titleBgView);
        make.height.mas_equalTo(44);
        make.top.equalTo(section2.mas_bottom).offset(20);
    }];
    
    [line mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(0);
        make.width.mas_equalTo(kSCREEN_WIDTH);
        make.height.mas_equalTo(1);
        make.top.equalTo(titleLabel.mas_bottom);
    }];
    
    MSMaterialFillInNomalSection *section3 = [[MSMaterialFillInNomalSection alloc]initWithTitle:@"二副库房" placeholder:@"填写数量"];
    MSMaterialFillInNomalSection *section4 = [[MSMaterialFillInNomalSection alloc]initWithTitle:@"退库库房" placeholder:@"填写数量"];
    MSMaterialFillInNomalSection *section5 = [[MSMaterialFillInNomalSection alloc]initWithTitle:@"系统库房" placeholder:@"填写数量"];
    
    self.erfuField = section3.textField;
    self.tuikuField = section4.textField;
    self.sysField = section5.textField;
    
    [self.scrollView addSubview:section3];
    [self.scrollView addSubview:section4];
    [self.scrollView addSubview:section5];
    
    [section3 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(line.mas_bottom);
        make.left.mas_equalTo(0);
        make.width.mas_equalTo(kSCREEN_WIDTH);
        make.height.mas_equalTo(44);
    }];
    
    [section4 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(section3.mas_bottom);
        make.left.mas_equalTo(0);
        make.width.mas_equalTo(kSCREEN_WIDTH);
        make.height.mas_equalTo(44);
    }];
    
    [section5 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(section4.mas_bottom);
        make.left.mas_equalTo(0);
        make.width.mas_equalTo(kSCREEN_WIDTH);
        make.height.mas_equalTo(44);
        make.bottom.equalTo(self.scrollView);
    }];
    
    
}

- (void)dismissKeyboard {
    [self.view endEditing:YES];
}

@end
