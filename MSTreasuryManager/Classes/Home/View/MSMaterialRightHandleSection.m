//
//  MSMaterialRightHandleSection.m
//  MSTreasuryManager
//
//  Created by apple on 16/11/11.
//  Copyright © 2016年 邓利文. All rights reserved.
//

#import "MSMaterialRightHandleSection.h"

@implementation MSMaterialRightHandleSection

- (instancetype)initWithTitle:(NSString *)title placeholder:(NSString *)placeholder {
    if (self = [super init]) {
        
        self.backgroundColor = [UIColor whiteColor];
        UIView *line = ({
            UIView *view = [[UIView alloc]init];
            [self addSubview:view];
            view.backgroundColor = kBackgroundColor;
            view;
        });
        
        UILabel *titleLabel = ({
            UILabel *label = [[UILabel alloc]init];
            label.text = title;
            [self addSubview:label];
            label;
        });
        self.titleLabel = titleLabel;
        
        self.textField = ({
            UITextField *textField = [[UITextField alloc]init];
            [self addSubview:textField];
            [textField setPlaceholder:placeholder];
            [textField setTextAlignment:(NSTextAlignmentCenter)];
            [textField setKeyboardType:(UIKeyboardTypeNumberPad)];
            textField.layer.borderWidth = 1;
            textField.layer.borderColor = kBackgroundColor.CGColor;
            textField.layer.cornerRadius = 5;
            textField;
        });
        
        self.actionBtn = ({
            UIButton *btn = [UIButton buttonWithType:(UIButtonTypeCustom)];
            [self addSubview:btn];

            [btn setImage:[UIImage imageNamed:@"out"] forState:(UIControlStateNormal)];
            [btn mas_makeConstraints:^(MASConstraintMaker *make) {
                make.right.equalTo(self.mas_right).offset(-20);
                make.centerY.equalTo(self);
                make.size.mas_equalTo(CGSizeMake(20, 20));
            }];
            
            btn;
        });
        
        [line mas_makeConstraints:^(MASConstraintMaker *make) {
            make.height.mas_equalTo(1);
            make.left.width.equalTo(self);
            make.bottom.equalTo(self);
        }];
        
        [titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(15);
            make.centerY.equalTo(self);
            make.width.mas_lessThanOrEqualTo(kSCREEN_WIDTH / 4);
        }];
        
        [self.textField mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(kSCREEN_WIDTH / 4 + 25);
            make.right.mas_equalTo(self.actionBtn.mas_left).offset(-15);
            make.centerY.equalTo(self);
            make.height.mas_equalTo(44 * 0.7);
        }];
        
    }
    return self;
}

@end
