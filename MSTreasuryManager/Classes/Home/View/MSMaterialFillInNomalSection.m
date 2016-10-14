//
//  MSMaterialFillInNomalSection.m
//  MSTreasuryManager
//
//  Created by 邓利文 on 2016/10/8.
//  Copyright © 2016年 邓利文. All rights reserved.
//

#import "MSMaterialFillInNomalSection.h"

@implementation MSMaterialFillInNomalSection

- (instancetype)initWithTitle:(NSString *)title placeholder:(NSString *)placeholder {
    return [self initWithTitle:title placeholder:placeholder canTouch:NO];
}

- (instancetype)initWithTitle:(NSString *)title placeholder:(NSString *)placeholder canTouch:(BOOL)canTouch {
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
            label.font = [UIFont systemFontOfSize:13.0f];
            label;
        });
        
        self.textField = ({
            UITextField *textField = [[UITextField alloc]init];
            [self addSubview:textField];
            [textField setPlaceholder:placeholder];
            [textField setTextAlignment:(NSTextAlignmentCenter)];
            [textField setKeyboardType:(UIKeyboardTypePhonePad)];
            [textField setBorderStyle:(UITextBorderStyleRoundedRect)];
            textField;
        });
        
        self.actionBtn = ({
            UIButton *btn = [UIButton buttonWithType:(UIButtonTypeSystem)];
            [self addSubview:btn];
            
            [btn mas_makeConstraints:^(MASConstraintMaker *make) {
                make.edges.equalTo(self.textField);
            }];
            
            btn;
        });
        
        if (!canTouch) {
            self.actionBtn.hidden = YES;
        }
        
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
            make.right.mas_equalTo(self.mas_right).offset(-15);
            make.centerY.equalTo(self);
            make.height.mas_equalTo(44 * 0.7);
        }];
        
    }
    return self;
}

@end
