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
#import "MSSearchMaterialViewController.h"
#import "MSNetworking+Material.h"
#import "PBViewController.h"
#import "MSMaterialRightHandleSection.h"
#import "MSMaterialOutStoreViewController.h"

//1-二副库房，2-退库库房，3-系统库房
typedef enum : NSUInteger {
    MSStoreTypeErku = 1,
    MSStoreTypeTuiku = 2,
    MSStoreTypeSys = 3,
} MSStoreType;

//#import "MSQRCodeReaderViewController.h"

//@interface MSMaterialInfoFetchViewController () <MSLoadQRScannButtonProtocol,QRCodeReaderDelegate,MSQRCodeReaderViewControllerDelegate>
@interface MSMaterialInfoFetchViewController () <MSCommonSearchViewControllerDelegate,MSPhotoPadViewDelegate,PBViewControllerDataSource, PBViewControllerDelegate>

@property (nonatomic, strong) UIScrollView *scrollView;
@property (nonatomic, strong) YZInputView *nameInput;   //物资名称
@property (nonatomic, strong) YZInputView *paramsInput; //物资参数

@property (nonatomic, strong) UITextField *erfuField;
@property (nonatomic, strong) UITextField *tuikuField;
@property (nonatomic, strong) UITextField *sysField;

@property (nonatomic, strong) MSPhotoPadView *photoPadView;

@property (nonatomic, strong) MSMaterialModel *fetchMaterial;

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
    
//    MSMaterialFillInWithSearchSection *section2 = [[MSMaterialFillInWithSearchSection alloc]initWithTitle:@"物资技术参数" placeholder:@"通过物资技术参数搜索"];
    MSMaterialFillInWithSearchSection *section2 = [[MSMaterialFillInWithSearchSection alloc]initWithTitle:@"物资技术参数" placeholder:@"请输入物资技术参数" hideSearchButton:YES];
    self.paramsInput = section2.inputView;
    self.paramsInput.editable = NO;
    [bgView addSubview:section2];
    [section2 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(0);
        make.top.equalTo(section1.mas_bottom).offset(20);
        make.width.mas_equalTo(kSCREEN_WIDTH);
    }];
//    [section2.searchBtn addTarget:self action:@selector(searchParamsBtnClicked:) forControlEvents:(UIControlEventTouchUpInside)];
    
    //为物资名称和技术参数输入框添加点击事件
    UITapGestureRecognizer *tapName = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(searchNameBtnClicked:)];
    [self.nameInput addGestureRecognizer:tapName];
    
//    UITapGestureRecognizer *tapParams = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(searchParamsBtnClicked:)];
//    [self.paramsInput addGestureRecognizer:tapParams];
    
    
    //物资库存
    UIView *section3HeaderView = [self createNomalSectionHeaderViewWithTitle:@"物资库存"];
    [bgView addSubview:section3HeaderView];
    [section3HeaderView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(0);
        make.width.mas_equalTo(kSCREEN_WIDTH);
        make.height.mas_equalTo(44);
        make.top.equalTo(section2.mas_bottom).offset(20);
    }];
    
    MSMaterialRightHandleSection *section3 = [[MSMaterialRightHandleSection alloc]initWithTitle:@"二副库房" placeholder:@""];
    MSMaterialRightHandleSection *section4 = [[MSMaterialRightHandleSection alloc]initWithTitle:@"退库库房" placeholder:@""];
    MSMaterialRightHandleSection *section5 = [[MSMaterialRightHandleSection alloc]initWithTitle:@"系统库房" placeholder:@""];
    
    section3.actionBtn.tag = MSStoreTypeErku;
    section4.actionBtn.tag = MSStoreTypeTuiku;
    section5.actionBtn.tag = MSStoreTypeSys;
    
    [section3.actionBtn addTarget:self action:@selector(outMaterialButtonClicked:) forControlEvents:(UIControlEventTouchUpInside)];
    [section4.actionBtn addTarget:self action:@selector(outMaterialButtonClicked:) forControlEvents:(UIControlEventTouchUpInside)];
    [section5.actionBtn addTarget:self action:@selector(outMaterialButtonClicked:) forControlEvents:(UIControlEventTouchUpInside)];
    
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
    
    MSPhotoPadView *photoPadView = [[MSPhotoPadView alloc]init];
    photoPadView.delegate = self;
    
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

#pragma mark - Out Action
- (void)outMaterialButtonClicked:(UIButton *)sender {
    MSStoreType type = sender.tag;
    
    if (!self.nameInput.text.length) {
        [SVProgressHUD showInfoWithStatus:@"请先选择物资"];
        return;
    }
    
    NSInteger count = -1;
    switch (type) {
        case MSStoreTypeErku:
        {
            count = [self.erfuField.text integerValue];
        }
            break;
        case MSStoreTypeTuiku:
        {
            count = [self.tuikuField.text integerValue];
        }
            break;
        case MSStoreTypeSys:
        {
            count = [self.sysField.text integerValue];
        }
            break;
        default:
            break;
    }
    
    if (count < 1) {
        [SVProgressHUD showInfoWithStatus:@"数量不足无法出库!"];
        return;
    }
    
    MSMaterialOutInModel *outModel = [[MSMaterialOutInModel alloc]init];
    outModel.materialId = self.fetchMaterial.mid;
    outModel.materialName = self.fetchMaterial.name;
    outModel.location = type;
    
    MSMaterialOutStoreViewController *outVC = [[MSMaterialOutStoreViewController alloc]initWithType:(MSCellIndexOfTypeMaterialOut) outMaterialModel:outModel];
    [self.navigationController pushViewController:outVC animated:YES];
}

