//
//  MSLiveWorkMeetingCell.m
//  MSTreasuryManager
//
//  Created by 邓利文 on 2016/10/24.
//  Copyright © 2016年 邓利文. All rights reserved.
//

#import "MSLiveWorkMeetingCell.h"

@interface MSLiveWorkMeetingCell ()

//@property (nonatomic, strong) UILabel *contentLabel;

@end

@implementation MSLiveWorkMeetingCell

- (void)setupSubviews {
    [super setupSubviews];
    [self setSelectionStyle:(UITableViewCellSelectionStyleNone)];
    _contentLabel = ({
        UILabel *label = [[UILabel alloc]init];
        label.numberOfLines = 0;
        [self.contentView addSubview:label];
        
        [label mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(15);
            make.top.equalTo(self.contentView).offset(8);
            make.right.equalTo(self.contentView.mas_right).offset(-15);
            make.bottom.equalTo(self.contentView.mas_bottom).offset(-8);
        }];
        
        label.layer.borderWidth = 1.0f;
        label.layer.borderColor = kBackgroundColor.CGColor;
        
        label;
    });
}

@end
