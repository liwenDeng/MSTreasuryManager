//
//  UIView+MSUtil.h
//  MyTemplateProject
//
//  Created by dengliwen on 16/7/7.
//  Copyright © 2016年 dengliwen. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIView (MSUtil)
/**
 *  绘制虚线
 *
 *  @param lineFrame 虚线frame
 *  @param length    虚线中短线宽度
 *  @param spacing   虚线中短线间隔
 *  @param color     虚线颜色
 */
+ (UIView *)ms_createDashedLineWithFrame:(CGRect)lineFrame lineLength:(int)length lineSpacing:(int)spacing lineColor:(UIColor *)color;

@property (assign, nonatomic) CGFloat ms_x;
@property (assign, nonatomic) CGFloat ms_y;
@property (assign, nonatomic) CGFloat ms_w;
@property (assign, nonatomic) CGFloat ms_h;
@property (assign, nonatomic) CGSize ms_size;
@property (assign, nonatomic) CGPoint ms_origin;

/**
 * Shortcut for frame.origin.x.
 *
 * Sets frame.origin.x = left
 */
@property (nonatomic) CGFloat left;

/**
 * Shortcut for frame.origin.y
 *
 * Sets frame.origin.y = top
 */
@property (nonatomic) CGFloat top;

/**
 * Shortcut for frame.origin.x + frame.size.width
 *
 * Sets frame.origin.x = right - frame.size.width
 */
@property (nonatomic) CGFloat right;

/**
 * Shortcut for frame.origin.y + frame.size.height
 *
 * Sets frame.origin.y = bottom - frame.size.height
 */
@property (nonatomic) CGFloat bottom;

/**
 * Shortcut for frame.size.width
 *
 * Sets frame.size.width = width
 */
@property (nonatomic) CGFloat width;

/**
 * Shortcut for frame.size.height
 *
 * Sets frame.size.height = height
 */
@property (nonatomic) CGFloat height;

/**
 * Shortcut for center.x
 *
 * Sets center.x = centerX
 */
@property (nonatomic) CGFloat centerX;

/**
 * Shortcut for center.y
 *
 * Sets center.y = centerY
 */
@property (nonatomic) CGFloat centerY;

@end
