//
//  MSNewHomeViewController.m
//  MSTreasuryManager
//
//  Created by apple on 17/1/4.
//  Copyright © 2017年 邓利文. All rights reserved.
//

#import "MSNewHomeViewController.h"
#import "MSHomeBannaerCell.h"
#import "MSHomeClassBannerCell.h"
#import "MSHomePersonCell.h"
#import "KINWebBrowserViewController.h"

static NSString *const kHomeBannerCell = @"HomeBannerCell";
static NSString *const kClassesBanner = @"ClassesBannerCell";
static NSString *const kPersonCell = @"PersonCell";

@interface MSNewHomeViewController () <MSHomeBannaerCellDelegate,MSHomeClassBannerCellDelegate,MSHTTPRequestDelegate>

@property (nonatomic, strong) NSArray *banners;
@property (nonatomic, strong) NSArray *classes; //班组
@property (nonatomic, strong) NSArray *persons; //人员

@end

@implementation MSNewHomeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.banners = [NSArray array];
    self.classes = [NSArray array];
    self.persons = [NSArray array];
    
    MSHomeBannerModel *banner = [[MSHomeBannerModel alloc]init];
    MSHomeBannerModel *banner1 = [[MSHomeBannerModel alloc]init];
    MSHomeBannerModel *banner2 = [[MSHomeBannerModel alloc]init];
    
    MSClassModel *classbanner = [[MSClassModel alloc]init];
    MSClassModel *classbanner1 = [[MSClassModel alloc]init];
    MSClassModel *classbanner2 = [[MSClassModel alloc]init];
    
    MSPersonModel *person = [[MSPersonModel alloc]init];
    MSPersonModel *person1 = [[MSPersonModel alloc]init];
    MSPersonModel *person2 = [[MSPersonModel alloc]init];
    
    self.banners = @[banner,banner1,banner2];
    self.classes = @[classbanner,classbanner1,classbanner2];
    self.persons = @[person,person1,person2,@"",@"",@"",@"",@""];
    
    self.flowLayout.minimumLineSpacing = 10;
    self.flowLayout.minimumInteritemSpacing = 0;
    // Register cell classes
    [self.collectionView registerClass:[MSHomeBannaerCell class] forCellWithReuseIdentifier:kHomeBannerCell];
    [self.collectionView registerClass:[MSHomeClassBannerCell class] forCellWithReuseIdentifier:kClassesBanner];
    [self.collectionView registerClass:[MSHomePersonCell class] forCellWithReuseIdentifier:kPersonCell];
}

- (void)refresh {

}

#pragma mark <UICollectionViewDataSource>

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    return 3;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    switch (section) {
        case 0:
        case 1:
            return 1;
        case 2:
            return self.persons.count;
    }
    return 0;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    UICollectionViewCell *cell = nil;
    switch (indexPath.section) {
        case 0:
        {
            cell = [collectionView dequeueReusableCellWithReuseIdentifier:kHomeBannerCell forIndexPath:indexPath];
            MSHomeBannaerCell *bannerCell = (MSHomeBannaerCell *)cell;
            [bannerCell fillWithBannerModels:self.banners];
            bannerCell.delegate = self;
        }
            break;
        case 1:
        {
            cell = [collectionView dequeueReusableCellWithReuseIdentifier:kClassesBanner forIndexPath:indexPath];
            MSHomeClassBannerCell *bannerCell = (MSHomeClassBannerCell *)cell;
            [bannerCell fillWithBannerModels:self.classes];
            bannerCell.delegate = self;
        }
            break;
        default:
        {
            cell = [collectionView dequeueReusableCellWithReuseIdentifier:kPersonCell forIndexPath:indexPath];
            MSHomePersonCell *bannerCell = (MSHomePersonCell *)cell;
        }
            break;
    }
    return cell;

}

#pragma mark - UICollectionViewDelegateFlowLayout
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath {
    switch (indexPath.section) {
        case 0:
            return CGSizeMake(kSCREEN_WIDTH, kMSHomeBannerHeight);
            break;
        case 1:
            return CGSizeMake(kSCREEN_WIDTH, kMSClassBannerHeight);
        case 2:
            return CGSizeMake(kMSPersonCellWidth, kMSPersonCellHeight);
        default:
            break;
    }
    return CGSizeZero;
}

#pragma mark <UICollectionViewDelegate>

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {

}

#pragma mark - MSHomeBannaerCellDelegate

- (void)banner:(MSHomeBannaerCell*)banner clickedAtIndex:(NSInteger)index bannerModel:(MSHomeBannerModel *)bannerModel {

}
#pragma mark - MSHomeClassBannerCellDelegate

- (void)classBanner:(MSHomeClassBannerCell*)banner clickedAtIndex:(NSInteger)index classBannerModel:(MSClassModel *)classBannerModel {
    KINWebBrowserViewController *webVC = [[KINWebBrowserViewController alloc]init];
    [webVC loadURLString:@"http://www.baidu.com"];
    webVC.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:webVC animated:YES];
}

@end
