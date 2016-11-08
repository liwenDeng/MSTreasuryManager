//
//  MSToolModel.m
//  MSTreasuryManager
//
//  Created by 邓利文 on 2016/11/8.
//  Copyright © 2016年 邓利文. All rights reserved.
//

#import "MSToolModel.h"

@implementation MSToolModel

+ (NSDictionary *)mj_replacedKeyFromPropertyName {
    return @{@"toolId":@"id"};
}

- (NSString *)statusName {
    switch ([self.status integerValue]) {
        case 0:
            return @"在库";
            break;
        case 1:
            return @"借出";
            break;
        default:
            return @"未知";
            break;
    }
}

@end
