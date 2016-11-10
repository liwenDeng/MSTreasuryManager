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
    
    action.params[@"chargePerson"] = liveWorkModel.chargePerson;
    action.params[@"context"] = liveWorkModel.context;
    action.params[@"workRecord"] = liveWorkModel.workRecord;
    action.params[@"persons"] = liveWorkModel.persons;
    action.params[@"attention"] = liveWorkModel.attention;
    action.params[@"work_time"] = liveWorkModel.workTime;
    action.params[@"member"] = liveWorkModel.member;
    
    [action setHttpMethod:HttpPost];
    
    return [[ZCApiRunner sharedInstance] runAction:action success:^(id object) {
        success(object);
    } failure:^(NSError *error) {
        failure(error);
    }];
}

+ (NSURLSessionDataTask *)updateLiveWork:(MSLiveWorkModel *)liveWorkModel success:(MSSuccessBlock)success failure:(MSFailureBlock)failure {
    
    ZCApiAction *action = [[ZCApiAction alloc] initWithURL:@"admin/app/scenework/save"];
    
    action.params[@"id"] = @(liveWorkModel.workId);
    action.params[@"chargePerson"] = liveWorkModel.chargePerson;
    action.params[@"context"] = liveWorkModel.context;
    action.params[@"workRecord"] = liveWorkModel.workRecord;
    action.params[@"persons"] = liveWorkModel.persons;
    action.params[@"attention"] = liveWorkModel.attention;
    action.params[@"work_time"] = liveWorkModel.workTime;
    action.params[@"member"] = liveWorkModel.member;
    
    [action setHttpMethod:HttpPost];
    
    return [[ZCApiRunner sharedInstance] runAction:action success:^(id object) {
        success(object);
    } failure:^(NSError *error) {
        failure(error);
    }];
}

+ (NSURLSessionDataTask *)getExistLiveWork:(NSString *)workTime success:(MSSuccessBlock)success failure:(MSFailureBlock)failure {
    ZCApiAction *action = [[ZCApiAction alloc] initWithURL:@"admin/app/dayscenework/check"];
    
    action.params[@"workTime"] = workTime;

    [action setHttpMethod:HttpPost];
    
    return [[ZCApiRunner sharedInstance] runAction:action success:^(id object) {
        success(object);
    } failure:^(NSError *error) {
        failure(error);
    }];
}

+ (NSURLSessionDataTask *)getLiveWorkList:(NSString *)workTime success:(MSSuccessBlock)success failure:(MSFailureBlock)failure {
    ZCApiAction *action = [[ZCApiAction alloc] initWithURL:@"admin/app/dayscenework"];
    
    action.params[@"workTime"] = workTime;
    
    [action setHttpMethod:HttpPost];
    
    return [[ZCApiRunner sharedInstance] runAction:action success:^(id object) {
        success(object);
    } failure:^(NSError *error) {
        failure(error);
    }];
}

+ (NSURLSessionDataTask *)getLiveWorkDetailInfo:(NSInteger )liveWorkId success:(MSSuccessBlock)success failure:(MSFailureBlock)failure {
    ZCApiAction *action = [[ZCApiAction alloc] initWithURL:@"admin/app/scenework/detail"];
    
    action.params[@"id"] = @(liveWorkId);
    
    [action setHttpMethod:HttpPost];
    
    return [[ZCApiRunner sharedInstance] runAction:action success:^(id object) {
        success(object);
    } failure:^(NSError *error) {
        failure(error);
    }];
}

@end
