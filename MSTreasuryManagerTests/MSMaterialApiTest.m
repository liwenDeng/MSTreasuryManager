//
//  MSMaterialApiTest.m
//  MSTreasuryManager
//
//  Created by 邓利文 on 2016/10/31.
//  Copyright © 2016年 邓利文. All rights reserved.
//

#import "MSMaterialApiTest.h"
#import "MSNetworking+Material.h"

@implementation MSMaterialApiTest

//1.
- (void)testMaterialList {
    [self waitForGroup:^(dispatch_group_t group) {
        NSLog(@"start");
        [MSNetworking getMaterialListWithName:@"" pageNo:1 success:^(NSDictionary *object) {
            /*
             {
             id = 7;
             name = "\U5b89\U6392";
             */
            NSArray *list = [MSMaterialModel mj_objectArrayWithKeyValuesArray:object[@"data"]];
            
            dispatch_group_leave(group);
        } failure:^(NSError *error) {
            NSLog(@"ee");

            dispatch_group_leave(group);
        }];
    }];
}

//2.add
- (void)testAddMaterial {
    [self waitForGroup:^(dispatch_group_t group) {
        [MSNetworking addMaterialWithName:@"test-name-withNoPic" techParam:@"test-params" storeRoom1:1 storeRoom2:2 systemRoom:1 pictures:nil success:^(NSDictionary *object) {
            NSLog(@"添加成功");
            dispatch_group_leave(group);
        } failure:^(NSError *error) {
            
            NSLog(@"添加失败");
            dispatch_group_leave(group);
        }];
    }];
}

//3.上传图片
- (void)testUploadImage {
    /*
     {
     imgs =     (
     "/upload/material/0deea8f8-aefb-4514-a26f-ea3d40c5c966.jpg"
     );
     status = 200;
     }
     */
    [self waitForGroup:^(dispatch_group_t group) {
        UIImage *img = [UIImage imageNamed:@"head"];
        [MSNetworking uploadImage:img success:^(NSDictionary *object) {
            
            dispatch_group_leave(group);
        } failure:^(NSError *error) {
            
            dispatch_group_leave(group);
        }];
    }];
}

- (void)testMaterialDetailInfo {
    [self waitForGroup:^(dispatch_group_t group) {
        [MSNetworking getMaterialDetailInfo:18 success:^(NSDictionary *object) {
            MSMaterialModel *model = [MSMaterialModel mj_objectWithKeyValues:object[@"data"]];
            
            dispatch_group_leave(group);
        } failure:^(NSError *error) {
            dispatch_group_leave(group);
        }];
    }];
}

- (void)testMaterialOutinList {
    [self waitForGroup:^(dispatch_group_t group) {
        [MSNetworking getMaterialOutInListWithName:@"" cate:1 pageNo:1 success:^(NSDictionary *object) {
            NSArray *list = [MSMaterialOutInModel mj_objectArrayWithKeyValuesArray:object[@"data"]];
            
            dispatch_group_leave(group);
        } failure:^(NSError *error) {
            dispatch_group_leave(group);
        }];
    }];
}

- (void)testMaterialOutInDetailInfo {
    [self waitForGroup:^(dispatch_group_t group) {
        [MSNetworking getMaterialOutInDetailInfo:12 success:^(NSDictionary *object) {
            MSMaterialOutInModel *list = [MSMaterialOutInModel mj_objectWithKeyValues:object[@"data"]];
            
            dispatch_group_leave(group);
        } failure:^(NSError *error) {
            dispatch_group_leave(group);
        }];
    }];
}

@end
