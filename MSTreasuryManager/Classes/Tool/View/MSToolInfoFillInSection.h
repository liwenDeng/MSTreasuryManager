//
//  MSToolInfoFillInSection.h
//  MSTreasuryManager
//
//  Created by 邓利文 on 2016/10/14.
//  Copyright © 2016年 邓利文. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "YZInputView.h"

@interface MSToolInfoFillInSection : UIView

@property (nonatomic, strong) YZInputView *fillInView;

- (instancetype)initWithTitle:(NSString *)title placeholder:(NSString *)placeholder;

@end
