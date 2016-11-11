//
//  MSMaterialRightHandleSection.h
//  MSTreasuryManager
//
//  Created by apple on 16/11/11.
//  Copyright © 2016年 邓利文. All rights reserved.
//

#import <UIKit/UIKit.h>
/**
 右侧带有按钮的section
 */
@interface MSMaterialRightHandleSection : UIView

@property (nonatomic, strong) UITextField * textField;
@property (nonatomic, strong) UIButton *actionBtn;  //用来响应点击事件
@property (nonatomic, strong) UILabel *titleLabel;

- (instancetype)initWithTitle:(NSString *)title placeholder:(NSString *)placeholder;

@end
