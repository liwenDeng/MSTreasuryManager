//
//  MSHomeCollectionCell.m
//  MSTreasuryManager
//
//  Created by 邓利文 on 2016/10/8.
//  Copyright © 2016年 邓利文. All rights reserved.
//

#import "MSHomeCollectionCell.h"

@interface MSHomeCollectionCell ()

@property (nonatomic, strong) UILabel *titleLabel;

@end

@implementation MSHomeCollectionCell

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        [self setupSubViews];
    }
    return self;
}

- (void)setupSubViews {
    _titleLabel = ({
        UILabel *label = [[UILabel alloc]init];
        [self.contentView addSubview:label];
        
        [label mas_makeConstraints:^(MASConstraintMaker *make) {
            make.center.equalTo(self.contentView);
            make.width.lessThanOrEqualTo(self.contentView);
        }];
        label;
    });
    self.contentView.backgroundColor = [UIColor ms_colorWithHexString:@"50E3C2"];
    self.contentView.layer.cornerRadius = 10.0f;
}

- (void)fillWithTitle:(NSString *)title {
    self.titleLabel.text = title;
}

@end
