//
//  MSBaseTableViewCell.m
//  MSTreasuryManager
//
//  Created by 邓利文 on 2016/10/14.
//  Copyright © 2016年 邓利文. All rights reserved.
//

#import "MSBaseTableViewCell.h"

@implementation MSBaseTableViewCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        [self setupSubviews];
    }
    return self;
}

- (void)setupSubviews {

}

@end
