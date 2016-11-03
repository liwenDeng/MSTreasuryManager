//
//  MSNetworking+Material.h
//  MSTreasuryManager
//
//  Created by 邓利文 on 2016/10/31.
//  Copyright © 2016年 邓利文. All rights reserved.
//

#import "MSNetworking.h"
#import "MSMaterialModel.h"
#import "MSMaterialOutInModel.h"

static const NSInteger kPageSize = 10;

@interface MSNetworking (Material)

/**
 查询物资列表
 */
+ (NSURLSessionDataTask *)getMaterialListWithName:(NSString *)name pageNo:(NSInteger)pageNo success:(MSSuccessBlock)success failure:(MSFailureBlock)failure;

/**
 人员列表
 */
+ (NSURLSessionDataTask *)getStaffListWithName:(NSString *)name pageNo:(NSInteger)pageNo success:(MSSuccessBlock)success failure:(MSFailureBlock)failure;

/**
 出入库列表
 cate : 1 入库 2出库
 */
+ (NSURLSessionDataTask *)getMaterialOutInListWithName:(NSString *)name cate:(NSInteger)cate pageNo:(NSInteger)pageNo success:(MSSuccessBlock)success failure:(MSFailureBlock)failure;

/**
 物资添加
 */
+ (NSURLSessionDataTask *)addMaterialWithName:(NSString *)name
                                    techParam:(NSString *)techParam
                                    storeRoom1:(NSInteger)storeRoom1
                                    storeRoom2:(NSInteger)storeRoom2
                                    systemRoom:(NSInteger)systemRoom
                                    pictures:(NSString *)pictures
                                    success:(MSSuccessBlock)success failure:(MSFailureBlock)failure;

/**
 上传图片
 */
+ (NSURLSessionDataTask *)uploadImage:(UIImage *)image success:(MSSuccessBlock)success failure:(MSFailureBlock)failure;

/**
 查询物资详情信息
 */
+ (NSURLSessionDataTask *)getMaterialDetailInfo:(NSInteger )materialId success:(MSSuccessBlock)success failure:(MSFailureBlock)failure;

/**
 物资出入库操作
 */
+ (NSURLSessionDataTask *)outInMaterial:(MSMaterialOutInModel * )outInModel success:(MSSuccessBlock)success failure:(MSFailureBlock)failure;

/**
 查询物资出入库详情信息
 */
+ (NSURLSessionDataTask *)getMaterialOutInDetailInfo:(NSInteger )materialId success:(MSSuccessBlock)success failure:(MSFailureBlock)failure;

@end
