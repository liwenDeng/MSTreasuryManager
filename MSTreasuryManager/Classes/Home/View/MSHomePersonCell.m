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
    self.layer.borderColor = [UIColor grayColor].CGColor;
    self.layer.borderWidth = 0.5;
    self.contentView.backgroundColor = [UIColor whiteColor];
    _headIcon = ({
        UIImageView *view = [[UIImageView alloc]init];
        [self.contentView addSubview:view];
        [view mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerX.equalTo(self.contentView);
            make.top.mas_equalTo(10);
            make.size.mas_equalTo(CGSizeMake(kMSPersonCellWidth - 50, kMSPersonCellWidth - 50));
        }];
        view.layer.cornerRadius = (kMSPersonCellWidth - 50)/2.0;
        
        view;
    });
    
    _nameLabel = ({
        UILabel *label = [[UILabel alloc]init];
        [self.contentView addSubview:label];
        label.font = [UIFont systemFontOfSize:12];
        [label mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(10);
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
            make.size.mas_equalTo(CGSizeMake(15, 15));
        }];
        view;
    });
    
    _classNameLabel = ({
        UILabel *label = [[UILabel alloc]init];
        [self.contentView addSubview:label];
        label.font = [UIFont systemFontOfSize:12];
        label.textColor = [UIColor grayColor];
        [label mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(_nameLabel);
            make.top.equalTo(_nameLabel.mas_bottom).offset(5);
        }];
        
        label;
    });
    
//    [self testData];
}

- (void)testData {
    _headIcon.backgroundColor = [UIColor redColor];
    _nameLabel.text = @"王能进";
    _genderIcon.image = [UIImage imageNamed:@"male"];
    _classNameLabel.text = @"保护班";
}

- (void)fillWithPerson:(MSPersonModel *)personModel {
    [_headIcon sd_setImageWithURL:[NSURL URLWithString:personModel.img] placeholderImage:[UIImage imageNamed:@"album"]];
    _nameLabel.text = personModel.name;
    _classNameLabel.text = personModel.team;
    if (personModel.gender == MSGenderMale) {
        self.genderIcon.image = [UIImage imageNamed:@"male"];
    }else {
        self.genderIcon.image = [UIImage imageNamed:@"female"];
    }
}

@end
