//
//  MSNetworking+Material.m
//  MSTreasuryManager
//
//  Created by 邓利文 on 2016/10/31.
//  Copyright © 2016年 邓利文. All rights reserved.
//

#import "MSNetworking+Material.h"
#import "UIImage+Custom.h"

@implementation MSNetworking (Material)

+ (NSURLSessionDataTask *)getMaterialListWithName:(NSString *)name pageNo:(NSInteger)pageNo success:(MSSuccessBlock)success failure:(MSFailureBlock)failure {
    ZCApiAction *action = [[ZCApiAction alloc] initWithURL:@"admin/app/material"];
    action.params[@"name"] = name;
    action.params[@"pageNo"] = @(pageNo);
    action.params[@"pageSize"] = @(kPageSize);
    [action setHttpMethod:HttpPost];
    
    return [[ZCApiRunner sharedInstance] runAction:action success:^(id object) {
        success(object);
    } failure:^(NSError *error) {
        failure(error);
    }];
}

+ (NSURLSessionDataTask *)getStaffListWithName:(NSString *)name pageNo:(NSInteger)pageNo success:(MSSuccessBlock)success failure:(MSFailureBlock)failure {
    ZCApiAction *action = [[ZCApiAction alloc] initWithURL:@"admin/app/staff"];
    action.params[@"name"] = name;
//    action.params[@"pageNo"] = @(pageNo);
//    action.params[@"pageSize"] = @(kPageSize);
    [action setHttpMethod:HttpPost];
    
    return [[ZCApiRunner sharedInstance] runAction:action success:^(id object) {
        success(object);
    } failure:^(NSError *error) {
        failure(error);
    }];
}

+ (NSURLSessionDataTask *)getMaterialOutInListWithName:(NSString *)name cate:(NSInteger)cate pageNo:(NSInteger)pageNo success:(MSSuccessBlock)success failure:(MSFailureBlock)failure {
    ZCApiAction *action = [[ZCApiAction alloc] initWithURL:@"admin/app/material/log"];
    action.params[@"name"] = name;
    action.params[@"pageNo"] = @(pageNo);
    action.params[@"pageSize"] = @(kPageSize);
    action.params[@"cate"] = @(cate);
    
    [action setHttpMethod:HttpPost];
    
    return [[ZCApiRunner sharedInstance] runAction:action success:^(id object) {
        success(object);
    } failure:^(NSError *error) {
        failure(error);
    }];
}

+ (NSURLSessionDataTask *)addMaterialWithName:(NSString *)name techParam:(NSString *)techParam storeRoom1:(NSInteger)storeRoom1 storeRoom2:(NSInteger)storeRoom2 systemRoom:(NSInteger)systemRoom pictures:(NSString *)pictures success:(MSSuccessBlock)success failure:(MSFailureBlock)failure {

    ZCApiAction *action = [[ZCApiAction alloc] initWithURL:@"admin/app/material/save"];
    action.params[@"name"] = name;
    action.params[@"techParam"] = techParam;
    action.params[@"storeroom1"] = @(storeRoom1);
    action.params[@"storeroom2"] = @(storeRoom2);
    action.params[@"system"] = @(systemRoom);
    if (pictures && pictures.length > 1) {
        action.params[@"pictures"] = pictures;
    }
    
    [action setHttpMethod:HttpPost];
    
    return [[ZCApiRunner sharedInstance] runAction:action success:^(id object) {
        success(object);
    } failure:^(NSError *error) {
        failure(error);
    }];
    
}

//+ (NSURLSessionDataTask *)getMaterialInfoSuccess:(MSSuccessBlock)success failure:(MSFailureBlock)failure {
//    ZCApiAction *action = [[ZCApiAction alloc] initWithURL:@"admin/app/material/info"];
//
//    [action setHttpMethod:HttpPost];
//    
//    return [[ZCApiRunner sharedInstance] runAction:action success:^(id object) {
//        success(object);
//    } failure:^(NSError *error) {
//        failure(error);
//    }];
//}

+ (NSURLSessionDataTask *)uploadImage:(UIImage *)image success:(MSSuccessBlock)success failure:(MSFailureBlock)failure{
    ZCApiUploadAction *action = [[ZCApiUploadAction alloc] initWithURL:@"fileupload"];
    
    NSData *imgData = [image dataOfReducedQualityWithDefaultStandards];
    action.data = imgData;
    action.fileName = @"image.jpg";
    action.uploadName = @"test";
    action.mimeType = @"jpg";
    action.params[@"dir"] = @"material";

    return [[ZCApiRunner sharedInstance] uploadAction:action progress:nil success:^(id object) {
        success(object);
    } failure:^(NSError *error) {
        failure(error);
    }];
}

+ (NSURLSessionDataTask *)getMaterialDetailInfo:(NSInteger )materialId success:(MSSuccessBlock)success failure:(MSFailureBlock)failure {
    ZCApiAction *action = [[ZCApiAction alloc] initWithURL:@"admin/app/material/detail"];
    action.params[@"id"] = @(materialId);
    [action setHttpMethod:HttpPost];
    
    return [[ZCApiRunner sharedInstance] runAction:action success:^(id object) {
        success(object);
    } failure:^(NSError *error) {
        failure(error);
    }];
}

//
+ (NSURLSessionDataTask *)outInMaterial:(MSMaterialOutInModel *)outInModel success:(MSSuccessBlock)success failure:(MSFailureBlock)failure {
    ZCApiAction *action = [[ZCApiAction alloc] initWithURL:@"admin/app/material/manage"];

    action.params[@"cate"] = @(outInModel.cate);
    action.params[@"materialId"] = @(outInModel.materialId);
    action.params[@"location"] = @(outInModel.location);
    action.params[@"count"] = @(outInModel.count);
    action.params[@"operator"] = outInModel.operator;
    action.params[@"auditor"] = outInModel.auditor;
    action.params[@"time"] = outInModel.time;
    
    [action setHttpMethod:HttpPost];
    
    return [[ZCApiRunner sharedInstance] runAction:action success:^(id object) {
        success(object);
    } failure:^(NSError *error) {
        failure(error);
    }];
}

+ (NSURLSessionDataTask *)getMaterialOutInDetailInfo:(NSInteger )materialId success:(MSSuccessBlock)success failure:(MSFailureBlock)failure {
    ZCApiAction *action = [[ZCApiAction alloc] initWithURL:@"admin/app/materiallog/detail"];
    action.params[@"id"] = @(materialId);
    [action setHttpMethod:HttpPost];
    
    return [[ZCApiRunner sharedInstance] runAction:action success:^(id object) {
        success(object);
    } failure:^(NSError *error) {
        failure(error);
    }];
}

@end

