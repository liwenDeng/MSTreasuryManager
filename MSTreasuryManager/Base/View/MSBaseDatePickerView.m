//
//  MSBaseDatePickerView.m
//  MSTreasuryManager
//
//  Created by apple on 16/10/12.
//  Copyright © 2016年 邓利文. All rights reserved.
//

#import "MSBaseDatePickerView.h"

@interface MSBaseDatePickerView ()

@property (nonatomic, strong) UIDatePicker* datePicker;

@end

@implementation MSBaseDatePickerView

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        [self setupSubviews];
    }
    return self;
}

- (void)setupSubviews {

    UIDatePicker *datePicker = [[UIDatePicker alloc]init];
    [self addSubview:datePicker];
    [datePicker setLocale:[[NSLocale alloc]initWithLocaleIdentifier:@"zh_CN"]];
    // 设置时区
    [datePicker setTimeZone:[NSTimeZone localTimeZone]];
    
    datePicker.backgroundColor = kBackgroundColor;
    [datePicker setDatePickerMode:(UIDatePickerModeDateAndTime)];
    [datePicker mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self);
    }];
    self.datePicker = datePicker;
    
    UIButton *cancleBtn = [UIButton buttonWithType:(UIButtonTypeSystem)];
    [cancleBtn setTitle:@"取 消" forState:(UIControlStateNormal)];
    [self addSubview:cancleBtn];
    [cancleBtn sizeToFit];
    
    UIButton *submitBtn = [UIButton buttonWithType:(UIButtonTypeSystem)];
    [submitBtn setTitle:@"确 认" forState:(UIControlStateNormal)];
    [self addSubview:submitBtn];
    [submitBtn sizeToFit];
    
    [cancleBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self);
        make.left.mas_equalTo(15);
    }];
    
    [submitBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self.mas_right).offset(-15);
        make.top.equalTo(self);
    }];
    
    [cancleBtn addTarget:self action:@selector(cancleBtnClicked:) forControlEvents:(UIControlEventTouchUpInside)];
    
    [submitBtn addTarget:self action:@selector(submitBtnClicked:) forControlEvents:(UIControlEventTouchUpInside)];
}

- (void)cancleBtnClicked:(UIButton *)sender {
    if ([self.delegate respondsToSelector:@selector(datePickerView:cancleWithDate:)]) {
        [self.delegate datePickerView:self cancleWithDate:self.datePicker.date];
    }
}

- (void)submitBtnClicked:(UIButton*)sender {
    if ([self.delegate respondsToSelector:@selector(datePickerView:submitWithDate:)]) {
        [self.delegate datePickerView:self submitWithDate:self.datePicker.date];
    }
}

@end
