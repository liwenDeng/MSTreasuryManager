//
//  MSClassHeaderView.m
//  MSTreasuryManager
//
//  Created by 邓利文 on 2017/2/14.
//  Copyright © 2017年 邓利文. All rights reserved.
//

#import "MSClassHeaderView.h"

@interface MSClassHeaderView ()

@property (nonatomic, strong) UIImageView *bgImageView;
@property (nonatomic, strong) UILabel *wordLabel;   //口号

@end

@implementation MSClassHeaderView

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
    
    _wordLabel = ({
        UILabel *label = [[UILabel alloc]init];
        [self addSubview:label];
        label.numberOfLines = 0;
        label.font = [UIFont systemFontOfSize:13];
        label.textColor = [UIColor whiteColor];
        label.shadowColor = [UIColor grayColor];
        [label mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerX.equalTo(self);
            make.bottom.equalTo(self.mas_bottom).offset(-20);
            make.width.mas_equalTo(kSCREEN_WIDTH - 40);
        }];
        
        label;
    });
    
    UILabel *title = ({
        UILabel *label = [[UILabel alloc]init];
        [self addSubview:label];
        label.font = [UIFont systemFontOfSize:13];
        label.textColor = [UIColor whiteColor];
        label.shadowColor = [UIColor grayColor];
        label.text = @"班组口号";
        [label sizeToFit];
        [label mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerX.equalTo(self);
            make.bottom.equalTo(_wordLabel.mas_top).offset(-5);
        }];
        
        label;
    });
}

- (void)fillWithClassModel:(MSClassModel *)classModel {
    self.wordLabel.text = classModel.catchWord;
    [self.bgImageView sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@%@",KImageUrl,classModel.logo]] placeholderImage:[UIImage imageNamed:@"1.jpg"]];

}

@end
