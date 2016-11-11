//
//  NSString+Code.h
//  MyTemplateProject
//
//  Created by dengliwen on 16/7/6.
//  Copyright © 2016年 dengliwen. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSString (Code)

- (NSString *)ms_md5;
- (NSString *)ms_stringFromMD5;

/**
 *  url编码 注意 
 *  只需要对params部分进行编码,而不是整个url
 */
- (NSString *)ms_urlEncode;
- (NSString *)ms_urlDecode;

//将十六进制的字符串转换成NSString则可使用如下方式:
- (NSString *)ms_convertHexStrToString;

- (NSString *)ms_convertStringToHexStr;

@end
