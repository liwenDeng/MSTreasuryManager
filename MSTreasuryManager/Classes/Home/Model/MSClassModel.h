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

@property (nonatomic, assign) NSInteger classId;    //id
@property (nonatomic, copy) NSString *name;
@property (nonatomic, copy) NSString *introduction;//班组简介
@property (nonatomic, copy) NSString *ideal;  //班组理念
@property (nonatomic, copy) NSString *catchWord;   //口号
@property (nonatomic, copy) NSString *logo;
@property (nonatomic, copy) NSString *timeAxis;

@end
