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

@end
