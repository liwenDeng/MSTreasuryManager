//
//  MSOutInInfoCell.m
//  MSTreasuryManager
//
//  Created by 邓利文 on 2016/10/14.
//  Copyright © 2016年 邓利文. All rights reserved.
//

#import "MSOutInInfoCell.h"

@interface MSOutInInfoCell ()

@property (nonatomic, strong) UILabel *productLabel;
@property (nonatomic, strong) UILabel *dateLabel;
@property (nonatomic, strong) UILabel *userLabel;

@end

@implementation MSOutInInfoCell

- (void)setupSubviews {
    [self setAccessoryType:(UITableViewCellAccessoryDisclosureIndicator)];
    _productLabel = ({
        UILabel *label = [[UILabel alloc]init];
        [self.contentView addSubview:label];
        label.numberOfLines = 0;
        label.font = [UIFont systemFontOfSize:13];
        label;
    });
    
    _dateLabel = ({
        UILabel *label = [[UILabel alloc]init];
        [self.contentView addSubview:label];
        label.font = [UIFont systemFontOfSize:13];
        label;
    });
    
    _userLabel = ({
        UILabel *label = [[UILabel alloc]init];
        [self.contentView addSubview:label];
        label.font = [UIFont systemFontOfSize:13];
        [label setTextAlignment:(NSTextAlignmentCenter)];
        label;
    });
    
    [_productLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(10);
        make.top.equalTo(self.contentView).offset(5);
        make.width.mas_lessThanOrEqualTo(kSCREEN_WIDTH/2 - 20);
        make.bottom.equalTo(self.contentView.mas_bottom).offset(-5);
    }];
    
    _dateLabel.text = @"2016-09-11";
    [_dateLabel sizeToFit];
    [_dateLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(_productLabel.mas_right).offset(20);
        make.centerY.equalTo(_productLabel);
    }];
    
    [_userLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self.contentView.mas_right).offset(0);
        make.centerY.equalTo(_productLabel);
        make.left.equalTo(_dateLabel.mas_right).offset(20);
    }];
    
    //test
    _productLabel.text = @"物资名称物资名称物资名物资名称物资名称物资物资名称物资名称物资名物资名称物资名称物资物资名称物资名称物资名物资名称物资名称物资";

    _userLabel.text = @"王能进进";
}

@end
