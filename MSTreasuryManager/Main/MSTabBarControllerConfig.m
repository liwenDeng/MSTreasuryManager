//
//  MSTabBarControllerConfig.m
//  MyTemplateProject
//
//  Created by dengliwen on 16/6/28.
//  Copyright © 2016年 dengliwen. All rights reserved.
//

#import "MSTabBarControllerConfig.h"
#import "MSBaseNavigationController.h"

#import "MSHomeViewController.h"
#import "MSLiveWorkViewController.h"
#import "MSToolManageViewController.h"
#import "MSMyCenterViewController.h"

#import "MSMaterialToolViewController.h"
#import "MSNewHomeViewController.h"

//#pragma mark -HideTabBarMethod
//@interface CYLBaseNavigationController : UINavigationController
//
//@end
//
//@implementation CYLBaseNavigationController
//
//- (void)pushViewController:(UIViewController *)viewController animated:(BOOL)animated {
//    if (self.viewControllers.count > 0) {
//        viewController.hidesBottomBarWhenPushed = YES;
//    }
//    [super pushViewController:viewController animated:animated];
//}
//
//@end

/** NOTES
   vc.navigationItem.title = @"首页";  通过navigationItem.title 设置tabBar title
   [vc.navigationController.tabBarItem setBadgeValue:@"3"] 设置未读消息

 */

@interface MSTabBarControllerConfig ()

@end

@implementation MSTabBarControllerConfig

- (instancetype)init {
    if (self = [super init]) {
        MSBaseTabBarController *tabBarVC = [[MSBaseTabBarController alloc]initWithViewControllers:self.viewControllers tabBarItemsAttributes:self.tabBarItemsAttributesForController];
        //设置tabBarItem 按钮样式
        [self customizeTabBarAppearance:tabBarVC];

        self.tabBarController = tabBarVC;
    }
    return self;
}

# pragma mark - UtilMethod
/**
 *  更多TabBar自定义设置：比如：tabBarItem 的选中和不选中文字和背景图片属性、tabbar 背景图片属性等等
 */
- (void)customizeTabBarAppearance:(CYLTabBarController *)tabBarController {
#warning CUSTOMIZE YOUR TABBAR APPEARANCE
    // Customize UITabBar height
    // 自定义 TabBar 高度
    // tabBarController.tabBarHeight = 40.f;
    
    // set the text color for unselected state
    // 普通状态下的文字属性
    NSMutableDictionary *normalAttrs = [NSMutableDictionary dictionary];
    normalAttrs[NSForegroundColorAttributeName] = [UIColor grayColor];
    
    // set the text color for selected state
    // 选中状态下的文字属性
    NSMutableDictionary *selectedAttrs = [NSMutableDictionary dictionary];
    selectedAttrs[NSForegroundColorAttributeName] = kTitleColor;
    
    // set the text Attributes
    // 设置文字属性
    UITabBarItem *tabBar = [UITabBarItem appearance];
    [tabBar setTitleTextAttributes:normalAttrs forState:UIControlStateNormal];
    [tabBar setTitleTextAttributes:selectedAttrs forState:UIControlStateSelected];
    
    // Set the dark color to selected tab (the dimmed background)
    // TabBarItem选中后的背景颜色
    // [self customizeTabBarSelectionIndicatorImage];
    
    // update TabBar when TabBarItem width did update
    // If your app need support UIDeviceOrientationLandscapeLeft or UIDeviceOrientationLandscapeRight，
    // remove the comment '//'
    // 如果你的App需要支持横竖屏，请使用该方法移除注释 '//'
    // [self updateTabBarCustomizationWhenTabBarItemWidthDidUpdate];
    
    // set the bar shadow image
    // This shadow image attribute is ignored if the tab bar does not also have a custom background image.So at least set somthing.
//    [[UITabBar appearance] setBackgroundImage:[[UIImage alloc] init]];
//    [[UITabBar appearance] setBackgroundColor:[UIColor whiteColor]];
//    [[UITabBar appearance] setShadowImage:[UIImage imageNamed:@"tapbar_top_line"]];
    
    // set the bar background image
    // 设置背景图片
    // UITabBar *tabBarAppearance = [UITabBar appearance];
    // [tabBarAppearance setBackgroundImage:[UIImage imageNamed:@"tabbar_background"]];
    
    // remove the bar system shadow image
    // 去除 TabBar 自带的顶部阴影
    // [[UITabBar appearance] setShadowImage:[[UIImage alloc] init]];
}


- (NSArray *)viewControllers {
    MSNewHomeViewController *vc1 = [[MSNewHomeViewController alloc]init];
    MSBaseNavigationController *navi1 = [[MSBaseNavigationController alloc]initWithRootViewController:vc1];
    vc1.navigationItem.title = @"首页";
    
    MSMaterialToolViewController *vc2 = [[MSMaterialToolViewController alloc]initWithStyle:(UITableViewStyleGrouped)];
    MSBaseNavigationController *navi2 = [[MSBaseNavigationController alloc]initWithRootViewController:vc2];
    vc2.navigationItem.title = @"物资工具";
    
    MSToolManageViewController *vc3 = [[MSToolManageViewController alloc]init];
    MSBaseNavigationController *navi3 = [[MSBaseNavigationController alloc]initWithRootViewController:vc3];
    vc3.navigationItem.title = @"工器具";
    
    MSMyCenterViewController *vc4 = [[MSMyCenterViewController alloc]initWithStyle:(UITableViewStyleGrouped)];
    MSBaseNavigationController *navi4 = [[MSBaseNavigationController alloc]initWithRootViewController:vc4];
    vc4.navigationItem.title = @"我的";
    
    NSArray *viewControllers = @[navi1,
                                 navi2,
                                 navi3,
                                 navi4];
    return viewControllers;
}

- (NSArray *)tabBarItemsAttributesForController {
    NSDictionary *firstTabBarItemsAttributes = @{
                                                 CYLTabBarItemTitle : @"首页",
                                                 CYLTabBarItemImage : @"material",
                                                 CYLTabBarItemSelectedImage : @"material_s",
                                                 };
    NSDictionary *secondTabBarItemsAttributes = @{
                                                  CYLTabBarItemTitle : @"物资工具",
                                                  CYLTabBarItemImage : @"livework",
                                                  CYLTabBarItemSelectedImage : @"livework_s",
                                                  };
    NSDictionary *thirdTabBarItemsAttributes = @{
                                                 CYLTabBarItemTitle : @"工器具",
                                                 CYLTabBarItemImage : @"tool",
                                                 CYLTabBarItemSelectedImage : @"tool_s",
                                                 };
    NSDictionary *fourthTabBarItemsAttributes = @{
                                                  CYLTabBarItemTitle : @"我的",
                                                  CYLTabBarItemImage : @"my",
                                                  CYLTabBarItemSelectedImage : @"my_s"
                                                  };
    NSArray *tabBarItemsAttributes = @[
                                       firstTabBarItemsAttributes,
                                       secondTabBarItemsAttributes,
                                       thirdTabBarItemsAttributes,
                                       fourthTabBarItemsAttributes
                                       ];
    return tabBarItemsAttributes;
}

#pragma mark - UITabBarControllerDelegate
@end
