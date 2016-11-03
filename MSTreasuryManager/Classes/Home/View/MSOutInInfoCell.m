//
//  MSOutInInfoCell.m
//  MSTreasuryManager
//
//  Created by 邓利文 on 2016/10/14.
//  Copyright © 2016年 邓利文. All rights reserved.
//

#import "MSOutInInfoCell.h"

@interface MSOutInInfoCell ()

@property (nonatomic, strong) UILabel *productLabel;
@property (nonatomic, strong) UILabel *dateLabel;
@property (nonatomic, strong) UILabel *userLabel;

@end

@implementation MSOutInInfoCell

- (void)setupSubviews {
    [self setAccessoryType:(UITableViewCellAccessoryDisclosureIndicator)];
    _productLabel = ({
        UILabel *label = [[UILabel alloc]init];
        [self.contentView addSubview:label];
        label.numberOfLines = 0;
        label.font = [UIFont systemFontOfSize:13];
        label;
    });
    
    _dateLabel = ({
        UILabel *label = [[UILabel alloc]init];
        [self.contentView addSubview:label];
        label.font = [UIFont systemFontOfSize:13];
        label;
    });
    
    _userLabel = ({
        UILabel *label = [[UILabel alloc]init];
        [self.contentView addSubview:label];
        label.font = [UIFont systemFontOfSize:13];
        [label setTextAlignment:(NSTextAlignmentCenter)];
        label;
    });
    
    [_productLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(10);
        make.top.equalTo(self.contentView).offset(5);
        make.right.equalTo(_dateLabel.mas_left).offset(-15);
        make.bottom.equalTo(self.contentView.mas_bottom).offset(-5);
    }];
    
    _dateLabel.text = @"2016-09-11 11:11";
    [_dateLabel sizeToFit];
    [_dateLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self.contentView.mas_right).offset(0);
        make.top.equalTo(_userLabel.mas_bottom).offset(3);
        
    }];
    
    [_userLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self.contentView.mas_right).offset(0);
        make.top.equalTo(self.contentView).offset(5);
    }];
    
}

- (void)fillWithOutInModel:(MSMaterialOutInModel *)model {
    self.productLabel.text = model.materialName;
    self.dateLabel.text = model.time;
    self.userLabel.text = [self storeNameWithLocationId:model.location];
}

- (NSString *)storeNameWithLocationId:(NSInteger)location {
    if (location == 1) {
        return @"二库库房";
    }
    if (location == 2) {
        return @"退库库房";
    }
    if (location == 3) {
        return @"系统库房";
    }
    return @"";
}

@end
