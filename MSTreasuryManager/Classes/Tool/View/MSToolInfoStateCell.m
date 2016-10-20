//
//  MSToolInfoStateCell.m
//  MSTreasuryManager
//
//  Created by 邓利文 on 2016/10/20.
//  Copyright © 2016年 邓利文. All rights reserved.
//

#import "MSToolInfoStateCell.h"

@interface MSToolInfoStateCell ()

@property (nonatomic, strong) UILabel *titleLabel;
@property (nonatomic, strong) UILabel *stateLabel;

@end

@implementation MSToolInfoStateCell

- (void)setupSubviews {
    _titleLabel = ({
        UILabel *label = [[UILabel alloc]init];
        [self.contentView addSubview:label];
        label;
    });
    
    _stateLabel = ({
        UILabel *label = [[UILabel alloc]init];
        [self.contentView addSubview:label];
        label;
    });
    
    _stateLabel.text = @"在库";
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

@end
