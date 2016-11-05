//
//  AppDelegate.m
//  MSTreasuryManager
//
//  Created by 邓利文 on 2016/10/3.
//  Copyright © 2016年 邓利文. All rights reserved.
//

#import "AppDelegate.h"
#import "MSTabBarControllerConfig.h"
#import <IQKeyboardManager.h>
#import "MSAccountManager.h"

#import "MSNetworking+Material.h"
#import "ZCNetworking.h"

@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.
    self.window = [[UIWindow alloc]initWithFrame:[UIScreen mainScreen].bounds];
    self.window.backgroundColor = [UIColor redColor];
    MSTabBarControllerConfig *config = [[MSTabBarControllerConfig alloc]init];
    self.window.rootViewController = config.tabBarController;
    
    [MSAccountManager sharedManager];
    [IQKeyboardManager sharedManager].enable = YES;

    
    [self networkGlobleSettings];
    
    [SVProgressHUD setDefaultStyle:(SVProgressHUDStyleDark)];
    [SVProgressHUD setMinimumDismissTimeInterval:1.5f];
    
    return YES;
}

- (void)networkGlobleSettings {
    [[ZCApiRunner sharedInstance] startWithDebugDomain:@"http://139.196.112.30:8080/web/" releaseDomain:@""];
    [[ZCApiRunner sharedInstance] codeKey:@"code"];
    [[ZCApiRunner sharedInstance] successCodes:@[@"200"]];
    [[ZCApiRunner sharedInstance] warningReturnCodes:@[@"-1"] withHandler:^(NSString *code) {
        if ([code isEqualToString:@"-1"]) {
            //做自己的操作,例如登录等
        }
    }];
}

- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
}


- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}


- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
}


- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}


- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}


@end
