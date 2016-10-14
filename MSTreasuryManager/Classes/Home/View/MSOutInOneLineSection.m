//
//  MSOutInOneLineSection.m
//  MSTreasuryManager
//
//  Created by 邓利文 on 2016/10/14.
//  Copyright © 2016年 邓利文. All rights reserved.
//

#import "MSOutInOneLineSection.h"

@interface MSOutInOneLineSection ()

@property (nonatomic, strong) NSString *title;

@end

@implementation MSOutInOneLineSection

- (instancetype)initWithTitle:(NSString *)title {
    if (self = [super init]) {
        self.backgroundColor = [UIColor whiteColor];
        _title = title;
        [self setupSubviews];
    }
    return self;
}

- (void)setupSubviews {
    UIView *line = ({
        UIView *view = [[UIView alloc]init];
        [self addSubview:view];
        view.backgroundColor = kBackgroundColor;
        view;
    });
    
    UILabel *titleLabel = ({
        UILabel *label = [[UILabel alloc]init];
        label.text = _title;
        [self addSubview:label];
        
        label;
    });
    
    self.subLabel = ({
        UILabel *label = [[UILabel alloc]init];
        [self addSubview:label];
        [label setTextAlignment:(NSTextAlignmentCenter)];
        label;
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
    
    [self.subLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(kSCREEN_WIDTH / 4 + 5);
        make.right.mas_equalTo(self.mas_right).offset(-15);
        make.centerY.equalTo(self);
        make.height.mas_equalTo(44 * 0.7);
    }];

}

@end
