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

+ (NSURLSessionDataTask *)getMaterialListWithName:(NSString *)name success:(MSSuccessBlock)success failure:(MSFailureBlock)failure {
    ZCApiAction *action = [[ZCApiAction alloc] initWithURL:@"admin/app/material"];
    action.params[@"name"] = name;
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
    action.params[@"techparam"] = techParam;
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

+ (NSURLSessionDataTask *)getMaterialInfoSuccess:(MSSuccessBlock)success failure:(MSFailureBlock)failure {
    ZCApiAction *action = [[ZCApiAction alloc] initWithURL:@"admin/app/material/info"];

    [action setHttpMethod:HttpPost];
    
    return [[ZCApiRunner sharedInstance] runAction:action success:^(id object) {
        success(object);
    } failure:^(NSError *error) {
        failure(error);
    }];
}

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



@end

