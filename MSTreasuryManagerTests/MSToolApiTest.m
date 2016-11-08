//
//  MSToolApiTest.m
//  MSTreasuryManager
//
//  Created by 邓利文 on 2016/11/8.
//  Copyright © 2016年 邓利文. All rights reserved.
//

#import "MSToolApiTest.h"
#import "MSNetworking+Tool.h"

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

@end
