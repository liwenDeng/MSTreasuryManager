//
//  MSMaterialOutInModel.m
//  MSTreasuryManager
//
//  Created by 邓利文 on 2016/11/2.
//  Copyright © 2016年 邓利文. All rights reserved.
//

#import "MSMaterialOutInModel.h"

@implementation MSMaterialOutInModel

+ (NSDictionary *)mj_replacedKeyFromPropertyName {
    return @{@"materialId":@"id"};
}

+ (NSString *)storeNameWithLocationId:(NSInteger)location {
    if (location == 1) {
        return @"二库库房";
    }
    if (location == 2) {
        return @"退库库房";
    }
    if (location == 3) {
        return @"系统库房";
    }
    return @"";
}

@end
