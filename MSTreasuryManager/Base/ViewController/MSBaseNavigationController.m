//
//  BaseNavigationController.m
//  MyTemplateProject
//
//  Created by dengliwen on 16/8/23.
//  Copyright © 2016年 dengliwen. All rights reserved.
//

#import "MSBaseNavigationController.h"

@implementation MSBaseNavigationController

+ (void)initialize {
    [super initialize];
    UIBarButtonItem *item = [UIBarButtonItem appearance];
    //设置item普通状态
    NSMutableDictionary *attrs = [NSMutableDictionary dictionary];
    attrs[NSFontAttributeName] = [UIFont systemFontOfSize:15];
    attrs[NSForegroundColorAttributeName] =  kTitleColor;//[UIColor ms_colorWithHexString:@"#11cd6e"];
    [item setTitleTextAttributes:attrs forState:UIControlStateNormal];
    
    //设置item不可用状态
    NSMutableDictionary *disabledAttrs = [NSMutableDictionary dictionary];
    disabledAttrs[NSFontAttributeName] = [UIFont systemFontOfSize:15];
    disabledAttrs[NSForegroundColorAttributeName] = kTitleColor;//[UIColor ms_colorWithHexString:@"#11cd6e"];
    [item setTitleTextAttributes:disabledAttrs forState:UIControlStateDisabled];
    
    [[UINavigationBar appearance]setTintColor:kTitleColor];
    
    NSDictionary *dict = [NSDictionary dictionaryWithObject:kTitleColor forKey:UITextAttributeTextColor];
    [[UINavigationBar appearance] setTitleTextAttributes:dict];
}

- (BOOL)shouldAutorotate
{
    //也可以用topViewController判断VC是否需要旋转
    return self.topViewController.shouldAutorotate;
}

- (UIInterfaceOrientationMask)supportedInterfaceOrientations
{
    //也可以用topViewController判断VC支持的方向
    return self.topViewController.supportedInterfaceOrientations;
}

@end
