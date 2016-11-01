//
//  MSBaseApiTest.m
//  MSTreasuryManager
//
//  Created by 邓利文 on 2016/10/31.
//  Copyright © 2016年 邓利文. All rights reserved.
//

#import "MSBaseApiTest.h"

@implementation MSBaseApiTest

- (dispatch_group_t)testGroup {
    if (!_testGroup) {
        _testGroup =  dispatch_group_create();
    }
    return _testGroup;
}

- (void)waitForGroup:(void(^)(dispatch_group_t group))block {
    
    [self newworkGlobleSettings];
    __block BOOL didComplete = NO;
    
    dispatch_group_enter(self.testGroup);
    
    block(self.testGroup);
    
    dispatch_group_notify(self.testGroup, dispatch_get_main_queue(), ^{
        //所有数据请求完成;
        didComplete = YES;
    });
    
    while (! didComplete) {
        NSTimeInterval const interval = 0.002;
        if (! [[NSRunLoop currentRunLoop] runMode:NSDefaultRunLoopMode beforeDate:[NSDate dateWithTimeIntervalSinceNow:interval]]) {
            [NSThread sleepForTimeInterval:interval];
        }
    }
    
}

- (void)testApi {
    NSLog(@"hello");
}

- (void)newworkGlobleSettings {
    [[ZCApiRunner sharedInstance] startWithDebugDomain:@"http://139.196.112.30:8080/web/" releaseDomain:@""];
    [[ZCApiRunner sharedInstance] codeKey:@"code"];
    [[ZCApiRunner sharedInstance] successCodes:@[@"200"]];
    [[ZCApiRunner sharedInstance] warningReturnCodes:@[@"-1"] withHandler:^(NSString *code) {
        if ([code isEqualToString:@"-1"]) {
            //做自己的操作,例如登录等
        }
    }];
}

@end
