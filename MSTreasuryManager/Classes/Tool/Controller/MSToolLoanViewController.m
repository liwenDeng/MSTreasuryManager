//
//  MSToolLoanViewController.m
//  MSTreasuryManager
//
//  Created by 邓利文 on 2016/10/14.
//  Copyright © 2016年 邓利文. All rights reserved.
//

#import "MSToolLoanViewController.h"
#import "MSMaterialFillInWithSearchSection.h"
#import "MSMaterialFillInNomalSection.h"
#import "MSToolInfoFillInSection.h"
#import "YZInputView.h"
#import "MSBaseDatePickerView.h"
#import "MSBaseButton.h"

@interface MSToolLoanViewController () <MSBaseDatePickerViewDelegate>

@property (nonatomic, strong) UIScrollView *scrollView;

@property (nonatomic, strong) YZInputView *toolNameInput;
@property (nonatomic, strong) UITextField *dateInput;
@property (nonatomic, strong) UITextField *borrowUserInput;
@property (nonatomic, strong) UITextField *reviewUserInput;

@property (nonatomic, strong) MSBaseDatePickerView *datePickerView;

@end

@implementation MSToolLoanViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.title = @"工器具归还";
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
    
    MSMaterialFillInWithSearchSection *section1 = [[MSMaterialFillInWithSearchSection alloc]initWithTitle:@"工器具名称" placeholder:@"请选择工器具"];
    MSMaterialFillInNomalSection *section2 = [[MSMaterialFillInNomalSection alloc]initWithTitle:@"借用时间" placeholder:@"选择日期" canTouch:YES];
    MSMaterialFillInNomalSection *section3 = [[MSMaterialFillInNomalSection alloc]initWithTitle:@"借用人" placeholder:@"选择人员" canTouch:YES];
    MSMaterialFillInNomalSection *section4 = [[MSMaterialFillInNomalSection alloc]initWithTitle:@"审核人" placeholder:@"选择人员" canTouch:YES];
    
    [bgView addSubview:section1];
    [bgView addSubview:section2];
    [bgView addSubview:section3];
    [bgView addSubview:section4];

    self.toolNameInput = section1.inputView;
    self.toolNameInput.editable = NO;
    
    self.dateInput = section2.textField;
    self.borrowUserInput = section3.textField;
    self.reviewUserInput = section4.textField;
    
    [section1.searchBtn addTarget:self action:@selector(searchNameBtnClicked:) forControlEvents:(UIControlEventTouchUpInside)];
    [section2.actionBtn addTarget:self action:@selector(dateInputClicked:) forControlEvents:(UIControlEventTouchUpInside)];
    [section3.actionBtn addTarget:self action:@selector(borrowUserInputClicked:) forControlEvents:(UIControlEventTouchUpInside)];
    [section4.actionBtn addTarget:self action:@selector(reviewUserInputClicked:) forControlEvents:(UIControlEventTouchUpInside)];
    
    ////为工器具名称添加点击事件
    UITapGestureRecognizer *tapName = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(searchNameBtnClicked:)];
    [self.toolNameInput addGestureRecognizer:tapName];
    
    [section1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(0);
        make.top.mas_equalTo(20);
        make.width.mas_equalTo(kSCREEN_WIDTH);
    }];
    
    [section2 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(section1.mas_bottom).offset(20);
        make.left.mas_equalTo(0);
        make.height.mas_equalTo(44);
        make.width.mas_equalTo(kSCREEN_WIDTH);
    }];
    
    [section3 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(0);
        make.top.equalTo(section2.mas_bottom).offset(0);
        make.width.mas_equalTo(kSCREEN_WIDTH);
        make.height.mas_equalTo(44);
    }];
    
    [section4 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(section3.mas_bottom).offset(0);
        make.height.mas_equalTo(44);
        make.left.mas_equalTo(0);
        make.width.mas_equalTo(kSCREEN_WIDTH);
    }];
    
    //
    MSBaseButton *btn = [[MSBaseButton alloc]initWithTitle:@"提    交"];
    [bgView addSubview:btn];
    [btn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(section4.mas_bottom).offset(60);
        make.left.mas_equalTo(20);
        make.height.mas_equalTo(40);
        make.width.mas_equalTo(kSCREEN_WIDTH - 40);
    }];
    [btn addTarget:self action:@selector(submitBtnClicked:) forControlEvents:(UIControlEventTouchUpInside)];
    
    [bgView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.mas_equalTo(kSCREEN_WIDTH);
        make.bottom.equalTo(btn.mas_bottom).offset(60);
    }];
    
    [self.scrollView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.view);
        make.edges.equalTo(bgView);
    }];
}

#pragma mark - ClickAction
- (void)searchNameBtnClicked:(UIButton *)sender {
    NSLog(@"搜索工器具名称");
}

- (void)dateInputClicked:(UIButton *)sender {
    [self showDatePickerView];
}

- (void)borrowUserInputClicked:(UIButton *)sender {
    
}

- (void)reviewUserInputClicked:(UIButton *)sender {
    
}

- (void)submitBtnClicked:(UIButton *)sender {
    
}

- (void)dismissKeyboardAction:(UITapGestureRecognizer *)tap {
    [self.view endEditing:YES];
}

#pragma mark - MSBaseDatePickerViewDelegate
- (void)datePickerView:(MSBaseDatePickerView *)datePicker submitWithDate:(NSDate *)date {
    NSLog(@"date:%@",date);
    [self hideDatePickerView];
}

- (void)datePickerView:(MSBaseDatePickerView *)datePicker cancleWithDate:(NSDate *)date {
    [self hideDatePickerView];
}

- (void)showDatePickerView {
    if (self.datePickerView.hidden) {
        self.datePickerView.hidden = NO;
        [UIView animateWithDuration:0.3 delay:0 options:(UIViewAnimationOptionCurveEaseOut) animations:^{
            [self.datePickerView mas_updateConstraints:^(MASConstraintMaker *make) {
                make.top.equalTo(self.mas_bottomLayoutGuideBottom).offset(-200);
            }];
            [self.view layoutIfNeeded];
        } completion:^(BOOL finished) {
            
        }];
    }
}

- (void)hideDatePickerView {
    if (!self.datePickerView.hidden) {
        [UIView animateWithDuration:0.3 delay:0 options:(UIViewAnimationOptionCurveEaseIn) animations:^{
            [self.datePickerView mas_updateConstraints:^(MASConstraintMaker *make) {
                make.top.equalTo(self.mas_bottomLayoutGuideBottom).offset(0);
            }];
            [self.view layoutIfNeeded];
        } completion:^(BOOL finished) {
            self.datePickerView.hidden = YES;
        }];
    }
}

#pragma mark - LazyLoad
- (MSBaseDatePickerView *)datePickerView {
    if (!_datePickerView) {
        _datePickerView = [[MSBaseDatePickerView alloc]init];
        [self.view addSubview:_datePickerView];
        
        [_datePickerView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(0);
            make.top.equalTo(self.mas_bottomLayoutGuideBottom);
            make.width.mas_equalTo(kSCREEN_WIDTH);
            make.height.mas_equalTo(200);
        }];
        _datePickerView.delegate = self;
        _datePickerView.hidden = YES;
        [self.view layoutIfNeeded];
    }
    return _datePickerView;
}


@end
