//
//  MSToolSectionHeaderView.m
//  MSTreasuryManager
//
//  Created by 邓利文 on 2016/10/20.
//  Copyright © 2016年 邓利文. All rights reserved.
//

#import "MSToolSectionHeaderView.h"

@interface MSToolSectionHeaderView ()

@property (nonatomic, strong) UILabel *titleLabel;
@property (nonatomic, strong) UILabel *stateLabel;

@end

@implementation MSToolSectionHeaderView

- (instancetype)initWithTitle:(NSString *)title subTitle:(NSString *)subtitle {
    if (self = [super init]) {
        _titleLabel = ({
            UILabel *label = [[UILabel alloc]init];
            [self addSubview:label];
            label.textColor = [UIColor whiteColor];
            label;
        });
        
        _stateLabel = ({
            UILabel *label = [[UILabel alloc]init];
            [self addSubview:label];
            label.textColor = [UIColor whiteColor];
            label;
        });
        
        _titleLabel.text = title;
        [_titleLabel sizeToFit];
        
        _stateLabel.text = subtitle;
        [_stateLabel sizeToFit];
        
        [_titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerY.equalTo(self);
            make.left.mas_equalTo(40);
        }];
        
        [_stateLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.mas_equalTo(-40);
            make.centerY.equalTo(self);
        }];
        
        self.backgroundColor = kTitleColor;
        
    }
    return self;
}

@end
