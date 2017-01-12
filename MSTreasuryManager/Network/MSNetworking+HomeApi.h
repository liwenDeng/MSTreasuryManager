//
//  MSNetworking+HomeApi.h
//  MSTreasuryManager
//
//  Created by apple on 17/1/12.
//  Copyright © 2017年 邓利文. All rights reserved.
//

#import "MSNetworking.h"

@interface MSNetworking (HomeApi)

+ (NSURLSessionDataTask *)getHomeBannerListSuccess:(MSSuccessBlock)success failure:(MSFailureBlock)failure;

@end
