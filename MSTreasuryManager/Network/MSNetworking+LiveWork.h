//
//  MSNetworking+LiveWork.h
//  MSTreasuryManager
//
//  Created by 邓利文 on 2016/11/3.
//  Copyright © 2016年 邓利文. All rights reserved.
//

#import "MSNetworking.h"
#import "MSLiveWorkModel.h"

@interface MSNetworking (LiveWork)

/**
 添加现场工作
 */
+ (NSURLSessionDataTask *)addLiveWork:(MSLiveWorkModel *)liveWorkModel success:(MSSuccessBlock)success failure:(MSFailureBlock)failure;


/**
 查询当天现场工作注意事项与参会人员

 */
+ (NSURLSessionDataTask *)getExistLiveWork:(NSString *)workTime success:(MSSuccessBlock)success failure:(MSFailureBlock)failure;


/**
 查询当天现场工作注意事项与参会人员
 
 */
+ (NSURLSessionDataTask *)getLiveWorkList:(NSString *)workTime success:(MSSuccessBlock)success failure:(MSFailureBlock)failure;

/**
 查询现场工作详情
 
 */
+ (NSURLSessionDataTask *)getLiveWorkDetailInfo:(NSInteger )liveWorkId success:(MSSuccessBlock)success failure:(MSFailureBlock)failure;

@end
