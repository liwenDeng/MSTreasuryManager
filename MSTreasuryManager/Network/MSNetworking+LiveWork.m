//
//  MSNetworking+LiveWork.m
//  MSTreasuryManager
//
//  Created by 邓利文 on 2016/11/3.
//  Copyright © 2016年 邓利文. All rights reserved.
//

#import "MSNetworking+LiveWork.h"

@implementation MSNetworking (LiveWork)


+ (NSURLSessionDataTask *)addLiveWork:(MSLiveWorkModel *)liveWorkModel success:(MSSuccessBlock)success failure:(MSFailureBlock)failure {
    
    ZCApiAction *action = [[ZCApiAction alloc] initWithURL:@"admin/app/scenework/save"];
    
    action.params[@"charge_person"] = liveWorkModel.charge_person;
    action.params[@"context"] = liveWorkModel.context;
    action.params[@"work_record"] = liveWorkModel.work_record;
    action.params[@"persons"] = liveWorkModel.persons;
    action.params[@"attention"] = liveWorkModel.attention;
    action.params[@"work_time"] = liveWorkModel.work_time;
    
    [action setHttpMethod:HttpPost];
    
    return [[ZCApiRunner sharedInstance] runAction:action success:^(id object) {
        success(object);
    } failure:^(NSError *error) {
        failure(error);
    }];
}

@end
