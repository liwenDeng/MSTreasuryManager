//
//  MSLiveWorkTest.m
//  MSTreasuryManager
//
//  Created by 邓利文 on 2016/11/4.
//  Copyright © 2016年 邓利文. All rights reserved.
//

#import "MSLiveWorkTest.h"
#import "MSNetworking+LiveWork.h"

@implementation MSLiveWorkTest

- (void)testExsitLiveWork {
    [self waitForGroup:^(dispatch_group_t group) {
        [MSNetworking getExistLiveWork:@"2016-11-04" success:^(NSDictionary *object) {
            
            MSLiveWorkModel *model = [MSLiveWorkModel mj_objectWithKeyValues:object[@"data"]];
            if (model.persons && model.attention) {
                //已经填写
            }else {
                //未填写
            }
            dispatch_group_leave(group);
        } failure:^(NSError *error) {
            
            dispatch_group_leave(group);
        }];
    }];
}

- (void)testLiveWorkList {
    [self waitForGroup:^(dispatch_group_t group) {
        [MSNetworking getLiveWorkList:@"2016-11-07" success:^(NSDictionary *object) {
            NSString *attention = object[@"data"][@"attention"];
            if (attention.length) {
                //已经填写
            }else {
                //未填写
            }
            
            NSArray *list = [MSLiveWorkModel mj_objectArrayWithKeyValuesArray:object[@"data"][@"list"]];
            
            
            dispatch_group_leave(group);
        } failure:^(NSError *error) {
            
            dispatch_group_leave(group);
        }];
    }];
}

@end
