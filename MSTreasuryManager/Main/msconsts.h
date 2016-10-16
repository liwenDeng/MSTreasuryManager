//
//  msconsts.h
//  MyTemplateProject
//
//  Created by dengliwen on 16/7/7.
//  Copyright © 2016年 dengliwen. All rights reserved.
//
/* msconsts_h */
/**
 *  常用宏
 */
#ifndef msconsts_h
#define msconsts_h
#import <UIKit/UIKit.h>

#pragma mark - SCREEN
// 屏幕SIZE
#define kSCREEN_WIDTH [UIScreen mainScreen].bounds.size.width
#define kSCREENH_HEIGHT [UIScreen mainScreen].bounds.size.height

#pragma mark - COLOR
/**
 *  RGBA颜色宏
 */
#define kLRRGBColor(r, g, b) [UIColor colorWithRed:(r)/255.0 green:(g)/255.0 blue:(b)/255.0 alpha:1.0]
#define kLRRGBAColor(r, g, b, a) [UIColor colorWithRed:(r)/255.0 green:(r)/255.0 blue:(r)/255.0 alpha:a]

#pragma mark - 设备型号/系统版本
#define kIS_IPHONE (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPhone)
#define kIS_IPAD (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad)
#define kIS_IPOD ([[[UIDevice currentDevice] model] isEqualToString:@"iPod touch"])
#define kIPhone5SE [[UIScreen mainScreen] bounds].size.width == 320.0f && [[UIScreen mainScreen] bounds].size.height == 568.0f
#define kIPhone6_6s [[UIScreen mainScreen] bounds].size.width == 375.0f && [[UIScreen mainScreen] bounds].size.height == 667.0f
// 判断是否为iPhone 6Plus/6sPlus
#define kIPhone6Plus_6sPlus [[UIScreen mainScreen] bounds].size.width == 414.0f && [[UIScreen mainScreen] bounds].size.height == 736.0f
//获取系统版本
#define kIOS_SYSTEM_VERSION [[[UIDevice currentDevice] systemVersion] floatValue]
//判断 iOS 8 或更高的系统版本
#define kIOS_VERSION_8_OR_LATER (([[[UIDevice currentDevice] systemVersion] floatValue] >=8.0)? (YES):(NO))

#endif

////////////////////////////////////////////////////////////////////////////////////////////////
#pragma mark - DEBUG


#ifdef DEBUG
#define MSLog(...) NSLog(@"%s 第%d行 \n %@\n\n",__func__,__LINE__,[NSString stringWithFormat:__VA_ARGS__])
#else
#define MSLog(...)

#endif

#pragma mark - 真机?模拟器
/**
 *  判断真机还是模拟器
 */
/**
    #if TARGET_OS_IPHONE
    //iPhone Device
    #endif

    #if TARGET_IPHONE_SIMULATOR
    //iPhone Simulator
    #endif
*/

#define MSWeakSelf __weak typeof(self) weakSelf = self;
