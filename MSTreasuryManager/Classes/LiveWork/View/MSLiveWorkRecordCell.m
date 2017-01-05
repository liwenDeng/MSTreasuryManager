//
//  MSLiveWorkRecordCell.m
//  MSTreasuryManager
//
//  Created by apple on 17/1/5.
//  Copyright © 2017年 邓利文. All rights reserved.
//

#import "MSLiveWorkRecordCell.h"

@interface MSLiveWorkRecordCell ()

@property (nonatomic, strong) UILabel *userNameLabel;
@property (nonatomic, strong) UILabel *timeLabel;
@property (nonatomic, strong) UILabel *contextLabel;    //工作内容

@end

@implementation MSLiveWorkRecordCell

- (void)setupSubviews {
    [super setupSubviews];

    UIView *bgView = ({
        UIView *view = [[UIView alloc]init];
        [self.contentView addSubview:view];
        view.backgroundColor = [UIColor whiteColor];
        [view mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.left.width.equalTo(self.contentView);
            make.bottom.equalTo(self.contentView.mas_bottom).offset(-10);
        }];
        view;
    });
    
    self.contentView.backgroundColor = [UIColor clearColor];
    self.backgroundColor = [UIColor clearColor];
    
    _userNameLabel = ({
        UILabel *label = [[UILabel alloc]init];
        [bgView addSubview:label];
        [label mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(10);
            make.left.mas_equalTo(12);
        }];
        
        label;
    });
    
    _timeLabel = ({
        UILabel *label = [[UILabel alloc]init];
        label.font = [UIFont systemFontOfSize:12.0f];
        [bgView addSubview:label];
        [label mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerY.equalTo(_userNameLabel);
            make.right.equalTo(bgView.mas_right).offset(-12);
        }];
        
        label;
    });
    
    _contextLabel = ({
        UILabel *label = [[UILabel alloc]init];
        [bgView addSubview:label];
        label.numberOfLines = 0;
        [label mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(_userNameLabel.mas_bottom).offset(5);
            make.left.equalTo(_userNameLabel);
            make.right.equalTo(_timeLabel);
            make.bottom.equalTo(bgView.mas_bottom).offset(-10);
        }];
        
        label;
    });

}

- (void)setLiveWorkModel:(MSLiveWorkModel *)liveWorkModel {
    _liveWorkModel = liveWorkModel;
    self.userNameLabel.text = liveWorkModel.chargePerson;
    self.timeLabel.text = liveWorkModel.workTime;
    self.contextLabel.text = liveWorkModel.context;
}

@end
