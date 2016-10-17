//
//  MSMaterialFillInViewController.m
//  MSTreasuryManager
//
//  Created by 邓利文 on 2016/10/8.
//  Copyright © 2016年 邓利文. All rights reserved.
//

#import "MSMaterialFillInViewController.h"
#import "YZInputView.h"
#import "MSMaterialFillInWithSearchSection.h"
#import "MSMaterialFillInNomalSection.h"
#import "MSPhotoPadView.h"
#import "UIImage+Custom.h"
#import "DNAsset.h"
#import "DNImagePickerController.h"
#import "PBViewController.h"
#import <AssetsLibrary/AssetsLibrary.h>
#import <AVFoundation/AVFoundation.h>
#import "MSBaseButton.h"
#import "MSCommonSearchViewController.h"

@interface MSMaterialFillInViewController () <UIImagePickerControllerDelegate,UINavigationControllerDelegate,DNImagePickerControllerDelegate,MSPhotoPadViewDelegate,PBViewControllerDataSource, PBViewControllerDelegate>

@property (nonatomic, strong) UIScrollView *scrollView;
@property (nonatomic, strong) YZInputView *nameInput;   //物资名称
@property (nonatomic, strong) YZInputView *paramsInput; //物资参数

@property (nonatomic, strong) UITextField *erfuField;
@property (nonatomic, strong) UITextField *tuikuField;
@property (nonatomic, strong) UITextField *sysField;

@property (nonatomic, strong) MSPhotoPadView *photoPadView;

@end

@implementation MSMaterialFillInViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    [self setupSubviews];
}

- (void)setupSubviews {
    self.title = @"物资信息填写";
    self.scrollView = [[UIScrollView alloc]init];
    [self.view addSubview:self.scrollView];
    self.scrollView.backgroundColor = kBackgroundColor;

    [self setupSections];
    
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(dismissKeyboardAction)];
    tap.cancelsTouchesInView = NO;//防止tap影响subView响应事件
    [self.view addGestureRecognizer:tap];
}

- (void)setupSections {
    UIView *bgView = ({
        UIView *view = [[UIView alloc]init];
        [self.scrollView addSubview:view];
        
        view;
    });
    
    //物资名称 物资技术参数
    MSMaterialFillInWithSearchSection *section1 = [[MSMaterialFillInWithSearchSection alloc]initWithTitle:@"物资名称" placeholder:@"请输入物资名称"];
    self.nameInput = section1.inputView;
    [bgView addSubview:section1];
    [section1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(0);
        make.top.mas_equalTo(20);
        make.width.mas_equalTo(kSCREEN_WIDTH);
    }];
    [section1.searchBtn addTarget:self action:@selector(searchNameBtnClicked:) forControlEvents:(UIControlEventTouchUpInside)];
    
    MSMaterialFillInWithSearchSection *section2 = [[MSMaterialFillInWithSearchSection alloc]initWithTitle:@"物资技术参数" placeholder:@"请输入物资技术参数"];
    self.paramsInput = section2.inputView;
    [bgView addSubview:section2];
    [section2 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(0);
        make.top.equalTo(section1.mas_bottom).offset(20);
        make.width.mas_equalTo(kSCREEN_WIDTH);
    }];
    [section2.searchBtn addTarget:self action:@selector(searchParamsBtnClicked:) forControlEvents:(UIControlEventTouchUpInside)];
    
    //物资库存
    UIView *section3HeaderView = [self createNomalSectionHeaderViewWithTitle:@"物资库存"];
    [bgView addSubview:section3HeaderView];
    [section3HeaderView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(0);
        make.width.mas_equalTo(kSCREEN_WIDTH);
        make.height.mas_equalTo(44);
        make.top.equalTo(section2.mas_bottom).offset(20);
    }];

    MSMaterialFillInNomalSection *section3 = [[MSMaterialFillInNomalSection alloc]initWithTitle:@"二副库房" placeholder:@"填写数量"];
    MSMaterialFillInNomalSection *section4 = [[MSMaterialFillInNomalSection alloc]initWithTitle:@"退库库房" placeholder:@"填写数量"];
    MSMaterialFillInNomalSection *section5 = [[MSMaterialFillInNomalSection alloc]initWithTitle:@"系统库房" placeholder:@"填写数量"];
    
    self.erfuField = section3.textField;
    self.tuikuField = section4.textField;
    self.sysField = section5.textField;
    
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
    
    UIButton *addBtn = [UIButton buttonWithType:(UIButtonTypeCustom)];
    [addBtn setImage:[UIImage imageNamed:@"add"] forState:(UIControlStateNormal)];
    [addBtn addTarget:self action:@selector(addImages:) forControlEvents:(UIControlEventTouchUpInside)];
    [section4HeaderView addSubview:addBtn];
    [addBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(section4HeaderView.mas_right).offset(-20);
        make.centerY.equalTo(section4HeaderView);
        make.size.mas_equalTo(CGSizeMake(20, 20));
    }];
    
    MSPhotoPadView *photoPadView = [[MSPhotoPadView alloc]init];

    [bgView addSubview:photoPadView];
    [photoPadView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(section4HeaderView.mas_bottom);
        make.width.mas_equalTo(kSCREEN_WIDTH);
        make.left.mas_equalTo(0);
        make.height.mas_equalTo(kImageCellHeight + 20);
    }];
    
    MSBaseButton *submitBtn = ({
        MSBaseButton *btn = [[MSBaseButton alloc]initWithTitle:@"提  交"];
        
        btn;
    });
    [bgView addSubview:submitBtn];
    
    [submitBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(photoPadView.mas_bottom).offset(20);
        make.left.mas_equalTo(20);
        make.width.mas_equalTo(kSCREEN_WIDTH - 40);
        make.height.mas_equalTo(40);
    }];
    
    [bgView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.mas_equalTo(kSCREEN_WIDTH);
        make.bottom.equalTo(submitBtn.mas_bottom).offset(20);
    }];
    
    photoPadView.delegate = self;
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

