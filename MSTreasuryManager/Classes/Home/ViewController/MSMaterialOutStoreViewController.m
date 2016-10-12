//
//  MSMaterialOutStoreViewController.m
//  MSTreasuryManager
//
//  Created by apple on 16/10/12.
//  Copyright © 2016年 邓利文. All rights reserved.
//

#import "MSMaterialOutStoreViewController.h"
#import "MSMaterialFillInWithSearchSection.h"
#import "MSMaterialFillInNomalSection.h"
#import "YZInputView.h"
#import "MSBaseButton.h"
#import "MSBaseDatePickerView.h"
#import "NSDate+MSExtension.h"

@interface MSMaterialOutStoreViewController () <MSBaseDatePickerViewDelegate>

@property (nonatomic, strong) UIScrollView *scrollView;
@property (nonatomic, strong) YZInputView *nameInput;
@property (nonatomic, strong) YZInputView *placeInput;

@property (nonatomic, strong) UITextField *outCountInput;
@property (nonatomic, strong) UITextField *dateInput;
@property (nonatomic, strong) UITextField *handleUserInput; //经办人
@property (nonatomic, strong) UITextField *reviewUserInput;   //审核人

@end

@implementation MSMaterialOutStoreViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setupSubViews];
}

- (void)setupSubViews {
    self.title = @"物资出库";
    self.scrollView = [[UIScrollView alloc]init];
    [self.view addSubview:self.scrollView];
    self.scrollView.backgroundColor = kBackgroundColor;
    
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(dismissKeyboardAction)];
    tap.cancelsTouchesInView = NO;//防止tap影响subView响应事件
    [self.view addGestureRecognizer:tap];
    
    [self setupSections];
}

- (void)setupSections {
    UIView *bgView = ({
        UIView *view = [[UIView alloc]init];
        [self.scrollView addSubview:view];
        
        view;
    });
    
    //物资名称 物资技术参数
    MSMaterialFillInWithSearchSection *section1 = [[MSMaterialFillInWithSearchSection alloc]initWithTitle:@"物资名称" placeholder:@"请选择物资名称"];
    self.nameInput = section1.inputView;
    self.nameInput.editable = NO;
    [bgView addSubview:section1];
    [section1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(0);
        make.top.mas_equalTo(20);
        make.width.mas_equalTo(kSCREEN_WIDTH);
    }];
    [section1.searchBtn addTarget:self action:@selector(searchNameBtnClicked:) forControlEvents:(UIControlEventTouchUpInside)];
    
    MSMaterialFillInWithSearchSection *section2 = [[MSMaterialFillInWithSearchSection alloc]initWithTitle:@"出库位置" placeholder:@"请选择出库位置"];
    self.placeInput = section2.inputView;
    self.placeInput.editable = NO;
    [bgView addSubview:section2];
    [section2 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(0);
        make.top.equalTo(section1.mas_bottom).offset(20);
        make.width.mas_equalTo(kSCREEN_WIDTH);
    }];
    [section2.searchBtn addTarget:self action:@selector(searchPlaceBtnClicked:) forControlEvents:(UIControlEventTouchUpInside)];
    
    MSMaterialFillInNomalSection *section3 = [[MSMaterialFillInNomalSection alloc]initWithTitle:@"出库数量" placeholder:@"填写数量"];
    MSMaterialFillInNomalSection *section4 = [[MSMaterialFillInNomalSection alloc]initWithTitle:@"出库日期" placeholder:@"2016-09-09"];
    MSMaterialFillInNomalSection *section5 = [[MSMaterialFillInNomalSection alloc]initWithTitle:@"经办人" placeholder:@"选择人员"];
    MSMaterialFillInNomalSection *section6 = [[MSMaterialFillInNomalSection alloc]initWithTitle:@"审核人" placeholder:@"选择人员"];
    
    [bgView addSubview:section3];
    [bgView addSubview:section4];
    [bgView addSubview:section5];
    [bgView addSubview:section6];
    
    [section3 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(section2.mas_bottom).offset(20);
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
    }];
    
    [section6 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(section5.mas_bottom);
        make.left.mas_equalTo(0);
        make.width.mas_equalTo(kSCREEN_WIDTH);
        make.height.mas_equalTo(44);
    }];
    
    self.outCountInput = section3.textField;
    self.dateInput = section4.textField;
    self.handleUserInput = section5.textField;
    self.reviewUserInput = section6.textField;
    
