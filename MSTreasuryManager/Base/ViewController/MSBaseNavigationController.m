//
//  BaseNavigationController.m
//  MyTemplateProject
//
//  Created by dengliwen on 16/8/23.
//  Copyright © 2016年 dengliwen. All rights reserved.
//

#import "MSBaseNavigationController.h"

@implementation MSBaseNavigationController

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
