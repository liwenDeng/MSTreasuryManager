//
//  MSHomePersonCell.m
//  MSTreasuryManager
//
//  Created by apple on 17/1/6.
//  Copyright © 2017年 邓利文. All rights reserved.
//

#import "MSHomePersonCell.h"

@interface MSHomePersonCell ()

@property (nonatomic, strong) UIImageView *headIcon;
@property (nonatomic, strong) UIImageView *genderIcon;
@property (nonatomic, strong) UILabel *nameLabel;
@property (nonatomic, strong) UILabel *classNameLabel;

@end

@implementation MSHomePersonCell

- (void)setupSubviews {
    _headIcon = ({
        UIImageView *view = [[UIImageView alloc]init];
        [self.contentView addSubview:view];
        [view mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerX.equalTo(self.contentView);
            make.top.mas_equalTo(10);
            make.size.mas_equalTo(CGSizeMake(kMSPersonCellWidth - 30, kMSPersonCellWidth - 30));
        }];
        view;
    });
    
    _nameLabel = ({
        UILabel *label = [[UILabel alloc]init];
        [self.contentView addSubview:label];
        [label mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(_headIcon);
            make.top.equalTo(_headIcon.mas_bottom).offset(10);
        }];
        
        label;
    });
    
    _genderIcon = ({
        UIImageView *view = [[UIImageView alloc]init];
        [self.contentView addSubview:view];
        [view mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerY.equalTo(_nameLabel);
            make.left.equalTo(_nameLabel.mas_right).offset(10);
            make.size.mas_equalTo(CGSizeMake(30, 20));
        }];
        view;
    });
    
    _classNameLabel = ({
        UILabel *label = [[UILabel alloc]init];
        [self.contentView addSubview:label];
        [label mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(_headIcon);
            make.top.equalTo(_nameLabel.mas_bottom).offset(10);
        }];
        
        label;
    });
    
    [self testData];
}

- (void)testData {
    _headIcon.image = [UIImage imageNamed:@"head"];
    _nameLabel.text = @"王能进";
    _genderIcon.backgroundColor = [UIColor redColor];
    _classNameLabel.text = @"保护班";
}

@end
