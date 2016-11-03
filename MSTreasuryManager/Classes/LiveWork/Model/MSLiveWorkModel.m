//
//  MSLiveWorkModel.m
//  MSTreasuryManager
//
//  Created by 邓利文 on 2016/11/3.
//  Copyright © 2016年 邓利文. All rights reserved.
//

#import "MSLiveWorkModel.h"

@implementation MSLiveWorkModel

+ (NSDictionary *)mj_replacedKeyFromPropertyName {
    return @{@"workId" : @"id"};
}

+ (NSString *)personStringFromPersonArray:(NSArray *)personArray {
    return [personArray componentsJoinedByString:@","];
}

+ (NSArray *)personArrayFromPersonString:(NSString *)personString {
    return [personString componentsSeparatedByString:@","];
}

@end
