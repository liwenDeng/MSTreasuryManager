//
//  MSNetworking+Tool.h
//  MSTreasuryManager
//
//  Created by 邓利文 on 2016/11/8.
//  Copyright © 2016年 邓利文. All rights reserved.
//

#import "MSNetworking.h"
#import "MSToolModel.h"

@interface MSNetworking (Tool)

/**
 工器具添加
 
 */
+ (NSURLSessionDataTask *)addTool:(NSString* )toolName success:(MSSuccessBlock)success failure:(MSFailureBlock)failure;

/**
 工器具列表
 
 */
+ (NSURLSessionDataTask *)getToolList:(NSString* )toolName pageNo:(NSInteger)pageNo success:(MSSuccessBlock)success failure:(MSFailureBlock)failure;

/**
 工器具在库/借出 列表查询
 
 */
+ (NSURLSessionDataTask *)getToolList:(NSString* )toolName status:(NSInteger)status pageNo:(NSInteger)pageNo success:(MSSuccessBlock)success failure:(MSFailureBlock)failure;

/**
 工器出入库操作
 
 */
+ (NSURLSessionDataTask *)changeTool:(MSToolModel* )toolModel borrowOut:(BOOL)borrowOut success:(MSSuccessBlock)success failure:(MSFailureBlock)failure;

/**
 工器具在库/借出 列表查询
 
 */
+ (NSURLSessionDataTask *)getToolOutInList:(NSString* )toolName status:(NSInteger)status  success:(MSSuccessBlock)success failure:(MSFailureBlock)failure;
// 分页
+ (NSURLSessionDataTask *)getToolOutInList:(NSString *)toolName pageNo:(NSInteger)pageNo status:(NSInteger)status success:(MSSuccessBlock)success failure:(MSFailureBlock)failure;

/**
 工器具借用/借出详情
 
 */
+ (NSURLSessionDataTask *)outInToolDetailInfo:(NSInteger )logId success:(MSSuccessBlock)success failure:(MSFailureBlock)failure;

@end
