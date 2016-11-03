//
//  MSLiveWorkModel.h
//  MSTreasuryManager
//
//  Created by 邓利文 on 2016/11/3.
//  Copyright © 2016年 邓利文. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface MSLiveWorkModel : NSObject

@property (nonatomic, assign) NSInteger workId;

@property (nonatomic, copy) NSString *charge_person;
@property (nonatomic, copy) NSString *member;
@property (nonatomic, copy) NSString *context;
@property (nonatomic, copy) NSString *work_record;
@property (nonatomic, copy) NSString *persons;
@property (nonatomic, copy) NSString *attention;
@property (nonatomic, copy) NSString *work_time;

+ (NSArray *)personArrayFromPersonString:(NSString *)personString;

+ (NSString *)personStringFromPersonArray:(NSArray *)personArray;

@end