- (void)addImages:(UIButton *)sender {
    //判断已选图片数量
    if (self.photoPadView.imageArray.count >= 3) {
        UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"提示" message:@"不能超过3张图片" preferredStyle:(UIAlertControllerStyleAlert)];
        UIAlertAction *cancleAction = [UIAlertAction actionWithTitle:@"确定" style:(UIAlertActionStyleCancel) handler:^(UIAlertAction * _Nonnull action) {
            [alert dismissViewControllerAnimated:YES completion:nil];
        }];
        [alert addAction:cancleAction];
        [self presentViewController:alert animated:YES completion:nil];
        return;
    }

    UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"选择照片" message:nil preferredStyle:(UIAlertControllerStyleActionSheet)];
    UIAlertAction *action1 = [UIAlertAction actionWithTitle:@"拍照" style:(UIAlertActionStyleDefault) handler:^(UIAlertAction * _Nonnull action) {
        NSLog(@"拍照");
        [self openCameraImagePickerController];
    }];
    UIAlertAction *action2 = [UIAlertAction actionWithTitle:@"从相册选取" style:(UIAlertActionStyleDefault) handler:^(UIAlertAction * _Nonnull action) {
        NSLog(@"从相册选取");
        [self openCutomImagePickerController];
    }];
    UIAlertAction *action3 = [UIAlertAction actionWithTitle:@"取消" style:(UIAlertActionStyleCancel) handler:^(UIAlertAction * _Nonnull action) {
        NSLog(@"取消");
        
        [alert dismissViewControllerAnimated:YES completion:nil];
    }];
    [alert addAction:action1];
    [alert addAction:action2];
    [alert addAction:action3];
    
    [self presentViewController:alert animated:YES completion:nil];
}

- (void)openCutomImagePickerController {
    DNImagePickerController *imagePicker = [[DNImagePickerController alloc] init];
    imagePicker.maxSelectCount = 3 - self.photoPadView.imageArray.count;
    imagePicker.imagePickerDelegate = self;
    [self presentViewController:imagePicker animated:YES completion:nil];
}

- (void)openCameraImagePickerController
{
    if([[[UIDevice currentDevice] systemVersion] floatValue]>=7.0)
    {
        AVAuthorizationStatus authorizationStatus=[AVCaptureDevice authorizationStatusForMediaType:AVMediaTypeVideo];
        if(authorizationStatus==AVAuthorizationStatusDenied)
        {
            UIAlertController *alert = [UIAlertController alertControllerWithTitle:nil message:@"此应用程序没有权限来访问您的照片或视频。\r\n您可以在“隐私设置”中启用访问" preferredStyle:(UIAlertControllerStyleAlert)];
            [self presentViewController:alert animated:YES completion:nil];
            return;
        }
    }
    
    UIImagePickerController * picker = [[UIImagePickerController alloc] init];
    if([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera])
    {
        picker.sourceType = UIImagePickerControllerSourceTypeCamera;
    }
    [picker.navigationBar setBackgroundColor:[UIColor darkGrayColor]];
    picker.delegate = self;
    [self presentViewController:picker animated:YES completion:nil];
    
}

