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
#import "MSLiveWorkFillInViewController.h"

@interface MSLiveWorkQueryDetailViewController ()

@property (nonatomic, strong) UIScrollView *scrollView;

@property (nonatomic, strong) NSMutableArray *classMemberList;   //工作班组成员
@property (nonatomic, strong) NSMutableArray *meetingMemberList;   //工作班组成员

@property (nonatomic, strong) UITextField *dateField;
@property (nonatomic, strong) UITextField *leaderField; //负责人
@property (nonatomic, strong) UILabel *workContentInput;//工作内容
@property (nonatomic, strong) UILabel *workRecordInput; //工作记录
@property (nonatomic, strong) UILabel *workNoteInput;   //注意事项
@property (nonatomic, weak) MSLiveWorkFillinTagsSection *classMemberSection;
@property (nonatomic, weak) MSLiveWorkFillinTagsSection *meetingMemberSection;

@property (nonatomic, strong) MSLiveWorkModel *detailLiveWork;
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
    
    UIBarButtonItem *edit = [[UIBarButtonItem alloc]initWithTitle:@"修改" style:(UIBarButtonItemStylePlain) target:self action:@selector(editLiveWork)];
    self.navigationItem.rightBarButtonItem = edit;
    self.navigationItem.rightBarButtonItem.enabled = NO;
}

- (void)setupSubViews {
    
    self.scrollView = [[UIScrollView alloc]init];
    [self.view addSubview:self.scrollView];
    self.scrollView.backgroundColor = kBackgroundColor;
    
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
    MSLiveWorkFillinTagsSection *section3 = [[MSLiveWorkFillinTagsSection alloc]initWithTitle:@"工作班成员" placeholder:nil showDeleteBtn:NO];
    section3.addBtn.hidden = YES;
    
    MSOutInMultiLineSection *section4 = [[MSOutInMultiLineSection alloc]initWithTitle:@"工作内容"];
    
    MSOutInMultiLineSection *section5 = [[MSOutInMultiLineSection alloc]initWithTitle:@"工作记录"];
    
    MSLiveWorkFillinTagsSection *section6 = [[MSLiveWorkFillinTagsSection alloc]initWithTitle:@"参会人员" placeholder:nil showDeleteBtn:NO];
    section6.addBtn.hidden = YES;
    
    MSOutInMultiLineSection *section7 = [[MSOutInMultiLineSection alloc]initWithTitle:@"注意事项"];
    
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
    _workContentInput = section4.subLabel;
    _workRecordInput = section5.subLabel;
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
    [self loadLiveWorkDetailInfo];
}

- (void)fillInWithLiveWork:(MSLiveWorkModel *)model {

    self.dateField.text = model.workTime;
    self.leaderField.text = model.chargePerson;
    NSArray *member = [MSLiveWorkModel personArrayFromPersonString:model.member];
    [self.classMemberSection deleteAllUsers];
    [self.classMemberSection addUsers:member];
    self.workContentInput.text = model.context;
    self.workRecordInput.text = model.workRecord;
    
    NSArray *persons = [MSLiveWorkModel personArrayFromPersonString:model.persons];
    [self.meetingMemberSection deleteAllUsers];
    [self.meetingMemberSection addUsers:persons];
    self.workNoteInput.text = model.attention;
}

- (void)editLiveWork {
    MSLiveWorkFillInViewController *editVC = [[MSLiveWorkFillInViewController alloc]initWithLiveWorkModel:self.detailLiveWork];
    [self.navigationController pushViewController:editVC animated:YES];
}

#pragma mark - HTTP Request
- (void)loadLiveWorkDetailInfo {
    [SVProgressHUD show];
    [MSNetworking getLiveWorkDetailInfo:self.liveWorkId success:^(NSDictionary *object) {
        [SVProgressHUD showSuccessWithStatus:@"查询成功"];
        MSLiveWorkModel *model = [MSLiveWorkModel mj_objectWithKeyValues:object[@"data"]];
        self.navigationItem.rightBarButtonItem.enabled = YES;
        self.detailLiveWork = model;
        [self fillInWithLiveWork:model];
    } failure:^(NSError *error) {
        [SVProgressHUD showErrorWithStatus:@"查询失败"];
    }];
}

@end
