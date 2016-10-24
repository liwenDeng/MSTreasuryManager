//
//  MSLiveWorkHeaderView.m
//  MSTreasuryManager
//
//  Created by 邓利文 on 2016/10/24.
//  Copyright © 2016年 邓利文. All rights reserved.
//

#import "MSLiveWorkHeaderView.h"

@interface MSLiveWorkHeaderView ()


@end

@implementation MSLiveWorkHeaderView

- (instancetype)initWithReuseIdentifier:(NSString *)reuseIdentifier {
    if (self = [super initWithReuseIdentifier:reuseIdentifier]) {
        [self setupSubviews];
    }
    return self;
}

- (void)setupSubviews {

    self.contentView.backgroundColor = [UIColor whiteColor];
    UIView *sperateView = ({
        UIView *view = [[UIView alloc]init];
        [self.contentView addSubview:view];
        
        view.backgroundColor = kBackgroundColor;
        [view mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.top.with.mas_equalTo(self.contentView);
            make.height.mas_equalTo(20);
        }];
        
        view;
    });
    
    _titleLabel = ({
        UILabel *label = [[UILabel alloc]init];
        [self.contentView addSubview:label];
        label.text = @"工作负责人";
        [label sizeToFit];
        [label mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(15);
            make.top.equalTo(sperateView.mas_bottom).offset(0);
            make.bottom.equalTo(self.contentView.mas_bottom);
        }];
                
        label;
    });
}

@end
