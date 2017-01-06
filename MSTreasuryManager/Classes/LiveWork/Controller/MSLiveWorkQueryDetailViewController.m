//
//  MSLiveWorkQueryDetailViewController.m
//  MSTreasuryManager
//
//  Created by 邓利文 on 2016/10/24.
//  Copyright © 2016年 邓利文. All rights reserved.
//

#import "MSLiveWorkQueryDetailViewController.h"
#import "MSLiveWorkFillinTagsSection.h"
#import "MSToolInfoFillInSection.h"
#import "MSMaterialFillInNomalSection.h"
#import "MSOutInMultiLineSection.h"
#import "MSNetworking+LiveWork.h"
#import "MSSearchStaffViewController.h"
#import "MSMultiSearchViewController.h"
#import "MSStaffModel.h"

/**
 可修改内容：
 除时间、参会人员、注意事项
 
 1.工作负责人
 2.工作班组成员
 3.工作内容
 4.工作记录
 
 */

@interface MSLiveWorkQueryDetailViewController () <MSCommonSearchViewControllerDelegate>

@property (nonatomic, strong) UIScrollView *scrollView;

@property (nonatomic, strong) NSMutableArray *classMemberList;   //工作班组成员
@property (nonatomic, strong) NSMutableArray *meetingMemberList;   //工作班组成员

@property (nonatomic, strong) UITextField *dateField;
@property (nonatomic, strong) UITextField *leaderField; //负责人
@property (nonatomic, strong) YZInputView *workContentInput;//工作内容
@property (nonatomic, strong) YZInputView *workRecordInput; //工作记录
@property (nonatomic, strong) UILabel *workNoteInput;   //注意事项

@property (nonatomic, weak) MSMaterialFillInNomalSection *leaderSection;    //负责人
@property (nonatomic, weak) MSLiveWorkFillinTagsSection *classMemberSection;//班组成员
@property (nonatomic, weak) UIView *contextSection;//工作内容
@property (nonatomic, weak) UIView *recordSection;//工作记录

@property (nonatomic, weak) MSLiveWorkFillinTagsSection *meetingMemberSection;

@property (nonatomic, assign) NSInteger liveWorkId;

@end

@implementation MSLiveWorkQueryDetailViewController

- (instancetype)initWithLiveWorkId:(NSInteger)liveWorkId {
    if (self = [super init]) {
        _liveWorkId = liveWorkId;
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.title = @"现场工作详情";
    [self setupSubViews];
}

- (void)setupSubViews {
    
    self.scrollView = [[UIScrollView alloc]init];
    [self.view addSubview:self.scrollView];
    self.scrollView.backgroundColor = kBackgroundColor;
    
    UIBarButtonItem *editButton = [[UIBarButtonItem alloc]initWithTitle:@"修改" style:(UIBarButtonItemStylePlain) target:self action:@selector(editLiveWorkDetail:)];
    self.navigationItem.rightBarButtonItem = editButton;
    
    [self setupSections];
    [self loadLiveWorkDetailInfo];
}

- (void)setupSections {
    UIView *bgView = ({
        UIView *view = [[UIView alloc]init];
        [self.scrollView addSubview:view];
        
        view;
    });
    
    MSMaterialFillInNomalSection *section1 = [[MSMaterialFillInNomalSection alloc]initWithTitle:@"工作日期" placeholder:@"选择日期" canTouch:YES];
    MSMaterialFillInNomalSection *section2 = [[MSMaterialFillInNomalSection alloc]initWithTitle:@"工作负责人" placeholder:@"选择人员" canTouch:YES];
    MSLiveWorkFillinTagsSection *section3 = [[MSLiveWorkFillinTagsSection alloc]initWithTitle:@"工作班成员" placeholder:nil showDeleteBtn:YES];
    section3.addBtn.hidden = YES;
    
    MSToolInfoFillInSection *section4 = [[MSToolInfoFillInSection alloc]initWithTitle:@"工作内容" placeholder:@"请填写工作内容"];
    
    MSToolInfoFillInSection *section5 = [[MSToolInfoFillInSection alloc]initWithTitle:@"工作记录" placeholder:@"请填写工作记录"];
    
//    MSOutInMultiLineSection *section4 = [[MSOutInMultiLineSection alloc]initWithTitle:@"工作内容"];
//    
//    MSOutInMultiLineSection *section5 = [[MSOutInMultiLineSection alloc]initWithTitle:@"工作记录"];
    
    MSLiveWorkFillinTagsSection *section6 = [[MSLiveWorkFillinTagsSection alloc]initWithTitle:@"参会人员" placeholder:nil showDeleteBtn:NO];
    section6.addBtn.hidden = YES;
    
    MSOutInMultiLineSection *section7 = [[MSOutInMultiLineSection alloc]initWithTitle:@"注意事项"];
    
    //点击事件
    [section2.actionBtn addTarget:self action:@selector(chooseLeader) forControlEvents:(UIControlEventTouchUpInside)];
    [section3.addBtn addTarget:self action:@selector(addClassMember) forControlEvents:(UIControlEventTouchUpInside)];
    
    self.leaderSection = section2;
    self.classMemberSection = section3;
    self.contextSection = section4;
    self.recordSection = section5;
    
    [bgView addSubview:section1];
    [bgView addSubview:section2];
    [bgView addSubview:section3];
    [bgView addSubview:section4];
    [bgView addSubview:section5];
    [bgView addSubview:section6];
    [bgView addSubview:section7];
    
    section1.userInteractionEnabled = NO;
    section2.userInteractionEnabled = NO;
    section3.userInteractionEnabled = NO;
    section4.userInteractionEnabled = NO;
    section5.userInteractionEnabled = NO;
    section6.userInteractionEnabled = NO;
    
    _dateField = section1.textField;
    _leaderField = section2.textField;
    _workContentInput = section4.fillInView;
    _workRecordInput = section5.fillInView;
    _workNoteInput = section7.subLabel;
    
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
        make.top.equalTo(section2.mas_bottom).offset(20);
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
    
    [bgView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.mas_equalTo(kSCREEN_WIDTH);
        make.bottom.equalTo(section7).offset(20);
    }];
    
    _classMemberSection = section3;
    _meetingMemberSection = section6;
    
    [self.scrollView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.view);
        make.edges.equalTo(bgView);
    }];
}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];

}

