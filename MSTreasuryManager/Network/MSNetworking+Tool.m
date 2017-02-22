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
    action.params[@"auditor"] = toolModel.auditor ? : @"";
    if (borrowOut) {
        //借出操作
        action.params[@"status"] = @"1";
        action.params[@"reason"] = toolModel.reason;
        action.params[@"time"] = toolModel.time;
        action.params[@"operator"] = toolModel.operator;
        action.params[@"phone"] = toolModel.phone;
        //审核人

    }else {
        action.params[@"status"] = @"0";
        action.params[@"time"] = toolModel.time;
        action.params[@"operator"] = toolModel.operator;
        
    }

    [action setHttpMethod:HttpPost];
    
    return [[ZCApiRunner sharedInstance] runAction:action success:^(id object) {
        success(object);
    } failure:^(NSError *error) {
        failure(error);
    }];
}

+ (NSURLSessionDataTask *)changeTool:(MSToolModel *)toolModel toolNames:(NSArray *)toolNames borrowOut:(BOOL)borrowOut success:(MSSuccessBlock)success failure:(MSFailureBlock)failure {
    ZCApiAction *action = [[ZCApiAction alloc] initWithURL:@"admin/app/tools/batch"];
        
//    action.params[@"id"] = @(toolModel.toolId);
    action.params[@"name"] = toolModel.name;
    action.params[@"auditor"] = toolModel.auditor ? : @"";
    action.params[@"tools"] = [toolNames componentsJoinedByString:@","];
    if (borrowOut) {
        //借出操作
        action.params[@"status"] = @"1";
        action.params[@"reason"] = toolModel.reason;
        action.params[@"time"] = toolModel.time;
        action.params[@"operator"] = toolModel.operator;
        action.params[@"phone"] = toolModel.phone;
        //审核人
        
    }else {
        action.params[@"status"] = @"0";
        action.params[@"time"] = toolModel.time;
        action.params[@"operator"] = toolModel.operator;
        
    }
    
    [action setHttpMethod:HttpPost];
    
    return [[ZCApiRunner sharedInstance] runAction:action success:^(id object) {
        success(object);
    } failure:^(NSError *error) {
        failure(error);
    }];
}

+ (NSURLSessionDataTask *)getToolOutInList:(NSString *)toolName status:(NSInteger)status success:(MSSuccessBlock)success failure:(MSFailureBlock)failure {
    ZCApiAction *action = [[ZCApiAction alloc] initWithURL:@"admin/app/tools/log"];
    
    action.params[@"name"] = toolName ? : @"";
    action.params[@"status"] = @(status);
    
    [action setHttpMethod:HttpPost];
    
    return [[ZCApiRunner sharedInstance] runAction:action success:^(id object) {
        success(object);
    } failure:^(NSError *error) {
        failure(error);
    }];
}

+ (NSURLSessionDataTask *)getToolOutInList:(NSString *)toolName pageNo:(NSInteger)pageNo status:(NSInteger)status success:(MSSuccessBlock)success failure:(MSFailureBlock)failure {
    ZCApiAction *action = [[ZCApiAction alloc] initWithURL:@"admin/app/tools/log"];
    
    action.params[@"name"] = toolName ? : @"";
    action.params[@"status"] = @(status);
    action.params[@"pageNo"] = @(pageNo);
    action.params[@"pageSize"] = @(kPageSize);
    
    [action setHttpMethod:HttpPost];
    
    return [[ZCApiRunner sharedInstance] runAction:action success:^(id object) {
        success(object);
    } failure:^(NSError *error) {
        failure(error);
    }];
}

+ (NSURLSessionDataTask *)outInToolDetailInfo:(NSInteger)logId success:(MSSuccessBlock)success failure:(MSFailureBlock)failure {
    ZCApiAction *action = [[ZCApiAction alloc] initWithURL:@"admin/app/toolslog/detail"];
    
    action.params[@"id"] = @(logId);
    
    [action setHttpMethod:HttpPost];
    
    return [[ZCApiRunner sharedInstance] runAction:action success:^(id object) {
        success(object);
    } failure:^(NSError *error) {
        failure(error);
    }];
}

@end
