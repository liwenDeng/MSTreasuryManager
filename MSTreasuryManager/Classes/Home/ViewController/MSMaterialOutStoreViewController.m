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
#import "MSCommonSearchViewController.h"

@interface MSMaterialOutStoreViewController () <MSBaseDatePickerViewDelegate>

@property (nonatomic, strong) UIScrollView *scrollView;
@property (nonatomic, strong) YZInputView *nameInput;
@property (nonatomic, strong) YZInputView *placeInput;

@property (nonatomic, strong) UITextField *outCountInput;
@property (nonatomic, strong) UITextField *dateInput;
@property (nonatomic, strong) UITextField *handleUserInput; //经办人
@property (nonatomic, strong) UITextField *reviewUserInput;   //审核人
@property (nonatomic, strong) MSBaseDatePickerView *datePickerView;

@property (nonatomic, assign) MSCellIndexOfType type;

@end

@implementation MSMaterialOutStoreViewController

- (instancetype)initWithType:(MSCellIndexOfType)type {
    if (self = [super init]) {
        self.type = type;
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setupSubViews];
}

- (void)setupSubViews {

    if (self.type == MSCellIndexOfTypeMaterialOut) {
        self.title = @"物资出库";
    }else {
        self.title = @"物资入库";
    }
    
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
    
    NSString *title = self.type == MSCellIndexOfTypeMaterialOut ? @"出库位置" : @"入库位置";
    NSString *placehodler = self.type == MSCellIndexOfTypeMaterialOut ? @"请选择出库位置" : @"请选择入库位置";
    MSMaterialFillInWithSearchSection *section2 = [[MSMaterialFillInWithSearchSection alloc]initWithTitle:title placeholder:placehodler];
    self.placeInput = section2.inputView;
    self.placeInput.editable = NO;
    [bgView addSubview:section2];
    [section2 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(0);
        make.top.equalTo(section1.mas_bottom).offset(20);
        make.width.mas_equalTo(kSCREEN_WIDTH);
    }];
    [section2.searchBtn addTarget:self action:@selector(searchPlaceBtnClicked:) forControlEvents:(UIControlEventTouchUpInside)];
    
    //为物资名称和技术参数输入框添加点击事件
    UITapGestureRecognizer *tapName = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(searchNameBtnClicked:)];
    [self.nameInput addGestureRecognizer:tapName];
    
    UITapGestureRecognizer *tapParams = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(searchPlaceBtnClicked:)];
    [self.placeInput addGestureRecognizer:tapParams];
    
    NSString *title3 = self.type == MSCellIndexOfTypeMaterialOut ? @"出库数量" : @"入库数量";
    NSString *title4 = self.type == MSCellIndexOfTypeMaterialOut ? @"出库日期" : @"入库日期";
    MSMaterialFillInNomalSection *section3 = [[MSMaterialFillInNomalSection alloc]initWithTitle:title3 placeholder:@"填写数量"];
    MSMaterialFillInNomalSection *section4 = [[MSMaterialFillInNomalSection alloc]initWithTitle:title4 placeholder:@"2016-01-01" canTouch:YES];
    MSMaterialFillInNomalSection *section5 = [[MSMaterialFillInNomalSection alloc]initWithTitle:@"经办人" placeholder:@"选择人员" canTouch:YES];
    MSMaterialFillInNomalSection *section6 = [[MSMaterialFillInNomalSection alloc]initWithTitle:@"审核人" placeholder:@"选择人员" canTouch:YES];
    
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

    //add touch action
    [section4.actionBtn addTarget:self action:@selector(dateInputClicked:) forControlEvents:(UIControlEventTouchUpInside)];
    [section5.actionBtn addTarget:self action:@selector(handleUserInputClicked:) forControlEvents:(UIControlEventTouchUpInside)];
    [section6.actionBtn addTarget:self action:@selector(reviewUserInputClicked:) forControlEvents:(UIControlEventTouchUpInside)];
    
    
//    //subMitBtn
    MSBaseButton *btn = [[MSBaseButton alloc]initWithTitle:@"提    交"];
    [bgView addSubview:btn];
    [btn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(section6.mas_bottom).offset(60);
        make.left.mas_equalTo(20);
        make.height.mas_equalTo(40);
        make.width.mas_equalTo(kSCREEN_WIDTH - 40);
    }];
    [btn addTarget:self action:@selector(submitBtnClicked:) forControlEvents:(UIControlEventTouchUpInside)];
    
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
    MSCommonSearchViewController *s = [[MSCommonSearchViewController alloc]initWithSearchType:(MSSearchTypeMaterialName)];
    [self.navigationController pushViewController:s animated:YES];
}

- (void)searchPlaceBtnClicked:(UIButton *)sender {
    MSCommonSearchViewController *s = [[MSCommonSearchViewController alloc]initWithSearchType:(MSSearchTypeMaterialParams)];
    [self.navigationController pushViewController:s animated:YES];
}

- (void)dateInputClicked:(UIButton *)sender {
    [self showDatePickerView];
}

- (void)handleUserInputClicked:(UIButton *)sender {
    MSCommonSearchViewController *s = [[MSCommonSearchViewController alloc]initWithSearchType:(MSSearchTypePerson)];
    [self.navigationController pushViewController:s animated:YES];
}

- (void)reviewUserInputClicked:(UIButton *)sender {
    MSCommonSearchViewController *s = [[MSCommonSearchViewController alloc]initWithSearchType:(MSSearchTypePerson)];
    [self.navigationController pushViewController:s animated:YES];
}

- (void)dismissKeyboardAction {
    [self hideDatePickerView];
    [self.view endEditing:YES];
}

- (void)submitBtnClicked:(UIButton *)sender {
    switch (self.type) {
        case MSCellIndexOfTypeMaterialOut:
        {
            //物资出库
        }
            break;
        case MSCellIndexOfTypeMateriaIn:
        {
            //物资入库
        }
        default:
            break;
    }
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
