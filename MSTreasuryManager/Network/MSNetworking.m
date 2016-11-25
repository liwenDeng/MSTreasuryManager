//
//  MSNetworking.m
//  MyTemplateProject
//
//  Created by dengliwen on 16/6/28.
//  Copyright © 2016年 dengliwen. All rights reserved.
//

#import "MSNetworking.h"
#import "NSString+Code.h"
#import <AFNetworking.h>
#import "MSAccountManager.h"

@implementation MSNetworking

+ (NSURLSessionDataTask *)loginUserName:(NSString *)userName password:(NSString *)password success:(MSSuccessBlock)success failure:(MSFailureBlock)failure {
    ZCApiAction *action = [[ZCApiAction alloc] initWithURL:@"admin/app/login"];
    
    NSString *md5Password = [[NSString stringWithFormat:@"abcd1234%@",password] ms_md5];
    action.params[@"username"] = userName ? : @"";
    action.params[@"password"] = md5Password ? : @"";
    
    [action setHttpMethod:HttpPost];
    
    return [[ZCApiRunner sharedInstance] runAction:action success:^(id object) {
        NSDictionary *data = object[@"data"];
        NSString *stoken = data[@"token"];
        NSString *suserid = data[@"userid"];
        NSString *susername = data[@"username"];
        
        [[MSAccountManager sharedManager]loginWithUserName:susername userId:suserid password:password token:stoken];
        success(object);
    } failure:^(NSError *error) {
        failure(error);
    }];
}

+ (NSURLSessionDataTask *)logoutSuccess:(MSSuccessBlock)success failure:(MSFailureBlock)failure {
    ZCApiAction *action = [[ZCApiAction alloc] initWithURL:@"admin/app/logout"];
    [action setHttpMethod:HttpPost];
    
    return [[ZCApiRunner sharedInstance] runAction:action success:^(id object) {
        [[MSAccountManager sharedManager]logOut];
        success(object);
    } failure:^(NSError *error) {
        [[MSAccountManager sharedManager]logOut];
        failure(error);
    }];
}

@end
