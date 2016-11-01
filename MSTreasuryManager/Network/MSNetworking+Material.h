//
//  MSNetworking+Material.h
//  MSTreasuryManager
//
//  Created by 邓利文 on 2016/10/31.
//  Copyright © 2016年 邓利文. All rights reserved.
//

#import "MSNetworking.h"
#import "MSMaterialModel.h"

@interface MSNetworking (Material)

/**
 查询物资列表
 */
+ (NSURLSessionDataTask *)getMaterialListWithName:(NSString *)name success:(MSSuccessBlock)success failure:(MSFailureBlock)failure;

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
 出入库时信息选择
 */
+ (NSURLSessionDataTask *)getMaterialInfoSuccess:(MSSuccessBlock)success failure:(MSFailureBlock)failure;

+ (NSURLSessionDataTask *)uploadImage:(UIImage *)image success:(MSSuccessBlock)success failure:(MSFailureBlock)failure;

@end
