//
//  MSMaterialFillInNomalSection.h
//  MSTreasuryManager
//
//  Created by 邓利文 on 2016/10/8.
//  Copyright © 2016年 邓利文. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MSMaterialFillInNomalSection : UIView

@property (nonatomic, strong) UITextField * textField;
@property (nonatomic, strong) UIButton *actionBtn;  //用来响应点击事件

- (instancetype)initWithTitle:(NSString *)title placeholder:(NSString *)placeholder;

@end
