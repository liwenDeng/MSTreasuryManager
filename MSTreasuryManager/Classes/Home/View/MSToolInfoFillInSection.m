//
//  MSToolInfoFillInSection.m
//  MSTreasuryManager
//
//  Created by 邓利文 on 2016/10/14.
//  Copyright © 2016年 邓利文. All rights reserved.
//

#import "MSToolInfoFillInSection.h"

@interface MSToolInfoFillInSection ()

@property (nonatomic, strong) NSString *title;
@property (nonatomic, strong) NSString *placeholder;

@end

@implementation MSToolInfoFillInSection

- (instancetype)initWithTitle:(NSString *)title placeholder:(NSString *)placeholder {
    if (self = [super init]) {
        self.backgroundColor = [UIColor whiteColor];
        _title = title;
        _placeholder = placeholder;
        [self setupSubviews];
    }
    return self;
}

- (void)setupSubviews {
    
    UILabel *titleLabel1 = ({
        UILabel *label = [[UILabel alloc]init];
        [self addSubview:label];
        label.text = self.title;
        [label sizeToFit];
        
        label;
    });
    
    UIView *line1 = ({
        UIView *view = [[UIView alloc]init];
        [self addSubview:view];
        view.backgroundColor = kBackgroundColor;
        view;
    });
    
    YZInputView *input1 = ({
        YZInputView *view = [[YZInputView alloc]init];
        [self addSubview:view];
        view.placeholder = self.placeholder;
        view.font = [UIFont systemFontOfSize:14.0f];
        view.maxNumberOfLines = 20;
        
        view;
    });
    self.fillInView = input1;
    
    [titleLabel1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self).offset(15);
        make.top.mas_equalTo(0);
        make.height.mas_equalTo(40);
        make.width.mas_lessThanOrEqualTo(kSCREEN_WIDTH);
    }];
    
    [line1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.mas_equalTo(kSCREEN_WIDTH);
        make.top.equalTo(titleLabel1.mas_bottom).offset(0);
        make.left.mas_equalTo(15);
        make.height.mas_equalTo(1);
    }];
    
    [input1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(titleLabel1);
        make.right.equalTo(self).offset(-20);
        make.top.equalTo(line1.mas_bottom).offset(8);
    }];
    
    [self mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(input1.mas_bottom).offset(8);
    }];
    
    __weak typeof(YZInputView) *weakInput = input1;
    input1.yz_textHeightChangeBlock =  ^(NSString *text,CGFloat textHeight){
        [weakInput mas_updateConstraints:^(MASConstraintMaker *make) {
            make.height.mas_equalTo(textHeight);
        }];
    };
}

@end
