//
//  MSPersonModel.m
//  MSTreasuryManager
//
//  Created by apple on 17/1/6.
//  Copyright © 2017年 邓利文. All rights reserved.
//

#import "MSPersonModel.h"

@implementation MSPersonModel

+ (NSDictionary *)mj_replacedKeyFromPropertyName {
    return @{@"personId" : @"id"};
}

- (NSString *)jobName {
    //0-班组长，1-班组工程师，2-班组安全员，3-班组成员
    switch (self.job) {
        case MSJobTypeGroupLeader:
            return @"班组长";
        case MSJobTypeGroupEngineer:
            return @"班组工程师";
        case MSJobTypeGroupSafetyOfficer:
            return @"班组安全员";
        case MSJobTypeGroupMember:
            return @"班组成员";
        default:
            return @"班组成员";
    }
}

@end
