//
//  MSBaseViewController.m
//  MyTemplateProject
//
//  Created by dengliwen on 16/8/2.
//  Copyright © 2016年 dengliwen. All rights reserved.
//

#import "MSBaseViewController.h"

@interface MSBaseViewController ()

@end

@implementation MSBaseViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    if ([self conformsToProtocol:@protocol(MSLoadQRScannButtonProtocol)]) {
        if ([self respondsToSelector:@selector(qrscannerBtnClick)]) {
            [self setupScanButton];
        }
    }
}

- (void)setupScanButton {
    UIBarButtonItem *scan = [[UIBarButtonItem alloc]initWithImage:[[UIImage imageNamed:@"scan"]imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal] style:(UIBarButtonItemStylePlain) target:self action:@selector(qrscannerBtnClick)];
    self.navigationItem.rightBarButtonItem = scan;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(UIInterfaceOrientationMask)supportedInterfaceOrientations
{
    //当前支持的旋转类型
    return UIInterfaceOrientationMaskAll;
}

- (BOOL)shouldAutorotate
{
    // 是否支持旋转
    return YES;
}

-(UIInterfaceOrientation)preferredInterfaceOrientationForPresentation
{
    // 默认进去类型
    return   UIInterfaceOrientationPortrait;
}

@end
