//
//  MSLiveWorkViewController.m
//  MSTreasuryManager
//
//  Created by apple on 16/10/14.
//  Copyright © 2016年 邓利文. All rights reserved.
//

#import "MSLiveWorkViewController.h"
#import "MSHomeCollectionCell.h"
#import "MSLiveWorkFillInViewController.h"

#define kCellWidth ((kSCREEN_WIDTH - 30) / 2.0f)
#define kCellHeight 100

static NSString * const kLiveWorkCell = @"LiveWorkCell";

@interface MSLiveWorkViewController () <UICollectionViewDelegate, UICollectionViewDataSource,UICollectionViewDelegateFlowLayout>

@property (nonatomic, strong) NSArray * titles;
@property (nonatomic, strong) UICollectionView *collectionView;

@end

@implementation MSLiveWorkViewController

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
    [self.collectionView registerClass:[MSHomeCollectionCell class] forCellWithReuseIdentifier:kLiveWorkCell];
    self.collectionView.backgroundColor = [UIColor clearColor];
    self.collectionView.delegate = self;
    self.collectionView.dataSource = self;
    
    self.titles = @[@"现场工作填写",@"现场工作查询"];
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
    MSHomeCollectionCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:kLiveWorkCell forIndexPath:indexPath];
    NSString *title = self.titles[indexPath.row];
    [cell fillWithTitle:title];
    return cell;
}

#pragma mark - UICollectionViewDelegate
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    MSLiveWorkCellIndexType type = indexPath.row;
    UIViewController *vc = nil;
    switch (type) {
        case MSLiveWorkCellIndexTypeFillIn:
        {
            vc = [[MSLiveWorkFillInViewController alloc]init];
        }
            break;
        case MSLiveWorkCellIndexTypeQuery:
        {
            
        }
            break;
        default:
            break;
    }
    vc.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:vc animated:YES];
}


@end
