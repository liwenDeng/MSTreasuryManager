//
//  MSToolBorrowViewController.m
//  MSTreasuryManager
//
//  Created by 邓利文 on 2016/10/14.
//  Copyright © 2016年 邓利文. All rights reserved.
//

#import "MSToolBorrowViewController.h"
#import "MSMaterialFillInWithSearchSection.h"
#import "MSMaterialFillInNomalSection.h"
#import "MSToolInfoFillInSection.h"
#import "YZInputView.h"
#import "MSBaseDatePickerView.h"
#import "MSBaseButton.h"
#import "MSSearchStaffViewController.h"
#import "MSSearchToolViewController.h"
#import "MSStaffModel.h"
#import "MSToolModel.h"
#import "MSNetworking+Tool.h"
#import "MSLiveWorkFillinTagsSection.h"

@interface MSToolBorrowViewController () <MSBaseDatePickerViewDelegate,MSCommonSearchViewControllerDelegate>

@property (nonatomic, strong) UIScrollView *scrollView;

@property (nonatomic, strong) YZInputView *toolNameInput;
@property (nonatomic, strong) YZInputView *reasonInput;
@property (nonatomic, strong) UITextField *dateInput;
@property (nonatomic, strong) UITextField *borrowUserInput;
@property (nonatomic, strong) UITextField *borrowUserTelInput;
@property (nonatomic, strong) UITextField *reviewUserInput;

// multiSection
@property (nonatomic, strong) MSLiveWorkFillinTagsSection *multiToolNameSection;

@property (nonatomic, strong) MSBaseDatePickerView *datePickerView;

@property (nonatomic, strong) MSToolModel *toolModel;

@end

@implementation MSToolBorrowViewController

- (instancetype)initWithToolModel:(MSToolModel *)tool {
    if (self = [super init]) {
        _toolModel = tool;
    }
    return self;
}

- (instancetype)initWithMultiSelect:(BOOL)multiSelect {
    if (self = [super init]) {
        _multiBorrow = multiSelect;
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self setupSubViews];
}

- (void)setupSubViews {

    self.title = @"工器具借用";
    self.scrollView = [[UIScrollView alloc]init];
    [self.view addSubview:self.scrollView];
    self.scrollView.backgroundColor = kBackgroundColor;
    
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(dismissKeyboardAction:)];
//    tap.cancelsTouchesInView = NO;//防止tap影响subView响应事件
    [self.view addGestureRecognizer:tap];
    
    [self setupSections];
    
    self.dateInput.text = [[NSDate date] ms_dateString];

}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    if (self.toolModel.name.length) {
        self.toolNameInput.text = self.toolModel.name;
    }
}

