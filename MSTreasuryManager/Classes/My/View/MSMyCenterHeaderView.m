//
//  MSMyCenterHeaderView.m
//  MSTreasuryManager
//
//  Created by 邓利文 on 2016/10/25.
//  Copyright © 2016年 邓利文. All rights reserved.
//

#import "MSMyCenterHeaderView.h"
#import "UIImageView+CornerRadius.h"

static const CGFloat kHeadIconWidth = 50;
@interface MSMyCenterHeaderView ()

@property (nonatomic, strong) UIImageView *headIcon;
@property (nonatomic, strong) UILabel *nickLabel;

@end

@implementation MSMyCenterHeaderView

- (void)setupSubviews {
    _headIcon = ({
        UIImageView *view = [[UIImageView alloc]init];
        [self.contentView addSubview:view];
        
        [view mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(10);
            make.centerY.equalTo(self.contentView);
            make.size.mas_equalTo(CGSizeMake(kHeadIconWidth, kHeadIconWidth));
        }];
        [view zy_cornerRadiusRoundingRect];
        view.image = [UIImage imageNamed:@"head"];
        view;
    });
    
    _nickLabel = ({
        UILabel *label = [[UILabel alloc]init];
        [self.contentView addSubview:label];
        label.text = @"user";
        [label mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(_headIcon.mas_right).offset(20);
            make.centerY.equalTo(_headIcon);
            make.right.mas_lessThanOrEqualTo(self.contentView.mas_right).offset(-20);
        }];
        
        label;
    });
    
}

+ (CGFloat)cellHeight {
    return 80;
}


@end
