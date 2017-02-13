//
//  MSPersonCenterCell.m
//  MSTreasuryManager
//
//  Created by apple on 17/1/19.
//  Copyright © 2017年 邓利文. All rights reserved.
//

#import "MSPersonCenterCell.h"

@interface MSPersonCenterCell ()

@property (nonatomic, strong) UILabel *titleLabel;
@property (nonatomic, strong) UILabel *valueLabel;

@end

@implementation MSPersonCenterCell

- (void)setupSubviews {
    [self setSelectionStyle:(UITableViewCellSelectionStyleNone)];
    _titleLabel = ({
        UILabel *labe = [[UILabel alloc]init];
        [self.contentView addSubview:labe];
        labe.textColor = [UIColor grayColor];
        [labe mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerY.equalTo(self.contentView);
            make.left.mas_equalTo(15);
        }];
        labe;
    });
    
    _valueLabel = ({
        UILabel *labe = [[UILabel alloc]init];
        [self.contentView addSubview:labe];
        [labe mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerY.equalTo(self.contentView);
            make.left.mas_equalTo(kSCREEN_WIDTH / 4);
        }];
        labe;
    });
}

- (void)fillWithTitle:(NSString *)title value:(NSString *)value {
    self.titleLabel.text = title;
    self.valueLabel.text = value;
}

@end
