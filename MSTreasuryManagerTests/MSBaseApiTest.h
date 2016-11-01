//
//  MSBaseApiTest.h
//  MSTreasuryManager
//
//  Created by 邓利文 on 2016/10/31.
//  Copyright © 2016年 邓利文. All rights reserved.
//

#import <XCTest/XCTest.h>
#import "MSNetworking.h"
#import <MJExtension.h>

@interface MSBaseApiTest : XCTestCase

@property (nonatomic) dispatch_group_t testGroup;

- (void)waitForGroup:(void(^)(dispatch_group_t group))block;

@end
