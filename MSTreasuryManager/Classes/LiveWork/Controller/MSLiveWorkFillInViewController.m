//
//  MSLiveWorkFillInViewController.m
//  MSTreasuryManager
//
//  Created by 邓利文 on 2016/10/22.
//  Copyright © 2016年 邓利文. All rights reserved.
//

#import "MSLiveWorkFillInViewController.h"
#import "MSMaterialFillInNomalSection.h"
#import "MSBaseDatePickerView.h"
#import "MSLiveWorkFillinTagsSection.h"
#import "MSToolInfoFillInSection.h"
#import "MSBaseButton.h"
#import "MSNetworking+LiveWork.h"
#import "MSSearchStaffViewController.h"
#import "MSStaffModel.h"

static int i = 0;

@interface MSLiveWorkFillInViewController () <MSBaseDatePickerViewDelegate,MSCommonSearchViewControllerDelegate>

@property (nonatomic, strong) UIScrollView *scrollView;
@property (nonatomic, strong) MSBaseDatePickerView *datePickerView;

@property (nonatomic, strong) NSMutableArray *classMemberList;   //工作班组成员
@property (nonatomic, strong) NSMutableArray *meetingMemberList;   //工作班组成员

@property (nonatomic, strong) UITextField *dateField;
@property (nonatomic, strong) UITextField *leaderField; //负责人
@property (nonatomic, strong) YZInputView *workContentInput;//工作内容
@property (nonatomic, strong) YZInputView *workRecordInput; //工作记录
@property (nonatomic, strong) YZInputView *workNoteInput;   //注意事项
@property (nonatomic, weak) MSLiveWorkFillinTagsSection *classMemberSection;
@property (nonatomic, weak) MSLiveWorkFillinTagsSection *meetingMemberSection;

@property (nonatomic, strong) MSLiveWorkModel *fillModel;

@end

@implementation MSLiveWorkFillInViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.fillModel = [[MSLiveWorkModel alloc]init];
    self.title = @"现场工作填写";
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
    
    MSMaterialFillInNomalSection *section1 = [[MSMaterialFillInNomalSection alloc]initWithTitle:@"工作日期" placeholder:@"选择日期" canTouch:YES];
    MSMaterialFillInNomalSection *section2 = [[MSMaterialFillInNomalSection alloc]initWithTitle:@"工作负责人" placeholder:@"选择人员" canTouch:YES];
    MSLiveWorkFillinTagsSection *section3 = [[MSLiveWorkFillinTagsSection alloc]initWithTitle:@"工作班成员" placeholder:nil];
    
    MSToolInfoFillInSection *section4 = [[MSToolInfoFillInSection alloc]initWithTitle:@"工作内容" placeholder:@"请填写工作内容"];
    
    MSToolInfoFillInSection *section5 = [[MSToolInfoFillInSection alloc]initWithTitle:@"工作记录" placeholder:@"请填写工作记录"];
    
    MSLiveWorkFillinTagsSection *section6 = [[MSLiveWorkFillinTagsSection alloc]initWithTitle:@"参会人员" placeholder:nil];
    
    MSToolInfoFillInSection *section7 = [[MSToolInfoFillInSection alloc]initWithTitle:@"注意事项" placeholder:@"请填写注意事项"];
    
    [bgView addSubview:section1];
    [bgView addSubview:section2];
    [bgView addSubview:section3];
    [bgView addSubview:section4];
    [bgView addSubview:section5];
    [bgView addSubview:section6];
    [bgView addSubview:section7];
    _dateField = section1.textField;
    _leaderField = section2.textField;
    _workContentInput = section4.fillInView;
    _workRecordInput = section5.fillInView;
    _workNoteInput = section7.fillInView;
    
    [section1.actionBtn addTarget:self action:@selector(chooseDate) forControlEvents:(UIControlEventTouchUpInside)];
    [section2.actionBtn addTarget:self action:@selector(chooseLeader) forControlEvents:(UIControlEventTouchUpInside)];
    [section3.addBtn addTarget:self action:@selector(addClassMember) forControlEvents:(UIControlEventTouchUpInside)];
    [section6.addBtn addTarget:self action:@selector(addMeetingMember) forControlEvents:(UIControlEventTouchUpInside)];
    
    [section1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(0);
        make.top.mas_equalTo(20);
        make.height.mas_equalTo(44);
        make.width.mas_equalTo(kSCREEN_WIDTH);
    }];
    
    [section2 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(section1.mas_bottom).offset(0);
        make.left.mas_equalTo(0);
        make.height.mas_equalTo(44);
        make.width.mas_equalTo(kSCREEN_WIDTH);
    }];
    
    [section3 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(0);
        make.top.equalTo(section2.mas_bottom).offset(0);
        make.width.mas_equalTo(kSCREEN_WIDTH);
    }];
    
    [section4 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(section3.mas_bottom).offset(20);
        make.left.mas_equalTo(0);
        make.width.mas_equalTo(kSCREEN_WIDTH);
    }];
    
    [section5 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(section4.mas_bottom).offset(20);
        make.left.mas_equalTo(0);
        make.width.mas_equalTo(kSCREEN_WIDTH);
    }];
    
    [section6 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(section5.mas_bottom).offset(20);
        make.left.mas_equalTo(0);
        make.width.mas_equalTo(kSCREEN_WIDTH);
    }];

    [section7 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(section6.mas_bottom).offset(20);
        make.left.mas_equalTo(0);
        make.width.mas_equalTo(kSCREEN_WIDTH);
    }];
    
    MSBaseButton *btn = [[MSBaseButton alloc]initWithTitle:@"提    交"];
    [bgView addSubview:btn];
    [btn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(section7.mas_bottom).offset(20);
        make.left.mas_equalTo(20);
        make.height.mas_equalTo(40);
        make.width.mas_equalTo(kSCREEN_WIDTH - 40);
    }];
    
    [btn addTarget:self action:@selector(submitBtnClicked) forControlEvents:(UIControlEventTouchUpInside)];
    
    [bgView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.mas_equalTo(kSCREEN_WIDTH);
        make.bottom.equalTo(btn.mas_bottom).offset(20);
    }];
    
    _classMemberSection = section3;
    _meetingMemberSection = section6;
    
    [self.scrollView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.view);
        make.edges.equalTo(bgView);
    }];
}


