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

typedef void(^MSSuccessBlock)(NSDictionary *object);
typedef void(^MSFailureBlock)(NSError *error);

@interface MSNetworking : NSObject

////(MSSuccessBlock)success failure:(MSFailureBlock)failure;
//+ (NSURLSessionDataTask *)requestSomethingWithSuccess:(MSSuccessBlock)success failure:(MSFailureBlock)failure;
//
//#pragma mark - 斗鱼API
///**
// 获取斗鱼分类列表
// */
//+ (NSURLSessionDataTask *)getDouyuColumnList:(MSSuccessBlock)success failure:(MSFailureBlock)failure;
//
///**
// 获取斗鱼顶部tabbar分类
// */
//+ (NSURLSessionDataTask *)getDouyuTopBarInfos:(MSSuccessBlock)success failure:(MSFailureBlock)failure;
//
////================================================================================
//#pragma mark - 首页请求
//
//#pragma mark - 房间信息
///**
// *  4.获取斗鱼房间详细信息
// */
//+ (NSURLSessionDataTask *)getDouyuRoomLiveInfo:(NSString *)roomId success:(MSSuccessBlock)success failure:(MSFailureBlock)failure;
//
//
//
//#pragma mark - 我的-登陆
///**
// *  DY登陆
// */
//+ (NSURLSessionDataTask *)loginDYUserName:(NSString *)userName password:(NSString*)password success:(MSSuccessBlock)success failure:(MSFailureBlock)failure;
//
//#pragma mark - WatchHistory 
///**
// *  获取观看历史
// */
//+ (NSURLSessionDataTask *)getDYWatchHistroy:(NSArray *)roomIds success:(MSSuccessBlock)success failure:(MSFailureBlock)failure;


@end

