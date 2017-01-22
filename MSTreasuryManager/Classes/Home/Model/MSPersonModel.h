//
//  MSPersonModel.h
//  MSTreasuryManager
//
//  Created by apple on 17/1/6.
//  Copyright © 2017年 邓利文. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef enum : NSUInteger {
    MSGenderMale = 0,
    MSGenderFeMale,
} MSGenderType;

/**
 人员
 */
@interface MSPersonModel : NSObject

@property (nonatomic, assign) NSInteger personId;

@property (nonatomic, copy) NSString *name; //姓名
@property (nonatomic, assign) MSGenderType gender;   //性别 0男 1女
@property (nonatomic, assign) NSInteger age;
@property (nonatomic, copy) NSString *phone;    //电话
@property (nonatomic, copy) NSString *img;  //头像
@property (nonatomic, copy) NSString *introduction;  //介绍
@property (nonatomic, copy) NSString *job;   //职位 0-班组长，1-班组工程师，2-班组安全员，3-班组成员)
@property (nonatomic, copy) NSString *teamId;//班组id
@property (nonatomic, copy) NSString *createTime; //创建时间
@property (nonatomic, copy) NSString *team;

@end