#pragma mark - searchAction
- (void)searchNameBtnClicked:(UIButton*)sender{
    MSSearchMaterialViewController *s = [[MSSearchMaterialViewController alloc]initWithSearchType:(MSSearchTypeMaterialName)];
    s.delegate = self;
    [self.navigationController pushViewController:s animated:YES];
}

- (void)searchParamsBtnClicked:(UIButton*)sender {
    MSSearchMaterialViewController *s = [[MSSearchMaterialViewController alloc]initWithSearchType:(MSSearchTypeMaterialParams)];
    s.delegate = self;
    [self.navigationController pushViewController:s animated:YES];
}

#pragma mark - MSCommonSearchViewControllerDelegate
- (void)searchViewController:(MSSearchType)searchType didSelectModel:(id)resultModel {
    MSMaterialModel *searchModel = (MSMaterialModel *)resultModel;
    self.nameInput.text = searchModel.name;
    self.paramsInput.text = searchModel.techParam;
    
    [self getMaterialInfoWithMaterialId:searchModel.mid];
    
}

#pragma mark - HTTP Request
- (void)getMaterialInfoWithMaterialId:(NSInteger)materialId {
    [SVProgressHUD show];
    [MSNetworking getMaterialDetailInfo:materialId success:^(NSDictionary *object) {
        MSMaterialModel *model = [MSMaterialModel mj_objectWithKeyValues:object[@"data"]];
        [SVProgressHUD showSuccessWithStatus:@"查询成功"];
        self.fetchMaterial = model;
        [self fillPagesWithMaterialModel:model];
    } failure:^(NSError *error) {
        [SVProgressHUD showErrorWithStatus:@"查询失败"];
    }];
}

- (void)fillPagesWithMaterialModel:(MSMaterialModel *)model {
    self.erfuField.text = [NSString stringWithFormat:@"%ld",(long)model.room1rest];
    self.tuikuField.text = [NSString stringWithFormat:@"%ld",(long)model.room2rest];
    self.sysField.text = [NSString stringWithFormat:@"%ld",(long)model.systemrest];
    [self.photoPadView addImageUrls:model.pictures];
}

#pragma mark - MSPhotoPadViewDelegate
- (void)photoPadView:(MSPhotoPadView *)photoPadView clickedAtIndex:(NSInteger)currentIndex inImages:(NSArray *)images {
    PBViewController *pbViewController = [PBViewController new];
    pbViewController.pb_dataSource = self;
    pbViewController.pb_delegate = self;
    pbViewController.pb_startPage = currentIndex;
    [self presentViewController:pbViewController animated:YES completion:nil];
}

#pragma mark - PBViewControllerDataSource
- (NSInteger)numberOfPagesInViewController:(PBViewController *)viewController {
    return self.photoPadView.urlArray.count;
}

#pragma mark - PBViewControllerDelegate
- (void)viewController:(PBViewController *)viewController presentImageView:(UIImageView *)imageView forPageAtIndex:(NSInteger)index progressHandler:(void (^)(NSInteger, NSInteger))progressHandler {
    NSString *url =  self.photoPadView.urlArray[index];
    [imageView sd_setImageWithURL:[NSURL URLWithString:url]
                 placeholderImage:nil
                          options:0
                         progress:progressHandler
                        completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
                        }];
}

- (UIView *)thumbViewForPageAtIndex:(NSInteger)index {
    return nil;
}

#pragma mark - PBViewControllerDelegate

- (void)viewController:(PBViewController *)viewController didSingleTapedPageAtIndex:(NSInteger)index presentedImage:(UIImage *)presentedImage {
    [self dismissViewControllerAnimated:YES completion:nil];
}


//- (void)qrscannerBtnClick {
////    if ([QRCodeReader supportsMetadataObjectTypes:@[AVMetadataObjectTypeQRCode]]) {
////        static QRCodeReaderViewController *reader = nil;
////        static dispatch_once_t onceToken;
////        
////        dispatch_once(&onceToken, ^{
////            reader = [QRCodeReaderViewController new];
////        });
//    MSQRCodeReaderViewController *reader = [[MSQRCodeReaderViewController alloc]init];
//        reader.delegate = self;
//        
//        [reader setCompletionWithBlock:^(NSString *resultAsString) {
//            NSLog(@"Completion with result: %@", resultAsString);
//        }];
//        
////        [self presentViewController:reader animated:YES completion:NULL];
//    [self.navigationController pushViewController:reader animated:YES];
////    }
////    else {
////        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Error" message:@"Reader not supported by the current device" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
////        
////        [alert show];
////    }
//
//}


@end
