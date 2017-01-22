//
//  MSNetworking.h
//  MyTemplateProject
//
//  Created by dengliwen on 16/6/28.
//  Copyright © 2016年 dengliwen. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ZCApiLauncher.h"
#import <SVProgressHUD.h>

static const NSInteger kPageSize = 20;

typedef void(^MSSuccessBlock)(NSDictionary *object);
typedef void(^MSFailureBlock)(NSError *error);

@interface MSNetworking : NSObject


/**
 *  登录
 */
+ (NSURLSessionDataTask *)loginUserName:(NSString *)userName password:(NSString*)password success:(MSSuccessBlock)success failure:(MSFailureBlock)failure;

/**
 *  登出
 */
+ (NSURLSessionDataTask *)logoutSuccess:(MSSuccessBlock)success failure:(MSFailureBlock)failure;

@end

