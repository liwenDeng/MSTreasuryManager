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
@property (nonatomic, strong) UIButton *tap;

@end

@implementation MSPersonCenterCell

- (void)setupSubviews {
    [self setSelectionStyle:(UITableViewCellSelectionStyleNone)];
    self.userInteractionEnabled = YES;
    self.contentView.userInteractionEnabled = YES;
    
    
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
    
    UIButton *tapButton = [UIButton buttonWithType:(UIButtonTypeSystem)];
    [self.contentView addSubview:tapButton];
    [tapButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.center.equalTo(_valueLabel);
        make.size.equalTo(_valueLabel);
    }];
    [tapButton addTarget:self action:@selector(callPhone:) forControlEvents:(UIControlEventTouchUpInside)];
    self.tap = tapButton;
}

- (void)fillWithTitle:(NSString *)title value:(NSString *)value {
    self.titleLabel.text = title;
    self.valueLabel.text = value;
    if ([title isEqualToString:@"电  话"]) {
        self.valueLabel.textColor = [UIColor ms_colorWithHexString:@"#2c83fc"];
        self.tap.enabled = YES;
    }else {
        self.tap.enabled = NO;
        self.valueLabel.textColor = [UIColor blackColor];
    }
}

- (void)callPhone:(UIButton *)sender {
    //call phone
    NSMutableString* str=[[NSMutableString alloc] initWithFormat:@"telprompt://%@",self.valueLabel.text];
    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:str]];
    
}

@end
