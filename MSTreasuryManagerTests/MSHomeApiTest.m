//
//  MSHomeApiTest.m
//  MSTreasuryManager
//
//  Created by apple on 17/1/12.
//  Copyright © 2017年 邓利文. All rights reserved.
//

#import "MSHomeApiTest.h"
#import "MSNetworking+HomeApi.h"

@implementation MSHomeApiTest

- (void)testBannerList {
    [self waitForGroup:^(dispatch_group_t group) {
        [MSNetworking getHomeBannerListSuccess:^(NSDictionary *object) {
            NSLog(@"successed:%@",object);
            dispatch_group_leave(group);
        } failure:^(NSError *error) {
            NSLog(@"%@",error);
            dispatch_group_leave(group);
        }];
    }];
}

- (void)testClassList {
    [self waitForGroup:^(dispatch_group_t group) {
        [MSNetworking getClassListSuccess:^(NSDictionary *object) {
            
            dispatch_group_leave(group);
        } failure:^(NSError *error) {
            dispatch_group_leave(group);
        }];
    }];
}

- (void)testClassDetail {
    [self waitForGroup:^(dispatch_group_t group) {
        [MSNetworking getClassDetailInfoClassId:4 success:^(NSDictionary *object) {
            
            dispatch_group_leave(group);
        } failure:^(NSError *error) {
            dispatch_group_leave(group);
        }];
    }];
}

- (void)testPersonList {
    [self waitForGroup:^(dispatch_group_t group) {
        [MSNetworking getPersonListSuccess:^(NSDictionary *object) {
            
            dispatch_group_leave(group);
        } failure:^(NSError *error) {
            dispatch_group_leave(group);
        }];
    }];
}

- (void)testPersonDetail {
    [self waitForGroup:^(dispatch_group_t group) {
        [MSNetworking getPersonDetailInfoPersonId:5 success:^(NSDictionary *object) {
            
            dispatch_group_leave(group);
        } failure:^(NSError *error) {
            dispatch_group_leave(group);
        }];
    }];
}

@end
