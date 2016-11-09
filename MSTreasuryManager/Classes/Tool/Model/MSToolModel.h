//
//  MSToolModel.h
//  MSTreasuryManager
//
//  Created by 邓利文 on 2016/11/8.
//  Copyright © 2016年 邓利文. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface MSToolModel : NSObject

@property (nonatomic, assign) NSInteger toolId;
@property (nonatomic, copy) NSString* status; //在库或者借出，0-在库，1-借出

@property (nonatomic, copy) NSString* name;
@property (nonatomic, copy) NSString* time;
@property (nonatomic, copy) NSString* reason;
@property (nonatomic, copy) NSString* operator; //归还人/借出人
@property (nonatomic, copy) NSString* phone;
@property (nonatomic, copy) NSString* auditor;  //审核人

- (NSString *)statusName;

@end
