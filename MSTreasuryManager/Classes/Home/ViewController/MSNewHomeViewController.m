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

static NSString *const kHomeBannerCell = @"HomeBannerCell";
static NSString *const kClassesBanner = @"ClassesBannerCell";
static NSString *const kPersonCell = @"PersonCell";

@interface MSNewHomeViewController ()

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
    self.persons = @[person,person1,person2];
}

#pragma mark - UITableViewDataSource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 3;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    switch (section) {
        case 0:
        case 1:
            return 1;
        case 2:
            return self.persons.count;
    }
    return 0;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = nil;//[tableView dequeueReusableCellWithIdentifier:nil];
    switch (indexPath.section) {
        case 0:
        {
           MSHomeBannaerCell *bannerCell = [tableView dequeueReusableCellWithIdentifier:kHomeBannerCell];
            if (!bannerCell) {
                bannerCell = [[MSHomeBannaerCell alloc]initWithStyle:(UITableViewCellStyleDefault) reuseIdentifier:kHomeBannerCell];
            }
            [bannerCell fillWithBannerModels:self.banners];
            return bannerCell;
        }
            break;
        case 1:
        {
            MSHomeClassBannerCell *bannerCell = [tableView dequeueReusableCellWithIdentifier:kClassesBanner];
            if (!bannerCell) {
                bannerCell = [[MSHomeClassBannerCell alloc]initWithStyle:(UITableViewCellStyleDefault) reuseIdentifier:kClassesBanner];
            }
            [bannerCell fillWithBannerModels:self.classes];
            return bannerCell;
        }
            break;
        default:
        {
            MSHomePersonCell *bannerCell = [tableView dequeueReusableCellWithIdentifier:kPersonCell];
            if (!bannerCell) {
                bannerCell = [[MSHomePersonCell alloc]initWithStyle:(UITableViewCellStyleDefault) reuseIdentifier:kPersonCell];
            }
            return bannerCell;
        }
            break;
    }
    return cell;
}

#pragma mark - UITableViewDelegate
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    switch (indexPath.section) {
        case 0:
            return [MSHomeBannaerCell cellHeight];
        case 1:
            return [MSHomeClassBannerCell cellHeight];
        default:
            return  44;
    }
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return CGFLOAT_MIN;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    return CGFLOAT_MIN;
}


@end
