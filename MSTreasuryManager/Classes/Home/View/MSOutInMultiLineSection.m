//
//  MSOutInMultiLineSection.m
//  MSTreasuryManager
//
//  Created by 邓利文 on 2016/10/14.
//  Copyright © 2016年 邓利文. All rights reserved.
//

#import "MSOutInMultiLineSection.h"

@interface MSOutInMultiLineSection ()

@property (nonatomic, strong) NSString *title;

@end

@implementation MSOutInMultiLineSection

- (instancetype)initWithTitle:(NSString *)title{
    if (self = [super init]) {
        _title = title;
        self.backgroundColor = [UIColor whiteColor];
        [self setupSubviews];
    }
    return self;
}

- (void)setupSubviews {
    
    UILabel *titleLabel1 = ({
        UILabel *label = [[UILabel alloc]init];
        [self addSubview:label];
        label.text = _title;
        [label sizeToFit];
        
        label;
    });
    
    UIView *line1 = ({
        UIView *view = [[UIView alloc]init];
        [self addSubview:view];
        view.backgroundColor = kBackgroundColor;
        view;
    });
    
    UILabel *input1 = ({
        UILabel *view = [[UILabel alloc]init];
        [self addSubview:view];
        view.font = [UIFont systemFontOfSize:14.0f];
        view.numberOfLines = 0;
        
        view;
    });
    self.subLabel = input1;
    
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
        make.right.equalTo(self.mas_right).offset(-20);
        make.top.equalTo(line1.mas_bottom).offset(8);
    }];
    
    [self mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(input1.mas_bottom).offset(8);
    }];
}

@end
