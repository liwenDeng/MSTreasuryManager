//
//  MSLiveWorkEditViewController.m
//  MSTreasuryManager
//
//  Created by 邓利文 on 2016/10/24.
//  Copyright © 2016年 邓利文. All rights reserved.
//

#import "MSLiveWorkEditViewController.h"
#import "MSToolInfoFillInSection.h"
#import "MSBaseButton.h"

@interface MSLiveWorkEditViewController ()

@property (nonatomic, strong) UIScrollView *scrollView;
@property (nonatomic, strong) YZInputView *fillInview;

@end

@implementation MSLiveWorkEditViewController

- (instancetype)initWithEditType:(MSEditType)type {
    if (self = [super init]) {
        _editType = type;
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    NSString *title = self.editType == MSEditTypeContent ? @"现场工作内容-编辑" : @"注意事项-编辑";
    self.title = title;
    [self setupSubViews];
}

- (void)setupSubViews {
    
    self.scrollView = [[UIScrollView alloc]init];
    [self.view addSubview:self.scrollView];
    self.scrollView.backgroundColor = kBackgroundColor;
    
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(dismissKeyboardAction:)];
//    tap.cancelsTouchesInView = NO;//防止tap影响subView响应事件
    [self.view addGestureRecognizer:tap];
    
    [self setupSections];
    
}

- (void)setupSections {
    UIView *bgView = ({
        UIView *view = [[UIView alloc]init];
        [self.scrollView addSubview:view];
        
        view;
    });
    
    NSString *title = self.editType == MSEditTypeContent ? @"工作内容" : @"注意事项";
    
    MSToolInfoFillInSection *section1 = [[MSToolInfoFillInSection alloc]initWithTitle:title placeholder:nil];
    
    [bgView addSubview:section1];
    [section1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(20);
        make.left.mas_equalTo(0);
        make.height.mas_greaterThanOrEqualTo(44);
        make.width.mas_equalTo(kSCREEN_WIDTH);
    }];
    
    MSBaseButton *btn = [[MSBaseButton alloc]initWithTitle:@"提    交"];
    [bgView addSubview:btn];
    [btn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(section1.mas_bottom).offset(20);
        make.left.mas_equalTo(20);
        make.height.mas_equalTo(40);
        make.width.mas_equalTo(kSCREEN_WIDTH - 40);
    }];
    
    [btn addTarget:self action:@selector(submitBtnClicked) forControlEvents:(UIControlEventTouchUpInside)];
    
    [bgView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.mas_equalTo(kSCREEN_WIDTH);
        make.bottom.equalTo(btn.mas_bottom).offset(20);
    }];

    [self.scrollView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.view);
        make.edges.equalTo(bgView);
    }];
    
    _fillInview = section1.fillInView;
}

- (void)viewDidAppear:(BOOL)animated {
    [_fillInview becomeFirstResponder];
}

- (void)dismissKeyboardAction:(UITapGestureRecognizer *)tap {
    [self.view endEditing:YES];
}

- (void)submitBtnClicked {
    [self.navigationController popViewControllerAnimated:YES];
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