- (void)setupSections {
    UIView *bgView = ({
        UIView *view = [[UIView alloc]init];
        [self.scrollView addSubview:view];
        
        view;
    });
    
    MSToolInfoFillInSection *section2 = [[MSToolInfoFillInSection alloc]initWithTitle:@"借用事由" placeholder:@"请填写事由"];
    MSMaterialFillInNomalSection *section3 = [[MSMaterialFillInNomalSection alloc]initWithTitle:@"借用时间" placeholder:@"选择日期" canTouch:YES];
    MSMaterialFillInNomalSection *section4 = [[MSMaterialFillInNomalSection alloc]initWithTitle:@"借用人" placeholder:@"选择人员" canTouch:YES showSearchButton:YES];
    MSMaterialFillInNomalSection *section5 = [[MSMaterialFillInNomalSection alloc]initWithTitle:@"借用人电话" placeholder:@"输入电话"];
    MSMaterialFillInNomalSection *section6 = [[MSMaterialFillInNomalSection alloc]initWithTitle:@"审核人" placeholder:@"选择人员" canTouch:YES];
    
    [bgView addSubview:section2];
    [bgView addSubview:section3];
    [bgView addSubview:section4];
    [bgView addSubview:section5];
    [bgView addSubview:section6];
    
    if (!self.multiBorrow) {
        MSMaterialFillInWithSearchSection *section1 = [[MSMaterialFillInWithSearchSection alloc]initWithTitle:@"工器具名称" placeholder:@"请选择工器具"];
        [bgView addSubview:section1];
        self.toolNameInput = section1.inputView;
        self.toolNameInput.editable = NO;
        [section1.searchBtn addTarget:self action:@selector(searchNameBtnClicked:) forControlEvents:(UIControlEventTouchUpInside)];
        
        [section1 mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(0);
            make.top.mas_equalTo(20);
            make.width.mas_equalTo(kSCREEN_WIDTH);
        }];
        
        [section2 mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(section1.mas_bottom).offset(20);
            make.left.mas_equalTo(0);
            make.width.mas_equalTo(kSCREEN_WIDTH);
        }];
        
        
        //为工器具名称添加点击事件
        UITapGestureRecognizer *tapName = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(searchNameBtnClicked:)];
        [self.toolNameInput addGestureRecognizer:tapName];
        
    }else {
        MSLiveWorkFillinTagsSection *multiSection1 = [[MSLiveWorkFillinTagsSection alloc]initWithTitle:@"工器具名称" placeholder:nil];
        [multiSection1.addBtn addTarget:self action:@selector(multiSearchNameBtnClicked:) forControlEvents:(UIControlEventTouchUpInside)];
        [bgView addSubview:multiSection1];
        self.multiToolNameSection = multiSection1;
        [multiSection1 mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(0);
            make.top.mas_equalTo(20);
            make.width.mas_equalTo(kSCREEN_WIDTH);
        }];
        
        [section2 mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(multiSection1.mas_bottom).offset(20);
            make.left.mas_equalTo(0);
            make.width.mas_equalTo(kSCREEN_WIDTH);
        }];
    }
    
    self.reasonInput = section2.fillInView;
    self.dateInput = section3.textField;
    self.borrowUserInput = section4.textField;
    self.borrowUserTelInput = section5.textField;
    self.reviewUserInput = section6.textField;
    
    [section3.actionBtn addTarget:self action:@selector(dateInputClicked:) forControlEvents:(UIControlEventTouchUpInside)];
    [section4.actionBtn addTarget:self action:@selector(borrowUserInputClicked:) forControlEvents:(UIControlEventTouchUpInside)];
    [section6.actionBtn addTarget:self action:@selector(reviewUserInputClicked:) forControlEvents:(UIControlEventTouchUpInside)];

    [section3 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(0);
        make.top.equalTo(section2.mas_bottom).offset(20);
        make.width.mas_equalTo(kSCREEN_WIDTH);
        make.height.mas_equalTo(44);
    }];

    [section4 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(section3.mas_bottom).offset(0);
        make.height.mas_equalTo(44);
        make.left.mas_equalTo(0);
        make.width.mas_equalTo(kSCREEN_WIDTH);
    }];
    
    [section5 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(section4.mas_bottom).offset(0);
        make.height.mas_equalTo(44);
        make.left.mas_equalTo(0);
        make.width.mas_equalTo(kSCREEN_WIDTH);
    }];
    
    [section6 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(section5.mas_bottom).offset(0);
        make.height.mas_equalTo(44);
        make.left.mas_equalTo(0);
        make.width.mas_equalTo(kSCREEN_WIDTH);
    }];
    
    
    //
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
        make.bottom.equalTo(btn.mas_bottom).offset(60);
    }];
    
    [self.scrollView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.view);
        make.edges.equalTo(bgView);
    }];
    
}


#pragma mark - ClickAction
- (void)searchNameBtnClicked:(UIButton *)sender {
    MSSearchToolViewController *s = [[MSSearchToolViewController alloc]initWithSearchType:(MSSearchTypeToolInStore)];
    s.delegate = self;
    [self.navigationController pushViewController:s animated:YES];
}

- (void)multiSearchNameBtnClicked:(UIButton *)sender {
    MSSearchToolViewController *s = [[MSSearchToolViewController alloc]initWithSearchType:(MSSearchTypeToolInStore)];
    s.delegate = self;
    s.allowMultiselect = YES;
    [self.navigationController pushViewController:s animated:YES];
}

- (void)dateInputClicked:(UIButton *)sender {
    [self showDatePickerView];
}

- (void)borrowUserInputClicked:(UIButton *)sender {
    MSSearchStaffViewController * s = [[MSSearchStaffViewController alloc]initWithSearchType:(MSSearchTypeBorrowPerson)];
    s.delegate = self;
    [self.navigationController pushViewController:s animated:YES];
}

- (void)reviewUserInputClicked:(UIButton *)sender {
    MSSearchStaffViewController * s = [[MSSearchStaffViewController alloc]initWithSearchType:(MSSearchTypeReviewPerson)];
    s.delegate = self;
    [self.navigationController pushViewController:s animated:YES];
}

- (void)submitBtnClicked:(UIButton *)sender {
    if (![self checkParams]) {
        return;
    }
    
    if (self.multiBorrow) {
        [SVProgressHUD show];
        [MSNetworking changeTool:self.toolModel toolNames:self.multiToolNameSection.users borrowOut:YES success:^(NSDictionary *object) {
            [SVProgressHUD showSuccessWithStatus:@"借用成功"];
            [self resetPages];
        } failure:^(NSError *error) {
            [SVProgressHUD showErrorWithStatus:@"借用失败"];
        }];
    }else {
        [SVProgressHUD show];
        [MSNetworking changeTool:self.toolModel borrowOut:YES success:^(NSDictionary *object) {
            [SVProgressHUD showSuccessWithStatus:@"借用成功"];
            [self resetPages];
        } failure:^(NSError *error) {
            [SVProgressHUD showErrorWithStatus:@"借用失败"];
        }];
    }
}