//    self.dateInput.editing = NO;
//    self.handleUserInput.enabled = NO;
//    self.reviewUserInput.enabled = NO;
    [section4.actionBtn addTarget:self action:@selector(dateInputClicked:) forControlEvents:(UIControlEventTouchUpInside)];
    
//    UITapGestureRecognizer *tapDate = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(dateInputClicked:)];
//    [self.dateInput addGestureRecognizer:tapDate];
    
    UITapGestureRecognizer *tapHandleUser = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(handleUserInputClicked:)];
    [self.handleUserInput addGestureRecognizer:tapHandleUser];
    
    UITapGestureRecognizer *tapReviewUser = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(reviewUserInputClicked:)];
    [self.reviewUserInput addGestureRecognizer:tapReviewUser];
    
//    //subMitBtn
    MSBaseButton *btn = [[MSBaseButton alloc]initWithTitle:@"提    交"];
    [bgView addSubview:btn];
    [btn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(section6.mas_bottom).offset(60);
        make.left.mas_equalTo(20);
        make.height.mas_equalTo(40);
        make.width.mas_equalTo(kSCREEN_WIDTH - 40);
    }];
    
    [bgView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.mas_equalTo(kSCREEN_WIDTH);
        make.bottom.equalTo(btn.mas_bottom).offset(20);
    }];
    
    [self.scrollView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.view);
        make.edges.equalTo(bgView);
    }];
}

#pragma mark - ClickAction
- (void)searchNameBtnClicked:(UIButton *)sender {

}

- (void)searchPlaceBtnClicked:(UIButton *)sender {

}

- (void)dateInputClicked:(UITapGestureRecognizer *)tap {
    MSBaseDatePickerView *datePicker = [[MSBaseDatePickerView alloc]init];
    [self.view addSubview:datePicker];
    [datePicker mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(0);
        make.top.equalTo(self.mas_bottomLayoutGuideBottom);
        make.width.mas_equalTo(kSCREEN_WIDTH);
        make.height.mas_equalTo(200);
    }];
    datePicker.delegate = self;

    [self.view layoutIfNeeded];
    
    [UIView animateWithDuration:0.3 delay:0 options:(UIViewAnimationOptionCurveEaseOut) animations:^{
        [datePicker mas_updateConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.mas_bottomLayoutGuideBottom).offset(-200);
        }];
        [self.view layoutIfNeeded];
    } completion:nil];

}

- (void)handleUserInputClicked:(UITapGestureRecognizer *)tap {

}

- (void)reviewUserInputClicked:(UITapGestureRecognizer *)tap {

}

- (void)dismissKeyboardAction {
    [self.view endEditing:YES];
}

- (void)datePickerChanged {

}

#pragma mark - MSBaseDatePickerViewDelegate
- (void)datePickerView:(MSBaseDatePickerView *)datePicker submitWithDate:(NSDate *)date {
    NSLog(@"date:%@",date);
    [UIView animateWithDuration:0.3 delay:0 options:(UIViewAnimationOptionCurveEaseIn) animations:^{
        [datePicker mas_updateConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.mas_bottomLayoutGuideBottom).offset(0);
        }];
        [self.view layoutIfNeeded];
    } completion:^(BOOL finished) {
        [datePicker removeFromSuperview];
    }];
}

- (void)datePickerView:(MSBaseDatePickerView *)datePicker cancleWithDate:(NSDate *)date {
    [UIView animateWithDuration:0.3 delay:0 options:(UIViewAnimationOptionCurveEaseIn) animations:^{
        [datePicker mas_updateConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.mas_bottomLayoutGuideBottom).offset(0);
        }];
        [self.view layoutIfNeeded];
    } completion:^(BOOL finished) {
        [datePicker removeFromSuperview];
    }];
}

@end
