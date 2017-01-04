//
//  MSMaterialToolViewController.m
//  MSTreasuryManager
//
//  Created by apple on 17/1/4.
//  Copyright © 2017年 邓利文. All rights reserved.
//

#import "MSMaterialToolViewController.h"

#import "MSMaterialFillInViewController.h"
#import "MSMaterialInfoFetchViewController.h"
#import "MSMaterialOutStoreViewController.h"
#import "MSOutInInfosQueryViewController.h"
#import "MSLoginViewController.h"

#import "MSToolInfoFillInViewController.h"
#import "MSToolStateInfoQueryViewController.h"
#import "MSToolBorrowViewController.h"
#import "MSToolLoanViewController.h"
#import "MSToolOutInInfosQueryViewController.h"

static NSString *const kCellId = @"CellId";

@interface MSMaterialToolViewController ()

@property (nonatomic, strong) NSArray *titles;
@property (nonatomic, strong) NSArray *icons;

@end

@implementation MSMaterialToolViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - UITableViewDataSource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return self.titles.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    NSArray *array = self.titles[section];
    return array.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:kCellId];
    if (!cell) {
        cell = [[UITableViewCell alloc]initWithStyle:(UITableViewCellStyleDefault) reuseIdentifier:kCellId];
    }
    [cell setSelectionStyle:(UITableViewCellSelectionStyleNone)];
    [cell setAccessoryType:(UITableViewCellAccessoryDisclosureIndicator)];
    NSArray *array = self.titles[indexPath.section];
    NSString *title = array[indexPath.row];
    cell.textLabel.text = title;
    cell.imageView.image = [UIImage imageNamed:@"out"];
    return cell;
}

#pragma mark - UITableViewDelegate
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    if (![[MSAccountManager sharedManager] hasLogin]) {
        [MSLoginViewController loginSuccess:nil failure:nil];
        return;
    }
    
    //物资相关
    if (indexPath.section == 0) {
        switch (indexPath.row) {
            case 0:
            {
                MSMaterialFillInViewController *vc = [[MSMaterialFillInViewController alloc]init];
                vc.hidesBottomBarWhenPushed = YES;
                [self.navigationController pushViewController:vc animated:YES];
            }
                break;
            case 1:
            {
                MSMaterialInfoFetchViewController *vc = [[MSMaterialInfoFetchViewController alloc]init];
                vc.hidesBottomBarWhenPushed = YES;
                [self.navigationController pushViewController:vc animated:YES];
            }
                break;
            case 2:
            {
                MSMaterialOutStoreViewController *vc = [[MSMaterialOutStoreViewController alloc]initWithType:MSCellIndexOfTypeMaterialOut];
                vc.hidesBottomBarWhenPushed = YES;
                [self.navigationController pushViewController:vc animated:YES];
            }
                break;
            case  3:
            {
                MSMaterialOutStoreViewController *vc = [[MSMaterialOutStoreViewController alloc]initWithType:MSCellIndexOfTypeMateriaIn];
                vc.hidesBottomBarWhenPushed = YES;
                [self.navigationController pushViewController:vc animated:YES];
            }
                break;
            case 4:
            {
                MSOutInInfosQueryViewController *vc = [[MSOutInInfosQueryViewController alloc]initWithType:MSCellIndexOfTypeOutInfosQuery];
                vc.hidesBottomBarWhenPushed = YES;
                [self.navigationController pushViewController:vc animated:YES];
            }
                break;
            case 5:
            {
                MSOutInInfosQueryViewController *vc = [[MSOutInInfosQueryViewController alloc]initWithType:MSCellIndexOfTypeInInfosQuery];
                vc.hidesBottomBarWhenPushed = YES;
                [self.navigationController pushViewController:vc animated:YES];
            }
                break;
            default:
                break;
        }
    }
    
    //工器具相关
    if (indexPath.section == 1) {
        UIViewController *vc = nil;
        switch (indexPath.row) {
            case 0:
            {
                vc = [[MSToolInfoFillInViewController alloc]init];
            }
                break;
            case 1:
            {
                vc = [[MSToolStateInfoQueryViewController alloc]init];
            }
                break;
            case 2:
            {
                vc = [[MSToolBorrowViewController alloc]init];
            }
                break;
            case 3:
            {
                vc = [[MSToolLoanViewController alloc]init];
            }
                break;
            case 4:
            {
                vc = [[MSToolOutInInfosQueryViewController alloc]initWithType:indexPath.row];
            }
                break;
            case 5:
            {
                vc = [[MSToolOutInInfosQueryViewController alloc]initWithType:indexPath.row];
            }
            default:
                break;
        }
        vc.hidesBottomBarWhenPushed = YES;
        [self.navigationController pushViewController:vc animated:YES];
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 44;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return 20.0f;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    if (section == 1) {
        return 20.0f;
    }
    return CGFLOAT_MIN;
}

#pragma mark - Lazy Property
- (NSArray *)titles {
    if (!_titles) {
        _titles = @[@[@"物资信息填写",@"物资信息查询",@"物资出库",@"物资入库",@"出库记录查询",@"入库记录查询"],
                    @[@"工器具填写",@"工器具状态查询",@"工器具借用",@"工器具归还",@"工器具借用记录",@"工器具归还记录"]];
    }
    return _titles;
}

- (NSArray *)icons {
    if (!_icons) {
        _icons = [NSArray array];
    }
    return _icons;
}

@end