#pragma mark - UIImagePickerControllerDelegate
- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info
{
    UIImage* image=[UIImage originalImageFromImagePickerMediaInfo:info resultBlock:^(UIImage *image){
    }];
    [self.photoPadView addImage:image];
     [picker dismissViewControllerAnimated:YES completion:nil];
}

- (void)imagePickerControllerDidCancel:(UIImagePickerController *)picker
{
    [picker dismissViewControllerAnimated:YES completion:nil];
}

#pragma mark - DNImagePickerControllerDelegate
- (void)dnImagePickerController:(DNImagePickerController *)imagePickerController sendImages:(NSArray *)imageAssets isFullImage:(BOOL)fullImage
{

    ALAssetsLibrary *lib = [[ALAssetsLibrary alloc]init];
    __weak typeof(self) weakSelf = self;
    for (DNAsset *dnasset in imageAssets) {
        [lib assetForURL:dnasset.url resultBlock:^(ALAsset *asset){
            __strong typeof(weakSelf) strongSelf = weakSelf;
            if (asset) {
                UIImage *image = nil;
                if (fullImage) {
                    image = [UIImage imageWithCGImage:asset.defaultRepresentation.fullScreenImage];
                }else {
//                    image = [UIImage imageWithCGImage:asset.thumbnail];
                    image = [UIImage imageWithCGImage:asset.defaultRepresentation.fullScreenImage];
                }
                [strongSelf.photoPadView addImage:image];
            } else {
                // On iOS 8.1 [library assetForUrl] Photo Streams always returns nil. Try to obtain it in an alternative way
                [lib enumerateGroupsWithTypes:ALAssetsGroupPhotoStream
                                   usingBlock:^(ALAssetsGroup *group, BOOL *stop)
                 {
                     [group enumerateAssetsWithOptions:NSEnumerationReverse
                                            usingBlock:^(ALAsset *result, NSUInteger index, BOOL *stop) {
                                                
                                                if([[result valueForProperty:ALAssetPropertyAssetURL] isEqual:dnasset.url])
                                                {
                                                    UIImage *image = nil;
                                                    if (fullImage) {
                                                        image = [UIImage imageWithCGImage:result.defaultRepresentation.fullScreenImage];
                                                    }else {
                                                        image = [UIImage imageWithCGImage:result.thumbnail];
                                                    }
                                                    [strongSelf.photoPadView addImage:image];
                                                    *stop = YES;
                                                }
                                            }];
                 }
                                 failureBlock:^(NSError *error)
                 {
//                     [strongSelf setCell:blockCell asset:nil];
                 }];
            }
            
        } failureBlock:^(NSError *error){
//            __strong typeof(weakSelf) strongSelf = weakSelf;
//            [strongSelf setCell:blockCell asset:nil];
        }];

    }
}

- (void)dnImagePickerControllerDidCancel:(DNImagePickerController *)imagePicker
{
    [imagePicker dismissViewControllerAnimated:YES completion:^{
        
    }];
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
    return self.photoPadView.imageArray.count;
}

- (UIImage *)viewController:(PBViewController *)viewController imageForPageAtIndex:(NSInteger)index {
    return self.photoPadView.imageArray[index];
}

- (UIView *)thumbViewForPageAtIndex:(NSInteger)index {
    return nil;//[self.photoPadView cellViewAtIndex:index];
}

#pragma mark - PBViewControllerDelegate
- (void)viewController:(PBViewController *)viewController didSingleTapedPageAtIndex:(NSInteger)index presentedImage:(UIImage *)presentedImage {
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (void)viewController:(PBViewController *)viewController didLongPressedPageAtIndex:(NSInteger)index presentedImage:(UIImage *)presentedImage {
    NSLog(@"didLongPressedPageAtIndex: %@", @(index));
}

#pragma mark - SearchBtnAction
- (void)searchNameBtnClicked:(UIButton*)sender {
    NSLog(@"搜索物资名称");
    MSCommonSearchViewController *s = [[MSCommonSearchViewController alloc]initWithSearchType:(MSSearchTypeMaterialName)];
    [self.navigationController pushViewController:s animated:YES];
//    [self presentViewController:s animated:YES completion:nil];
}

- (void)searchParamsBtnClicked:(UIButton*)sender {
    NSLog(@"搜索物资参数");
    MSCommonSearchViewController *s = [[MSCommonSearchViewController alloc]initWithSearchType:(MSSearchTypeMaterialParams)];
    [self.navigationController pushViewController:s animated:YES];
}

- (void)dismissKeyboardAction {
    [self.view endEditing:YES];
}

@end
