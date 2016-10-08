//
//  MSHomeViewController.m
//  MSTreasuryManager
//
//  Created by 邓利文 on 2016/10/3.
//  Copyright © 2016年 邓利文. All rights reserved.
//

#import "MSHomeViewController.h"
#import "MSHomeCollectionCell.h"
#import "MSMaterialFillInViewController.h"

#define kCellWidth ((kSCREEN_WIDTH - 30) / 2.0f)
#define kCellHeight 100

static NSString * const kHomeCellId = @"kHomeCell";

typedef enum : NSUInteger {
    MSCellIndexOfTypeMaterialFillIn = 0, //物资信息填写
    MSCellIndexOfTypeMaterialQuery,      //物资信息查询
    MSCellIndexOfTypeMaterialOut,        //物资出库
    MSCellIndexOfTypeMateriaIn,          //物资入库
    MSCellIndexOfTypeOutInfosQuery,      //出库记录查询
    MSCellIndexOfTypeInInfosQuery,       //入库记录查询
} MSCellIndexOfType;

@interface MSHomeViewController () <UICollectionViewDelegate, UICollectionViewDataSource,UICollectionViewDelegateFlowLayout>

@property (nonatomic, strong) NSArray * titles;
@property (nonatomic, strong) UICollectionView *collectionView;

@end

@implementation MSHomeViewController

#pragma mark - LifeCircle
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
    [self.collectionView registerClass:[MSHomeCollectionCell class] forCellWithReuseIdentifier:kHomeCellId];
    self.collectionView.backgroundColor = [UIColor clearColor];
    self.collectionView.delegate = self;
    self.collectionView.dataSource = self;
    
    self.titles = @[@"物资信息填写",@"物资信息查询",@"物资出库",@"物资入库",@"出库记录查询",@"入库记录查询"];
}

#pragma mark - UICollectionViewDataSource
- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    return 1;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return self.titles.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    MSHomeCollectionCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:kHomeCellId forIndexPath:indexPath];
    NSString *title = self.titles[indexPath.row];
    [cell fillWithTitle:title];
    return cell;
}

#pragma mark - UICollectionViewDelegate
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    MSCellIndexOfType type = indexPath.row;
    switch (type) {
        case MSCellIndexOfTypeMaterialFillIn:
        {
            MSMaterialFillInViewController *vc = [[MSMaterialFillInViewController alloc]init];
            vc.hidesBottomBarWhenPushed = YES;
            [self.navigationController pushViewController:vc animated:YES];
        }
            break;
        case MSCellIndexOfTypeMaterialQuery:
        {
        
        }
            break;
        case MSCellIndexOfTypeMaterialOut:
        {
        
        }
            break;
        case  MSCellIndexOfTypeMateriaIn:
        {
        
        }
            break;
        case MSCellIndexOfTypeOutInfosQuery:
        {
        
        }
            break;
        case MSCellIndexOfTypeInInfosQuery:
        {
        
        }
            break;
        
        default:
            break;
    }
}

@end
