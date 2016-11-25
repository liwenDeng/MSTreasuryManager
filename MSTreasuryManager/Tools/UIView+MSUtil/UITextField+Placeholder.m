//
//  UITextField+Placeholder.m
//  MSTreasuryManager
//
//  Created by 邓利文 on 2016/11/25.
//  Copyright © 2016年 邓利文. All rights reserved.
//

#import "UITextField+Placeholder.h"

@implementation UITextField (Placeholder)

- (void)ms_setPlaceholderColor:(UIColor *)color {
    [self setValue:color forKeyPath:@"_placeholderLabel.textColor"];
}

- (void)ms_setPlaceholderFont:(UIFont *)font {
    [self setValue:font forKeyPath:@"_placeholderLabel.font"];
}

@end
