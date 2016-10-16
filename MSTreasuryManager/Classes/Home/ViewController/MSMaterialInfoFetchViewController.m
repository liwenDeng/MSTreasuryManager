//
//  MSMateriaInfoFetchViewController.m
//  MSTreasuryManager
//
//  Created by apple on 16/10/12.
//  Copyright © 2016年 邓利文. All rights reserved.
//

#import "MSMaterialInfoFetchViewController.h"
#import "MSMaterialFillInWithSearchSection.h"
#import "MSPhotoPadView.h"
#import "MSMaterialFillInNomalSection.h"
#import "MSSearchTableViewController.h"
#import "MSQRCodeReaderViewController.h"

@interface MSMaterialInfoFetchViewController () <MSLoadQRScannButtonProtocol,QRCodeReaderDelegate,MSQRCodeReaderViewControllerDelegate>

@property (nonatomic, strong) UIScrollView *scrollView;
@property (nonatomic, strong) YZInputView *nameInput;   //物资名称
@property (nonatomic, strong) YZInputView *paramsInput; //物资参数

@property (nonatomic, strong) UITextField *erfuField;
@property (nonatomic, strong) UITextField *tuikuField;
@property (nonatomic, strong) UITextField *sysField;

@property (nonatomic, strong) MSPhotoPadView *photoPadView;

@end

@implementation MSMaterialInfoFetchViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setupSubViews];
}

- (void)setupSubViews {
    
    self.title = @"物资信息查询";
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
    MSMaterialFillInWithSearchSection *section1 = [[MSMaterialFillInWithSearchSection alloc]initWithTitle:@"物资名称" placeholder:@"通过物资名称搜索"];
    self.nameInput = section1.inputView;
    self.nameInput.editable = NO;
    [bgView addSubview:section1];
    [section1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(0);
        make.top.mas_equalTo(20);
        make.width.mas_equalTo(kSCREEN_WIDTH);
    }];
    [section1.searchBtn addTarget:self action:@selector(searchNameBtnClicked:) forControlEvents:(UIControlEventTouchUpInside)];
    
    MSMaterialFillInWithSearchSection *section2 = [[MSMaterialFillInWithSearchSection alloc]initWithTitle:@"物资技术参数" placeholder:@"通过物资技术参数搜索"];
    self.paramsInput = section2.inputView;
    self.nameInput.editable = NO;
    [bgView addSubview:section2];
    [section2 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(0);
        make.top.equalTo(section1.mas_bottom).offset(20);
        make.width.mas_equalTo(kSCREEN_WIDTH);
    }];
    [section2.searchBtn addTarget:self action:@selector(searchParamsBtnClicked:) forControlEvents:(UIControlEventTouchUpInside)];
    
    //为物资名称和技术参数输入框添加点击事件
    UITapGestureRecognizer *tapName = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(searchNameBtnClicked:)];
    [self.nameInput addGestureRecognizer:tapName];
    
    UITapGestureRecognizer *tapParams = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(searchParamsBtnClicked:)];
    [self.paramsInput addGestureRecognizer:tapParams];
    
    
    //物资库存
    UIView *section3HeaderView = [self createNomalSectionHeaderViewWithTitle:@"物资库存"];
    [bgView addSubview:section3HeaderView];
    [section3HeaderView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(0);
        make.width.mas_equalTo(kSCREEN_WIDTH);
        make.height.mas_equalTo(44);
        make.top.equalTo(section2.mas_bottom).offset(20);
    }];
    
    MSMaterialFillInNomalSection *section3 = [[MSMaterialFillInNomalSection alloc]initWithTitle:@"二副库房" placeholder:@""];
    MSMaterialFillInNomalSection *section4 = [[MSMaterialFillInNomalSection alloc]initWithTitle:@"退库库房" placeholder:@""];
    MSMaterialFillInNomalSection *section5 = [[MSMaterialFillInNomalSection alloc]initWithTitle:@"系统库房" placeholder:@""];
    
    self.erfuField = section3.textField;
    self.tuikuField = section4.textField;
    self.sysField = section5.textField;
    
    self.erfuField.enabled = NO;
    self.tuikuField.enabled = NO;
    self.sysField.enabled = NO;
    
    [bgView addSubview:section3];
    [bgView addSubview:section4];
    [bgView addSubview:section5];
    
    [section3 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(section3HeaderView.mas_bottom);
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
    
    //物资图片
    UIView *section4HeaderView = [self createNomalSectionHeaderViewWithTitle:@"物资图片"];
    [bgView addSubview:section4HeaderView];
    [section4HeaderView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(section5.mas_bottom).offset(20);
        make.left.mas_equalTo(0);
        make.width.mas_equalTo(kSCREEN_WIDTH);
        make.height.mas_equalTo(44);
    }];
    
