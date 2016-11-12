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
#import "MSNetworking+LiveWork.h"
#import "MSLiveWorkFillinTagsSection.h"
#import "MSMultiSearchViewController.h"

@interface MSLiveWorkEditViewController () <MSCommonSearchViewControllerDelegate>

@property (nonatomic, strong) UIScrollView *scrollView;
@property (nonatomic, strong) YZInputView *fillInview;
@property (nonatomic, strong) MSLiveWorkFillinTagsSection *personsSection;

@property (nonatomic, strong) MSLiveWorkModel *updateModel; //更新model

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
    NSString *title = self.editType == MSEditTypeAttention ? @"注意事项-编辑" : @"参会人员-编辑";
    self.title = title;
    [self setupSubViews];
}

- (void)setupSubViews {
    
    self.scrollView = [[UIScrollView alloc]init];
    [self.view addSubview:self.scrollView];
    self.scrollView.backgroundColor = kBackgroundColor;
    
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(dismissKeyboardAction:)];
    [self.view addGestureRecognizer:tap];

    if (self.editType == MSEditTypeAttention) {
        [self setupEditAttentionView];
    }else {
        [self setupEditPersonsView];
    }
    
    [self loadDetailLiveWork];
    
}

- (void)fillPages {
    if (self.editType == MSEditTypeAttention) {
        self.fillInview.text = self.updateModel.attention;
    }else {
        [self.personsSection addUsers:[MSLiveWorkModel personArrayFromPersonString:self.updateModel.persons]];
    }
}

#pragma mark - HTTP Request
- (void)loadDetailLiveWork {
    [SVProgressHUD show];
    [MSNetworking getLiveWorkDetailInfo:self.workId success:^(NSDictionary *object) {
        [SVProgressHUD showSuccessWithStatus:@"查询成功"];
        MSLiveWorkModel *model = [MSLiveWorkModel mj_objectWithKeyValues:object[@"data"]];
        self.updateModel = model;
        [self fillPages];
    } failure:^(NSError *error) {
        [SVProgressHUD showErrorWithStatus:@"查询失败"];
    }];
}

- (void)updateLiveWork {
    [SVProgressHUD show];
    [MSNetworking updateLiveWork:self.updateModel success:^(NSDictionary *object) {
        [SVProgressHUD showSuccessWithStatus:@"修改成功"];
        
        if (self.editType == MSEditTypeAttention && [self.delegate respondsToSelector:@selector(editViewController:editType:resultString:)]) {
            [self.delegate editViewController:self editType:self.editType resultString:self.fillInview.text];
        }
        
        if (self.editType == MSEditTypePersons && [self.delegate respondsToSelector:@selector(editViewController:editType:resultString:)]) {
            NSString *persons = self.updateModel.persons;
            [self.delegate editViewController:self editType:self.editType resultString:persons];
        }
        
    } failure:^(NSError *error) {
        [SVProgressHUD showErrorWithStatus:@"修改失败"];
    }];
}

- (void)setupEditAttentionView {
    UIView *bgView = ({
        UIView *view = [[UIView alloc]init];
        [self.scrollView addSubview:view];
        
        view;
    });
    
    NSString *title =  @"注意事项";

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

- (void)setupEditPersonsView {

    UIView *bgView = ({
        UIView *view = [[UIView alloc]init];
        [self.scrollView addSubview:view];
        
        view;
    });
    
    NSString *title = @"参会人员";
    
    MSLiveWorkFillinTagsSection *section1 = [[MSLiveWorkFillinTagsSection alloc]initWithTitle:title placeholder:nil];
    self.personsSection = section1;
    [bgView addSubview:section1];
    [section1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(20);
        make.left.mas_equalTo(0);
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
    
    [section1.addBtn addTarget:self action:@selector(addPersons) forControlEvents:(UIControlEventTouchUpInside)];
    
    [self.scrollView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.view);
        make.edges.equalTo(bgView);
    }];
}

- (void)viewDidAppear:(BOOL)animated {
    [_fillInview becomeFirstResponder];
}

- (void)dismissKeyboardAction:(UITapGestureRecognizer *)tap {
    [self.view endEditing:YES];
}

- (void)addPersons {
    MSMultiSearchViewController *search = [[MSMultiSearchViewController alloc]initWithSearchType:(MSSearchTypeMettingPerson)];
    search.delegate = self;
    [self.navigationController pushViewController:search animated:YES];
}

- (void)submitBtnClicked {
    if (self.updateModel && self.updateModel.workId) {
        if (self.editType == MSEditTypeAttention) {
            self.updateModel.attention = self.fillInview.text;
        }else {
            self.updateModel.persons = [MSLiveWorkModel personStringFromPersonArray:self.personsSection.users];
        }
        [self updateLiveWork];
    }else {
        [SVProgressHUD showErrorWithStatus:@"更新失败"];
        [self.navigationController popViewControllerAnimated:YES];
    }
}

#pragma mark - MSCommonSearchViewControllerDelegate
- (void)searchViewController:(MSSearchType)searchType didSelectSet:(NSSet *)selectSet {
    if (searchType == MSSearchTypeMettingPerson) {
        for (NSString *personName in selectSet) {
            if (![self.personsSection.tagList.tagArray containsObject:personName]) {
                [self.personsSection addUser:personName];
            }
        }
    }
}

@end