#pragma mark - tap action
- (void)chooseDate {
    [self showDatePickerView];
}

- (void)chooseLeader {
    MSSearchStaffViewController *search = [[MSSearchStaffViewController alloc]initWithSearchType:(MSSearchTypeChargePerson)];
    search.delegate = self;
    [self.navigationController pushViewController:search animated:YES];
}

- (void)addClassMember {
    MSSearchStaffViewController *search = [[MSSearchStaffViewController alloc]initWithSearchType:(MSSearchTypeMemberPerson)];
    search.delegate = self;
    [self.navigationController pushViewController:search animated:YES];
}

- (void)addMeetingMember {
    MSSearchStaffViewController *search = [[MSSearchStaffViewController alloc]initWithSearchType:(MSSearchTypeMettingPerson)];
    search.delegate = self;
    [self.navigationController pushViewController:search animated:YES];
}

- (void)submitBtnClicked {

}

- (void)dismissKeyboardAction:(UITapGestureRecognizer *)tap {
    [self hideDatePickerView];
    [self.view endEditing:YES];
}

#pragma mark - MSCommonSearchViewControllerDelegate
- (void)searchViewController:(MSCommonSearchViewController *)searchController didSelectModel:(id)resultModel {
    MSStaffModel *staff = (MSStaffModel *)resultModel;
    //负责人
    if (searchController.searchType == MSSearchTypeChargePerson) {
        self.fillModel.charge_person = staff.name;
        self.leaderField.text = staff.name;
    }
    
    if (searchController.searchType == MSSearchTypeMemberPerson) {
        [self.meetingMemberSection addUser:staff.name];
    }
    
}

#pragma mark - MSBaseDatePickerViewDelegate
- (void)datePickerView:(MSBaseDatePickerView *)datePicker submitWithDate:(NSDate *)date {

    NSString *dateString = [date ms_dateString];
    self.fillModel.work_time = dateString;
    self.dateField.text = dateString;
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

- (NSMutableArray *)classMemberList {
    if (!_classMemberList) {
        _classMemberList = [NSMutableArray array];
    }
    return _classMemberList;
}

- (NSMutableArray *)meetingMemberList {
    if (!_meetingMemberList) {
        _meetingMemberList = [NSMutableArray array];
    }
    return _meetingMemberList;
}

@end
