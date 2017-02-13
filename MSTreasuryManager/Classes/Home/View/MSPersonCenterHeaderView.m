//
//  MSPersonCenterHeaderView.m
//  MSTreasuryManager
//
//  Created by apple on 17/1/14.
//  Copyright © 2017年 邓利文. All rights reserved.
//

#import "MSPersonCenterHeaderView.h"

@interface MSPersonCenterHeaderView ()

@property (nonatomic, strong) UIImageView *headIcon;
@property (nonatomic, strong) UIImageView *bgImageView;
@property (nonatomic, strong) UILabel *nameLabel;
@property (nonatomic, strong) UIImageView *genderView;

@end

@implementation MSPersonCenterHeaderView

- (void)setupSubviews {
    [super setupSubviews];
    self.backgroundColor = [UIColor whiteColor];
    _bgImageView =  ({
        UIImageView *view = [[UIImageView alloc]init];
        [self addSubview:view];
        view.clipsToBounds = YES;
        [view setContentMode:(UIViewContentModeScaleAspectFill)];
        [view mas_makeConstraints:^(MASConstraintMaker *make) {
            make.edges.equalTo(self);
        }];
        view;
    });
    
    UIBlurEffect *effect = [UIBlurEffect effectWithStyle:(UIBlurEffectStyleLight)];
    UIVisualEffectView *blurView = [[UIVisualEffectView alloc]initWithEffect:effect];
    blurView.alpha = 0.8;
    [_bgImageView addSubview:blurView];
    [blurView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self);
    }];
    
    _nameLabel = ({
        UILabel *label = [[UILabel alloc]init];
        [self addSubview:label];
        [label mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerX.equalTo(self);
            make.bottom.equalTo(self.mas_bottom).offset(-20);
        }];
        
        label;
    });
    
    _genderView =  ({
        UIImageView *view = [[UIImageView alloc]init];
        [self addSubview:view];
        [view mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerY.equalTo(_nameLabel);
            make.left.equalTo(_nameLabel.mas_right).offset(5);
            make.size.mas_equalTo(CGSizeMake(15, 15));
        }];
        view;
    });
    
    _headIcon = ({
        UIImageView *view = [[UIImageView alloc]init];
        [self addSubview:view];
        [view setContentMode:(UIViewContentModeScaleAspectFill)];
        [view mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerX.equalTo(self);
            make.size.mas_equalTo(CGSizeMake(60, 60));
            make.bottom.equalTo(_nameLabel.mas_top).offset(-15);
        }];
        view.layer.cornerRadius = 30;
        view.clipsToBounds = YES;
        view;
    });
    
}

- (void)fillWithPerson:(MSPersonModel *)person {
    self.nameLabel.text = person.name;
    [self.bgImageView sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@%@",KImageUrl,person.img]] placeholderImage:[UIImage imageNamed:@"1.jpg"]];
    [self.headIcon sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@%@",KImageUrl,person.img]] placeholderImage:[UIImage imageNamed:@"1.jpg"]];
    
    if (person.gender == MSGenderMale) {
        self.genderView.image = [UIImage imageNamed:@"male"];
    }else {
        self.genderView.image = [UIImage imageNamed:@"female"];
    }
}

@end
