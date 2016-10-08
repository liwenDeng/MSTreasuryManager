//
//  NSString+Code.m
//  MyTemplateProject
//
//  Created by dengliwen on 16/7/6.
//  Copyright © 2016年 dengliwen. All rights reserved.
//

#import "NSString+Code.h"
#import <CommonCrypto/CommonDigest.h>
#import <zlib.h>

@implementation NSString (Code)

#pragma mark - MD5
- (NSString*)ms_md5
{
    const char *cStr = [self UTF8String];
    unsigned char result[16];
    CC_MD5(cStr,(CC_LONG)strlen(cStr),result);
    NSString* md5str=[[NSString stringWithFormat:
                       @"%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X",
                       result[0], result[1], result[2], result[3],
                       result[4], result[5], result[6], result[7],
                       result[8], result[9], result[10], result[11],
                       result[12], result[13], result[14], result[15]] lowercaseString];
    
    return md5str;
}

- (NSString *)ms_stringFromMD5 {
    if(self == nil || [self length] == 0)
        return nil;
    
    const char *value = [self UTF8String];
    
    unsigned char outputBuffer[CC_MD5_DIGEST_LENGTH];
    CC_MD5(value, (CC_LONG)strlen(value), outputBuffer);
    
    NSMutableString *outputString = [[NSMutableString alloc] initWithCapacity:CC_MD5_DIGEST_LENGTH * 2];
    for(NSInteger count = 0; count < CC_MD5_DIGEST_LENGTH; count++){
        [outputString appendFormat:@"%02x",outputBuffer[count]];
    }
    return outputString;
}

#pragma mark - URLCode
- (NSString *)ms_urlEncode
{
    /** url编码 http://stackoverflow.com/questions/8086584/objective-c-url-encoding
     
     1. [self stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    
     2.NSString *result =[self stringByAddingPercentEncodingWithAllowedCharacters:[NSCharacterSet URLHostAllowedCharacterSet]];
     URLFragmentAllowedCharacterSet  "#%<>[\]^`{|}
     URLHostAllowedCharacterSet      "#%/<>?@\^`{|}
     URLPasswordAllowedCharacterSet  "#%/:<>?@[\]^`{|}
     URLPathAllowedCharacterSet      "#%;<>?[\]^`{|}
     URLQueryAllowedCharacterSet     "#%<>[\]^`{|}
     URLUserAllowedCharacterSet      "#%/:<>?@[\]^`
     */

    NSString *result = (NSString *)CFBridgingRelease(CFURLCreateStringByAddingPercentEscapes(kCFAllocatorDefault, (CFStringRef)self, NULL, CFSTR(":/?#[]@!$&’()*+,;="), kCFStringEncodingUTF8));
    return result;
}

- (NSString *)ms_urlDecode
{
    NSString *decodeString = [self stringByRemovingPercentEncoding];
    return decodeString;
}

@end
