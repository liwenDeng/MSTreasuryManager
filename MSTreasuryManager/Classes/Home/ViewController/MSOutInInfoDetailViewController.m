//
//  MSOutInInfoDetailViewController.m
//  MSTreasuryManager
//
//  Created by 邓利文 on 2016/10/14.
//  Copyright © 2016年 邓利文. All rights reserved.
//

#import "MSOutInInfoDetailViewController.h"
#import "YZInputView.h"
#import "MSOutInMultiLineSection.h"
#import "MSOutInOneLineSection.h"

@interface MSOutInInfoDetailViewController ()

@property (nonatomic, strong) UIScrollView *scrollView;
@property (nonatomic, strong) UILabel *nameInput;
@property (nonatomic, strong) UILabel *placeInput;

@property (nonatomic, strong) UILabel *outCountInput;
@property (nonatomic, strong) UILabel *dateInput;
@property (nonatomic, strong) UILabel *handleUserInput; //经办人
@property (nonatomic, strong) UILabel *reviewUserInput;   //审核人

@property (nonatomic, assign) MSCellIndexOfType type;

@end

@implementation MSOutInInfoDetailViewController

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
    
    [self setupSections];
}

- (void)setupSections {
    UIView *bgView = ({
        UIView *view = [[UIView alloc]init];
        [self.scrollView addSubview:view];
        
        view;
    });
    
    //物资名称 物资技术参数
    MSOutInMultiLineSection *section1 = [[MSOutInMultiLineSection alloc]initWithTitle:@"物资名称"];
    self.nameInput = section1.subLabel;

    [bgView addSubview:section1];
    [section1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(0);
        make.top.mas_equalTo(20);
        make.width.mas_equalTo(kSCREEN_WIDTH);
    }];
    
    NSString *title = self.type == MSCellIndexOfTypeMaterialOut ? @"出库位置" : @"入库位置";
    NSString *title1 = self.type == MSCellIndexOfTypeMaterialOut ? @"出库数量" : @"入库数量";
    NSString *title2 = self.type == MSCellIndexOfTypeMaterialOut ? @"出库日期" : @"入库日期";
    
    MSOutInMultiLineSection *section2 = [[MSOutInMultiLineSection alloc]initWithTitle:title];
    self.placeInput = section2.subLabel;
    [bgView addSubview:section2];
    [section2 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(0);
        make.top.equalTo(section1.mas_bottom).offset(20);
        make.width.mas_equalTo(kSCREEN_WIDTH);
    }];

    MSOutInOneLineSection *section3 = [[MSOutInOneLineSection alloc]initWithTitle:title1];
    MSOutInOneLineSection *section4 = [[MSOutInOneLineSection alloc]initWithTitle:title2];
    MSOutInOneLineSection *section5 = [[MSOutInOneLineSection alloc]initWithTitle:@"经办人" ];
    MSOutInOneLineSection *section6 = [[MSOutInOneLineSection alloc]initWithTitle:@"审核人"];
    
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
    
    self.outCountInput = section3.subLabel;
    self.dateInput = section4.subLabel;
    self.handleUserInput = section5.subLabel;
    self.reviewUserInput = section6.subLabel;
    
    [bgView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.mas_equalTo(kSCREEN_WIDTH);
        make.bottom.equalTo(section6.mas_bottom).offset(20);
    }];
    
    [self.scrollView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.view);
        make.edges.equalTo(bgView);
    }];
    [self fillModels];
}

- (void)fillModels {
    self.nameInput.text = @"XXXXX-XXXXX-XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX";
    self.placeInput.text = @"XXXXX-XXXXX-XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX";
    self.outCountInput.text = @"5";
    self.dateInput.text = @"2016-10-02";
    self.handleUserInput.text = @"王能进";
    self.reviewUserInput.text = @"王能进";
}

@end
