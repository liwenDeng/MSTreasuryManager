//
//  MSMaterialListModel.m
//  MSTreasuryManager
//
//  Created by 邓利文 on 2016/10/31.
//  Copyright © 2016年 邓利文. All rights reserved.
//

#import "MSMaterialModel.h"

@implementation MSMaterialModel

+ (NSDictionary *)mj_replacedKeyFromPropertyName {
    return @{@"mid" : @"id"};
}

+ (NSDictionary *)mj_objectClassInArray {
    return @{@"pictures":[NSString class]};
}

- (NSString *)localPics {
    NSString *s = [self.pics componentsJoinedByString:@","];
    if (s.length > 1) {
        return s;
    }
    return nil;
    
}
//+ (NSDictionary *)mj_objectClassInArray {
//    return @{@"pictures" : [NSString class]};
//}
- (NSMutableArray *)pics {
    if (!_pics) {
        _pics = [NSMutableArray array];
    }
    return _pics;
}

@end
