//
//  NSDate+MSExtension.h
//  MyTemplateProject
//
//  Created by dengliwen on 16/7/5.
//  Copyright © 2016年 dengliwen. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef enum : NSUInteger {
    MSDateMonday = 1, //周一
    MSDateTuesday,
    MSDateWednesday,
    MSDateThursday,
    MSDateFriday,
    MSDateSaturday,
    MSDateSunday
} MSDateWeekDay;

@interface MSDateItem : NSObject
@property (nonatomic, assign) NSInteger day;
@property (nonatomic, assign) NSInteger hour;
@property (nonatomic, assign) NSInteger minute;
@property (nonatomic, assign) NSInteger second;
@end

@interface NSDate (MSExtension)

- (BOOL)ms_isToday;
- (BOOL)ms_isYesterday;
- (BOOL)ms_isTomorrow;
- (BOOL)ms_isThisYear;

/**
 *  今天周几
 */
- (MSDateWeekDay)ms_getNowWeekday;

/**
 *  两个时间之间的间隔
 *
 */
- (MSDateItem *)ms_timeIntervalSinceDate:(NSDate *)anotherDate;

/**
 *  获取当前时间
 *  @param format @"yyyy-MM-dd HH:mm:ss"、@"yyyy年MM月dd日 HH时mm分ss秒"
 */
+ (NSString *)currentDateWithFormat:(NSString *)format;

/**
 *  计算上次日期距离现在多久
 *  format: @"yyyy-MM-dd HH:mm:ss"、@"yyyy年MM月dd日 HH时mm分ss秒"
 *  @param lastTime    上次日期(需要和格式对应)
 *  @param format1     上次日期格式
 *  @param currentTime 最近日期(需要和格式对应)
 *  @param format2     最近日期格式
 *
 *  @return xx分钟前、xx小时前、xx天前
 */
+ (NSString *)ms_timeIntervalFromLastTime:(NSString *)lastTime
                           lastTimeFormat:(NSString *)format1
                            ToCurrentTime:(NSString *)currentTime
                        currentTimeFormat:(NSString *)format2;

@property (readonly) NSInteger ms_nearestHour;
@property (readonly) NSInteger ms_hour;
@property (readonly) NSInteger ms_minute;
@property (readonly) NSInteger ms_seconds;
@property (readonly) NSInteger ms_day;
@property (readonly) NSInteger ms_month;
@property (readonly) NSInteger ms_weekOfMonth;
@property (readonly) NSInteger ms_weekOfYear;
@property (readonly) NSInteger ms_weekday;
@property (readonly) NSInteger ms_nthWeekday; // e.g. 2nd Tuesday of the month == 2
@property (readonly) NSInteger ms_year;

@end
