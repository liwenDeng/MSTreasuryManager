//
//  MSNetworking+Tool.m
//  MSTreasuryManager
//
//  Created by 邓利文 on 2016/11/8.
//  Copyright © 2016年 邓利文. All rights reserved.
//

#import "MSNetworking+Tool.h"

@implementation MSNetworking (Tool)

+ (NSURLSessionDataTask *)addTool:(NSString*)toolName success:(MSSuccessBlock)success failure:(MSFailureBlock)failure {
    ZCApiAction *action = [[ZCApiAction alloc] initWithURL:@"admin/app/tools/save"];
    
    action.params[@"name"] = toolName ? : @"";
    
    [action setHttpMethod:HttpPost];
    
    return [[ZCApiRunner sharedInstance] runAction:action success:^(id object) {
        success(object);
    } failure:^(NSError *error) {
        failure(error);
    }];
}

+ (NSURLSessionDataTask *)getToolList:(NSString *)toolName pageNo:(NSInteger)pageNo success:(MSSuccessBlock)success failure:(MSFailureBlock)failure {
    return [self getToolList:toolName status:-100 pageNo:pageNo success:success failure:failure];
}

+ (NSURLSessionDataTask *)getToolList:(NSString *)toolName status:(NSInteger)status pageNo:(NSInteger)pageNo success:(MSSuccessBlock)success failure:(MSFailureBlock)failure {
    
    ZCApiAction *action = [[ZCApiAction alloc] initWithURL:@"admin/app/tools"];
    if (status >= 0) {
        action.params[@"status"] = @(status);
    }
    action.params[@"name"] = toolName ? : @"";
    action.params[@"pageNo"] = @(pageNo);
    action.params[@"pageSize"] = @(kPageSize);
    
    [action setHttpMethod:HttpPost];
    
    return [[ZCApiRunner sharedInstance] runAction:action success:^(id object) {
        success(object);
    } failure:^(NSError *error) {
        failure(error);
    }];
    
}

+ (NSURLSessionDataTask *)changeTool:(MSToolModel* )toolModel borrowOut:(BOOL)borrowOut success:(MSSuccessBlock)success failure:(MSFailureBlock)failure {
    ZCApiAction *action = [[ZCApiAction alloc] initWithURL:@"admin/app/tools/save"];
    
    action.params[@"id"] = @(toolModel.toolId);
    action.params[@"name"] = toolModel.name;
    if (borrowOut) {
        //借出操作
        action.params[@"status"] = @"1";
        action.params[@"reason"] = toolModel.reason;
        action.params[@"time"] = toolModel.time;
        action.params[@"operator"] = toolModel.operator;
        action.params[@"operator"] = toolModel.phone;
        //审核人

    }else {
        action.params[@"status"] = @"0";
        action.params[@"time"] = toolModel.time;
        action.params[@"operator"] = toolModel.operator;
//        action.params[@"operator"] = toolModel.phone;
    }

    [action setHttpMethod:HttpPost];
    
    return [[ZCApiRunner sharedInstance] runAction:action success:^(id object) {
        success(object);
    } failure:^(NSError *error) {
        failure(error);
    }];
}

@end
