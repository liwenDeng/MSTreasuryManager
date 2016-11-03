//
//  MSDialog.m
//  MSTreasuryManager
//
//  Created by 邓利文 on 2016/11/1.
//  Copyright © 2016年 邓利文. All rights reserved.
//

#import "MSDialog.h"

@implementation MSDialog

+ (void)showAlert:(NSString *)alert {
    UIAlertView *alertView = [[UIAlertView alloc]initWithTitle:alert message:nil delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil];
    [alertView show];
}

@end
