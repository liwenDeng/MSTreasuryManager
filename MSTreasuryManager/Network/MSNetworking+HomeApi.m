//
//  MSNetworking+HomeApi.m
//  MSTreasuryManager
//
//  Created by apple on 17/1/12.
//  Copyright © 2017年 邓利文. All rights reserved.
//

#import "MSNetworking+HomeApi.h"

@implementation MSNetworking (HomeApi)

+ (NSURLSessionDataTask *)getHomeBannerListSuccess:(MSSuccessBlock)success failure:(MSFailureBlock)failure {
    ZCApiAction *action = [[ZCApiAction alloc] initWithURL:@"admin/app/banner/list"];
    action.params[@"cate"] = @"0";
    [action setHttpMethod:HttpPost];
    
    return [[ZCApiRunner sharedInstance] runAction:action success:^(id object) {
        success(object);
    } failure:^(NSError *error) {
        failure(error);
    }];
}

@end
