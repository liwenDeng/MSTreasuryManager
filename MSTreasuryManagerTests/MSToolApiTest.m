//
//  MSToolApiTest.m
//  MSTreasuryManager
//
//  Created by 邓利文 on 2016/11/8.
//  Copyright © 2016年 邓利文. All rights reserved.
//

#import "MSToolApiTest.h"
#import "MSNetworking+Tool.h"
#import "NSString+Code.h"
#import "MSNetworking.h"

@implementation MSToolApiTest

- (void)testAddTool {
    [self waitForGroup:^(dispatch_group_t group) {
        [MSNetworking addTool:@"工具1" success:^(NSDictionary *object) {
           
            dispatch_group_leave(group);
        } failure:^(NSError *error) {
            
            dispatch_group_leave(group);
        }];
    }];
}

- (void)testToolList {
    [self waitForGroup:^(dispatch_group_t group) {
        [MSNetworking getToolList:nil pageNo:1 success:^(NSDictionary *object) {
            NSArray *toolList = [MSToolModel mj_objectArrayWithKeyValuesArray:object[@"data"]];
            dispatch_group_leave(group);
        } failure:^(NSError *error) {
           
            dispatch_group_leave(group);
        }];
    }];
}

- (void)testMd5{
    NSString *s = @"ABCD1234123456";
    NSString *md5S = [s ms_md5];
    NSLog(@"%@",md5S);
    
    NSString *hexMd5 = [@"abcd1234123456" ms_md5];
    
    NSLog(@"finish");
}

- (void)testMSLogin {
    [self waitForGroup:^(dispatch_group_t group) {
        [MSNetworking loginUserName:@"admin" password:@"123456" success:^(NSDictionary *object) {
            
            
            dispatch_group_leave(group);
        } failure:^(NSError *error) {
            
            dispatch_group_leave(group);
        }];
    }];

}

- (void)testLogOut {
    [self waitForGroup:^(dispatch_group_t group) {
        [MSNetworking logoutSuccess:^(NSDictionary *object) {
           
            dispatch_group_leave(group);
        } failure:^(NSError *error) {
            
            dispatch_group_leave(group);
        }];
    }];
}

@end
