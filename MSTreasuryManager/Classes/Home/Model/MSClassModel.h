//
//  MSClassModel.h
//  MSTreasuryManager
//
//  Created by apple on 17/1/6.
//  Copyright © 2017年 邓利文. All rights reserved.
//

#import <Foundation/Foundation.h>

/**
 班组
 */
@interface MSClassModel : NSObject

@property (nonatomic, copy) NSString *name;//班组名称
@property (nonatomic, copy) NSString *des;  //描述
@property (nonatomic, copy) NSString *linian;   //理念
@property (nonatomic, copy) NSString *kouhao;   //口号
@property (nonatomic, copy) NSString *logoUrl;

@end
