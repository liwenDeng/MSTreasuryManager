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
#import "MSNetworking+HomeApi.h"
#import "MSPersonCenterViewController.h"

static NSString *const kHomeBannerCell = @"HomeBannerCell";
static NSString *const kClassesBanner = @"ClassesBannerCell";
static NSString *const kPersonCell = @"PersonCell";

typedef enum : NSUInteger {
    MSHomeSectionTypeBanner = 0,
    MSHomeSectionTypeClass,
    MSHomeSectionTypePerson,
    MSHomeSectionTypeUnKnow,
} MSHomeSectionType;

@interface MSNewHomeViewController () <MSHomeBannaerCellDelegate,MSHomeClassBannerCellDelegate,MSHTTPRequestDelegate>

@property (nonatomic, strong) NSArray *banners;
@property (nonatomic, strong) NSArray *classes; //班组
@property (nonatomic, strong) NSArray *persons; //人员
@property (nonatomic, strong) NSMutableArray *sections;

@end

@implementation MSNewHomeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.banners = [NSArray array];
    self.classes = [NSArray array];
    self.persons = [NSArray array];
    self.sections = [NSMutableArray array];
    
    self.collectionView.backgroundColor = kBackgroundColor;
    self.flowLayout.minimumLineSpacing = 0;
    self.flowLayout.minimumInteritemSpacing = 0;
    // Register cell classes
    [self.collectionView registerClass:[MSHomeBannaerCell class] forCellWithReuseIdentifier:kHomeBannerCell];
    [self.collectionView registerClass:[MSHomeClassBannerCell class] forCellWithReuseIdentifier:kClassesBanner];
    [self.collectionView registerClass:[MSHomePersonCell class] forCellWithReuseIdentifier:kPersonCell];
}

#pragma mark - HttpRequest
- (void)refresh {
    dispatch_group_t group = dispatch_group_create();
    [self loadHomeBannerList:group];
    [self loadClassList:group];
    [self loadPersonList:group];
    
    dispatch_group_notify(group, dispatch_get_main_queue(), ^{
        MSLog(@"request Finished");
        [self.collectionView.mj_header endRefreshing];
        [self.sections removeAllObjects];
        if (self.banners.count) {
            [self.sections addObject:self.banners];
        }
        if (self.classes.count) {
            [self.sections addObject:self.classes];
        }
        if (self.persons.count) {
            [self.sections addObject:self.persons];
        }
        [self.collectionView reloadData];
    });
}

- (void)loadHomeBannerList:(dispatch_group_t)group {
    dispatch_group_enter(group);
    [MSNetworking getHomeBannerListSuccess:^(NSDictionary *object) {
        self.banners = [MSHomeBannerModel mj_objectArrayWithKeyValuesArray:object[@"data"]];
        dispatch_group_leave(group);
    } failure:^(NSError *error) {
        dispatch_group_leave(group);
    }];
}

- (void)loadClassList:(dispatch_group_t)group {
    dispatch_group_enter(group);
    [MSNetworking getClassListSuccess:^(NSDictionary *object) {
        self.classes = [MSClassModel mj_objectArrayWithKeyValuesArray:object[@"data"]];
        dispatch_group_leave(group);
    } failure:^(NSError *error) {
        
        dispatch_group_leave(group);
    }];
}

- (void)loadPersonList:(dispatch_group_t)group {
    dispatch_group_enter(group);
    [MSNetworking getPersonListSuccess:^(NSDictionary *object) {
        self.persons = [MSPersonModel mj_objectArrayWithKeyValuesArray:object[@"data"]];
        dispatch_group_leave(group);
    } failure:^(NSError *error) {
        
        dispatch_group_leave(group);
    }];
}

#pragma mark <UICollectionViewDataSource>

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    return self.sections.count;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {

    MSHomeSectionType type = [self sectionTypeAtSection:section];
    switch (type) {
        case MSHomeSectionTypeBanner:
            return 1;
        case MSHomeSectionTypeClass:
            return 1;
        case MSHomeSectionTypePerson:
            return self.persons.count;
        default:
            return 0;
    }
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    UICollectionViewCell *cell = nil;
 
    MSHomeSectionType type = [self sectionTypeAtSection:indexPath.section];
    switch (type) {
        case MSHomeSectionTypeBanner:
        {
            cell = [collectionView dequeueReusableCellWithReuseIdentifier:kHomeBannerCell forIndexPath:indexPath];
            MSHomeBannaerCell *bannerCell = (MSHomeBannaerCell *)cell;
            [bannerCell fillWithBannerModels:self.banners];
            bannerCell.delegate = self;
        }
            break;
        case MSHomeSectionTypeClass:
        {
            cell = [collectionView dequeueReusableCellWithReuseIdentifier:kClassesBanner forIndexPath:indexPath];
            MSHomeClassBannerCell *bannerCell = (MSHomeClassBannerCell *)cell;
            [bannerCell fillWithBannerModels:self.classes];
            bannerCell.delegate = self;
        }
            break;
        case MSHomeSectionTypePerson:
        {
            cell = [collectionView dequeueReusableCellWithReuseIdentifier:kPersonCell forIndexPath:indexPath];
            MSHomePersonCell *bannerCell = (MSHomePersonCell *)cell;
            MSPersonModel *person = self.persons[indexPath.row];
            [bannerCell fillWithPerson:person];
        }
            break;
        default:
            break;
    }

    return cell;
}

#pragma mark - UICollectionViewDelegateFlowLayout

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath {
    MSHomeSectionType type = [self sectionTypeAtSection:indexPath.section];
    switch (type) {
        case MSHomeSectionTypeBanner:
            return CGSizeMake(kSCREEN_WIDTH, kMSHomeBannerHeight);
        case MSHomeSectionTypeClass:
            return CGSizeMake(kSCREEN_WIDTH, kMSClassBannerHeight);
        case MSHomeSectionTypePerson:
            return CGSizeMake(kMSPersonCellWidth, kMSPersonCellHeight);
        default:
            break;
    }
    return CGSizeZero;
}

#pragma mark <UICollectionViewDelegate>

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    MSHomeSectionType type = [self sectionTypeAtSection:indexPath.section];
    if (type == MSHomeSectionTypePerson) {
        MSPersonModel *person = self.persons[indexPath.row];
        MSPersonCenterViewController *personCenter = [[MSPersonCenterViewController alloc]initWithStyle:(UITableViewStyleGrouped)];
        personCenter.hidesBottomBarWhenPushed = YES;
        personCenter.mainPerson = person;
        [self.navigationController pushViewController:personCenter animated:YES];
    }
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

- (MSHomeSectionType)sectionTypeAtSection:(NSInteger)section {
    if (!self.sections.count) {
        return MSHomeSectionTypeUnKnow;
    }
    NSArray *array = self.sections[section];
    if (array == self.banners) {
        return MSHomeSectionTypeBanner;
    }
    if (array == self.classes) {
        return MSHomeSectionTypeClass;
    }
    if (array == self.persons) {
        return MSHomeSectionTypePerson;
    }
    return MSHomeSectionTypeUnKnow;
}

@end
