//
//  MSPersonModel.h
//  MSTreasuryManager
//
//  Created by apple on 17/1/6.
//  Copyright © 2017年 邓利文. All rights reserved.
//

#import <Foundation/Foundation.h>

/**
 人员
 */
@interface MSPersonModel : NSObject

@property (nonatomic, copy) NSString *name; //姓名
@property (nonatomic, copy) NSString *des;  //介绍
@property (nonatomic, copy) NSString *phone;    //电话
@property (nonatomic, copy) NSString *zhiwei;   //职位
@property (nonatomic, copy) NSString *className;//班组
@property (nonatomic, copy) NSString *logoUrl;

@end
