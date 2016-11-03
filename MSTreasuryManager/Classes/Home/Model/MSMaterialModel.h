//
//  MSMaterialListModel.h
//  MSTreasuryManager
//
//  Created by 邓利文 on 2016/10/31.
//  Copyright © 2016年 邓利文. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface MSMaterialModel : NSObject

@property (nonatomic, assign) NSInteger mid;
@property (nonatomic, copy) NSString *name;
@property (nonatomic, copy) NSString *techParam;
@property (nonatomic, assign) NSInteger storeroom1;
@property (nonatomic, assign) NSInteger storeroom2;
@property (nonatomic, assign) NSInteger system;

//剩余量
@property (nonatomic, assign) NSInteger room1rest;
@property (nonatomic, assign) NSInteger room2rest;
@property (nonatomic, assign) NSInteger systemrest;

//
@property (nonatomic, copy) NSString *imgUrl;
@property (nonatomic, copy) NSArray *pictures;

//本地创建的数据
@property (nonatomic, copy) NSString *localPics;
@property (nonatomic, copy) NSMutableArray *pics;

@end