- (BOOL)checkParams {
    BOOL ret = YES;
    
    if (self.multiBorrow) {
        if (!self.multiToolNameSection.users.count ) {
            [MSDialog showAlert:@"请选择工器具名称"];
            return NO;
        }
    }else {
        if (!self.toolNameInput.text.length ) {
            [MSDialog showAlert:@"请选择工器具名称"];
            return NO;
        }
    }
    
    if (!self.reasonInput.text.length ) {
        [MSDialog showAlert:@"请填写借用事由"];
        return NO;
    }
    if (!self.dateInput.text.length ) {
        [MSDialog showAlert:@"请选择时间"];
        return NO;
    }
    if (!self.borrowUserInput.text.length ) {
        [MSDialog showAlert:@"请选择或填写借用人"];
        return NO;
    }
    if (!self.borrowUserTelInput.text.length ) {
        [MSDialog showAlert:@"请填写借用人电话"];
        return NO;
    }
    if (!self.reviewUserInput.text.length ) {
        [MSDialog showAlert:@"请选择审核人"];
        return NO;
    }

    self.toolModel.reason = self.reasonInput.text;
    self.toolModel.time = self.dateInput.text;
    self.toolModel.operator = self.borrowUserInput.text;
    self.toolModel.phone = self.borrowUserTelInput.text;
    self.toolModel.auditor = self.reviewUserInput.text;
    self.toolModel.status = @"1";
//    
    return ret;
}

- (void)resetPages {
    self.toolNameInput.text = nil;
    self.reasonInput.text = nil;
    self.dateInput.text = nil;
    self.borrowUserInput.text = nil;
    self.borrowUserTelInput.text = nil;
    [self.multiToolNameSection deleteAllUsers];
}

- (void)dismissKeyboardAction:(UITapGestureRecognizer *)tap {
    [self hideDatePickerView];
    [self.view endEditing:YES];
}

#pragma mark - MSCommonSearchViewControllerDelegate
- (void)searchViewController:(MSSearchType)searchType didSelectModel:(id)resultModel {
    switch (searchType) {
        case MSSearchTypeBorrowPerson:
            //借用人
        {
            MSStaffModel *model = (MSStaffModel *)resultModel;
            self.borrowUserInput.text = model.name;
            self.borrowUserTelInput.text = model.phone;
        }
            break;
        case MSSearchTypeReviewPerson:
        {
            //审核人
            MSStaffModel *model = (MSStaffModel *)resultModel;
            self.reviewUserInput.text = model.name;
        }
            break;
            
        case MSSearchTypeToolInStore:
        {
            //在库工具
            MSToolModel *model = (MSToolModel *)resultModel;
            self.toolNameInput.text = model.name;
            self.toolModel.name = model.name;
            self.toolModel.toolId = model.toolId;
        }
            break;
        default:
            break;
    }
}

- (void)searchViewController:(MSSearchType)searchType didSelectSet:(NSSet *)selectSet {
    if (searchType == MSSearchTypeToolInStore && self.multiBorrow) {
        for (NSString *personName in selectSet) {
            if (![self.multiToolNameSection.tagList.tagArray containsObject:personName]) {
                [self.multiToolNameSection addUser:personName];
            }
        }
    }
}

#pragma mark - MSBaseDatePickerViewDelegate
- (void)datePickerView:(MSBaseDatePickerView *)datePicker submitWithDate:(NSDate *)date {
    NSLog(@"date:%@",date);
    self.dateInput.text = [date ms_dateString];
    [self hideDatePickerView];
}

- (void)datePickerView:(MSBaseDatePickerView *)datePicker cancleWithDate:(NSDate *)date {
    [self hideDatePickerView];
}

- (void)showDatePickerView {
    [self.view endEditing:YES];
    if (self.datePickerView.hidden) {
        self.datePickerView.hidden = NO;
        [UIView animateWithDuration:0.3 delay:0 options:(UIViewAnimationOptionCurveEaseOut) animations:^{
            [self.datePickerView mas_updateConstraints:^(MASConstraintMaker *make) {
                make.top.equalTo(self.mas_bottomLayoutGuideBottom).offset(-240);
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
            make.height.mas_equalTo(240);
        }];
        _datePickerView.delegate = self;
        _datePickerView.hidden = YES;
        [self.view layoutIfNeeded];
    }
    return _datePickerView;
}

- (MSToolModel *)toolModel {
    if (!_toolModel) {
        _toolModel = [[MSToolModel alloc]init];
        _toolModel.status = @"1";
    }
    
    return _toolModel;
}

@end
