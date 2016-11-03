//
//  NSString+Util.h
//  MyTemplateProject
//
//  Created by dengliwen on 16/7/6.
//  Copyright © 2016年 dengliwen. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface NSString (Util)

/**
 *  是否包含某字符串
 */
- (BOOL)ms_containsString:(NSString *)string;

/*!
 *  计算字符串所占大小的快捷方法，此处不换行，只计算一行字符串大小
 */
- (CGSize)ms_stringSizeWithFont:(UIFont *)font;

/**
 *  计算字符串所占大小的快捷方法
 * @param font 使用的字体
 * @param size 限制字符串的大小范围，宽度和高度
 @ @param lineBreakMode 超过一行时的换行模式
 */
- (CGSize)ms_sizeWithFont:(UIFont *)font
           constrainedToSize:(CGSize)size
               lineBreakMode:(NSLineBreakMode)lineBreakMode;

/**
 *  类似新浪计算文字长度，中文状态下每个汉字和字符都算一个字，英文状态下字母和字符都算半个字
 */
- (NSInteger)ms_textLength:(NSString *)dataString;

/**
 *  Trim掉字符串的前后空白
 */
- (NSString *)ms_stringByTrimmingWhiteSpace;

/**
 *  是否包含中文
 */
- (BOOL)ms_containsChinese;

/**
 *  是否全是数字
 */
- (BOOL)ms_isAllNum;

#pragma mark - Class Method
/**
 *  是否包含中文
 */
+ (BOOL)ms_containsChineseInString:(NSString *)string;

/**
 *  是否全是数字
 */
+ (BOOL)ms_isAllNum:(NSString *)string;

@end
