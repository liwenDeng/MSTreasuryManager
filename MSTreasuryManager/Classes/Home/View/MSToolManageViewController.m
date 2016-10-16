//
//  MSToolManageViewController.m
//  MSTreasuryManager
//
//  Created by 邓利文 on 2016/10/14.
//  Copyright © 2016年 邓利文. All rights reserved.
//

#import "MSToolManageViewController.h"
#import "MSHomeCollectionCell.h"

#import "MSToolInfoFillInViewController.h"
#import "MSToolStateInfoQueryViewController.h"
#import "MSToolBorrowViewController.h"
#import "MSToolLoanViewController.h"

#define kCellWidth ((kSCREEN_WIDTH - 30) / 2.0f)
#define kCellHeight 100

static NSString * const kToolCellId = @"kToolCell";

@interface MSToolManageViewController () <UICollectionViewDelegate, UICollectionViewDataSource,UICollectionViewDelegateFlowLayout>

@property (nonatomic, strong) NSArray * titles;
@property (nonatomic, strong) UICollectionView *collectionView;

@end

@implementation MSToolManageViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor whiteColor];
    UICollectionViewFlowLayout *flowLayout = [[UICollectionViewFlowLayout alloc]init];
    flowLayout.minimumLineSpacing = 10.0f;
    flowLayout.minimumInteritemSpacing = 10.0f;
    flowLayout.sectionInset = UIEdgeInsetsMake(20, 10, 0, 10);
    flowLayout.itemSize = CGSizeMake(kCellWidth, kCellHeight);
    
    self.collectionView = [[UICollectionView alloc]initWithFrame:self.view.frame collectionViewLayout:flowLayout];
    [self.view addSubview:self.collectionView];
    [self.collectionView registerClass:[MSHomeCollectionCell class] forCellWithReuseIdentifier:kToolCellId];
    self.collectionView.backgroundColor = [UIColor clearColor];
    self.collectionView.delegate = self;
    self.collectionView.dataSource = self;
    
    self.titles = @[@"工器具信息填写",@"工器具状态查询",@"工器具借用",@"工器具归还"];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - UICollectionViewDataSource
- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    return 1;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return self.titles.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    MSHomeCollectionCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:kToolCellId forIndexPath:indexPath];
    NSString *title = self.titles[indexPath.row];
    [cell fillWithTitle:title];
    return cell;
}

#pragma mark - UICollectionViewDelegate
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    MSToolCellIndexOfType type = indexPath.row;
    UIViewController *vc = nil;
    switch (type) {
        case MSToolCellIndexOfTypeFillIn:
        {
           vc = [[MSToolInfoFillInViewController alloc]init];
        }
            break;
        case MSToolCellIndexOfTypeStateQuery:
        {
            vc = [[MSToolStateInfoQueryViewController alloc]init];
        }
            break;
        case MSToolCellIndexOfTypeBorrow:
        {
            vc = [[MSToolBorrowViewController alloc]init];
        }
            break;
        case MSToolCellIndexOfTypeLoan:
        {
            vc = [[MSToolLoanViewController alloc]init];
        }
            break;
            
        default:
            break;
    }
    vc.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:vc animated:YES];
}

@end