//    UIButton *addBtn = [UIButton buttonWithType:(UIButtonTypeSystem)];
//    [addBtn setImage:[UIImage imageNamed:@"add"] forState:(UIControlStateNormal)];
//    [addBtn addTarget:self action:@selector(addImages:) forControlEvents:(UIControlEventTouchUpInside)];
//    [section4HeaderView addSubview:addBtn];
//    [addBtn mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.right.equalTo(section4HeaderView.mas_right).offset(-20);
//        make.centerY.equalTo(section4HeaderView);
//        make.size.mas_equalTo(CGSizeMake(20, 20));
//    }];
    
    MSPhotoPadView *photoPadView = [[MSPhotoPadView alloc]init];
    
    [bgView addSubview:photoPadView];
    [photoPadView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(section4HeaderView.mas_bottom);
        make.width.mas_equalTo(kSCREEN_WIDTH);
        make.left.mas_equalTo(0);
        make.height.mas_equalTo(kImageCellHeight + 20);
    }];
    
    [bgView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.mas_equalTo(kSCREEN_WIDTH);
        make.bottom.equalTo(photoPadView.mas_bottom).offset(20);
    }];
    
    self.photoPadView = photoPadView;
    [self.scrollView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.view);
        make.edges.equalTo(bgView);
    }];

}

- (UIView *)createNomalSectionHeaderViewWithTitle:(NSString *)title {
    UIView *titleBgView = ({
        UIView *view = [[UIView alloc]init];
        //        [self.scrollView addSubview:view];
        view.backgroundColor = [UIColor whiteColor];
        view;
    });
    
    UILabel *titleLabel = ({
        UILabel *label = [[UILabel alloc]init];
        [titleBgView addSubview:label];
        label.text = title;
        label.backgroundColor = [UIColor whiteColor];
        
        label;
    });
    UIView *line = ({
        UIView *view = [[UIView alloc]init];
        [titleBgView addSubview:view];
        view.backgroundColor = kBackgroundColor;
        view;
    });
    
    [titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(15);
        make.right.equalTo(titleBgView);
        make.height.mas_equalTo(44);
        make.top.equalTo(titleBgView);
    }];
    
    [line mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(0);
        make.width.mas_equalTo(kSCREEN_WIDTH);
        make.height.mas_equalTo(1);
        make.bottom.equalTo(titleLabel.mas_bottom);
    }];
    
    return titleBgView;
}

#pragma mark - searchAction
- (void)searchNameBtnClicked:(UIButton*)sender{
    MSSearchTableViewController *s = [[MSSearchTableViewController alloc]init];
    [self.navigationController pushViewController:s animated:YES];
}

- (void)searchParamsBtnClicked:(UIButton*)sender {
    MSSearchTableViewController *s = [[MSSearchTableViewController alloc]init];
    [self.navigationController pushViewController:s animated:YES];
}

- (void)qrscannerBtnClick {
//    if ([QRCodeReader supportsMetadataObjectTypes:@[AVMetadataObjectTypeQRCode]]) {
//        static QRCodeReaderViewController *reader = nil;
//        static dispatch_once_t onceToken;
//        
//        dispatch_once(&onceToken, ^{
//            reader = [QRCodeReaderViewController new];
//        });
    MSQRCodeReaderViewController *reader = [[MSQRCodeReaderViewController alloc]init];
        reader.delegate = self;
        
        [reader setCompletionWithBlock:^(NSString *resultAsString) {
            NSLog(@"Completion with result: %@", resultAsString);
        }];
        
//        [self presentViewController:reader animated:YES completion:NULL];
    [self.navigationController pushViewController:reader animated:YES];
//    }
//    else {
//        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Error" message:@"Reader not supported by the current device" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
//        
//        [alert show];
//    }

}


@end