- (void)fillInWithLiveWork:(MSLiveWorkModel *)model {

    self.dateField.text = model.workTime;
    self.leaderField.text = model.chargePerson;
    NSArray *member = [MSLiveWorkModel personArrayFromPersonString:model.member];
    [self.classMemberSection addUsers:member];
    self.workContentInput.text = model.context;
    self.workRecordInput.text = model.workRecord;
    
    NSArray *persons = [MSLiveWorkModel personArrayFromPersonString:model.persons];
    [self.meetingMemberSection addUsers:persons];
    self.workNoteInput.text = model.attention;

}

#pragma mark - EditAction 
- (void)editLiveWorkDetail:(UIBarButtonItem *)editItem {
    if ([editItem.title isEqualToString:@"修改"]) {
        //点击修改
        editItem.title = @"提交";
        [self changeViewCanEdit:YES];
    }else {
        //点击提交
        editItem.title = @"修改";
        [self changeViewCanEdit:NO];
        [self commitEdit];
    }
}

- (void)changeViewCanEdit:(BOOL)canEdit {
    self.leaderSection.userInteractionEnabled = canEdit;
    self.classMemberSection.userInteractionEnabled = canEdit;
    self.contextSection.userInteractionEnabled = canEdit;
    self.recordSection.userInteractionEnabled = canEdit;
    self.classMemberSection.addBtn.hidden = !canEdit;
}

- (void)chooseLeader {
    MSSearchStaffViewController *search = [[MSSearchStaffViewController alloc]initWithSearchType:(MSSearchTypeChargePerson)];
    search.delegate = self;
    [self.navigationController pushViewController:search animated:YES];
}

- (void)addClassMember {
    MSMultiSearchViewController *search = [[MSMultiSearchViewController alloc]initWithSearchType:(MSSearchTypeMemberPerson)];
    search.delegate = self;
    [self.navigationController pushViewController:search animated:YES];
}

#pragma mark - MSCommonSearchViewControllerDelegate
- (void)searchViewController:(MSSearchType)searchType didSelectModel:(id)resultModel {
    MSStaffModel *staff = (MSStaffModel *)resultModel;
    //负责人
    if (searchType == MSSearchTypeChargePerson) {
        self.leaderField.text = staff.name;
    }
}

- (void)searchViewController:(MSSearchType)searchType didSelectSet:(NSSet *)selectSet {
    if (searchType == MSSearchTypeMemberPerson) {
        for (NSString *personName in selectSet) {
            if (![self.classMemberSection.tagList.tagArray containsObject:personName]) {
                [self.classMemberSection addUser:personName];
            }
        }
    }
}

#pragma mark - HTTP Request
- (void)loadLiveWorkDetailInfo {
    [SVProgressHUD show];
    [MSNetworking getLiveWorkDetailInfo:self.liveWorkId success:^(NSDictionary *object) {
        [SVProgressHUD showSuccessWithStatus:@"查询成功"];
        MSLiveWorkModel *model = [MSLiveWorkModel mj_objectWithKeyValues:object[@"data"]];
        [self fillInWithLiveWork:model];
    } failure:^(NSError *error) {
        [SVProgressHUD showErrorWithStatus:@"查询失败"];
    }];
}

- (void)commitEdit {
    MSLiveWorkModel *fillModel = [[MSLiveWorkModel alloc]init];
    
    fillModel.workId = self.liveWorkId;
    fillModel.workTime = self.dateField.text;
    fillModel.chargePerson = self.leaderField.text;
    fillModel.member = [MSLiveWorkModel personStringFromPersonArray:self.classMemberSection.users];
    fillModel.context = self.workContentInput.text;
    fillModel.workRecord = self.workRecordInput.text;
    fillModel.persons = [MSLiveWorkModel personStringFromPersonArray:self.meetingMemberSection.users];
    fillModel.attention = self.workNoteInput.text;
    
    [MSNetworking updateLiveWork:fillModel success:^(NSDictionary *object) {
        [SVProgressHUD showSuccessWithStatus:@"填写成功"];
    } failure:^(NSError *error) {
        [SVProgressHUD showErrorWithStatus:@"填写失败"];
    }];
}

@end
