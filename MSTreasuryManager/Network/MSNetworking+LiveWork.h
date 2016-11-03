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

+ (NSURLSessionDataTask *)addLiveWork:(MSLiveWorkModel *)liveWorkModel success:(MSSuccessBlock)success failure:(MSFailureBlock)failure;

@end
