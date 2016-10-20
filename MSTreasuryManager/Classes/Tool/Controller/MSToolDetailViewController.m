//
//  MSToolDetailViewController.m
//  MSTreasuryManager
//
//  Created by 邓利文 on 2016/10/20.
//  Copyright © 2016年 邓利文. All rights reserved.
//

#import "MSToolDetailViewController.h"
#import "MSOutInMultiLineSection.h"
#import "MSOutInOneLineSection.h"

@interface MSToolDetailViewController ()

@property (nonatomic, assign) MSToolType type;

@property (nonatomic, strong) UIScrollView *scrollView;
//借用状态
@property (nonatomic, strong) UILabel *toolNameLabel;
@property (nonatomic, strong) UILabel *reasonLabel;
@property (nonatomic, strong) UILabel *borrowTimeLabel;
@property (nonatomic, strong) UILabel *borrowUserNameLabel;
@property (nonatomic, strong) UILabel *borrowUserPhoneLabel;
@property (nonatomic, strong) UILabel *reviewUserLabel;

@end

@implementation MSToolDetailViewController

- (instancetype)initWithType:(MSToolType)type {
    if (self = [super init]) {
        _type = type;
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.title = @"工器具信息查询";
    if (self.type == MSToolTypeOut) {
        [self setupSubViewsWithBorrowOut];
    }else {
        [self setupSubViewsWithInStore];
    }
    
}

//借出
- (void)setupSubViewsWithBorrowOut {
    UIView *bgView = ({
        UIView *view = [[UIView alloc]init];
        [self.scrollView addSubview:view];
        
        view;
    });
    
    MSOutInMultiLineSection *section1 = [[MSOutInMultiLineSection alloc]initWithTitle:@"工器具名称"];
    MSOutInMultiLineSection *section2 = [[MSOutInMultiLineSection alloc]initWithTitle:@"借用事由"];
    
    MSOutInOneLineSection *section3 = [[MSOutInOneLineSection alloc]initWithTitle:@"借用时间"];
    MSOutInOneLineSection *section4 = [[MSOutInOneLineSection alloc]initWithTitle:@"借用人"];
    MSOutInOneLineSection *section5 = [[MSOutInOneLineSection alloc]initWithTitle:@"借用人电话" ];
    MSOutInOneLineSection *section6 = [[MSOutInOneLineSection alloc]initWithTitle:@"审核人"];
    
    [bgView addSubview:section1];
    [bgView addSubview:section2];
    [bgView addSubview:section3];
    [bgView addSubview:section4];
    [bgView addSubview:section5];
    [bgView addSubview:section6];
    
    self.toolNameLabel = section1.subLabel;
    self.reasonLabel = section2.subLabel;
    self.borrowTimeLabel = section3.subLabel;
    self.borrowUserNameLabel = section4.subLabel;
    self.borrowUserPhoneLabel = section5.subLabel;
    self.reviewUserLabel = section6.subLabel;
    
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
    
    [bgView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.mas_equalTo(kSCREEN_WIDTH);
        make.bottom.equalTo(section6).offset(20);
    }];
    
    [self.scrollView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.view);
        make.edges.equalTo(bgView);
    }];
}

//在库
- (void)setupSubViewsWithInStore {
    //1 没有被借过
    //2 显示上次被借出的记录
}

@end
