//
//  MSCircleCell.m
//  MSBannerView
//
//  Created by dengliwen on 15/12/4.
//  Copyright © 2015年 dengliwen. All rights reserved.
//

#import "MSCircleBaseCell.h"

@implementation MSCircleBaseCell

- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        self.imaView = [[UIImageView alloc]initWithFrame:self.bounds];
        self.imaView.contentMode = UIViewContentModeScaleAspectFill;
        [self.contentView addSubview:self.imaView];
        [self setupSubviews];
    }
    return self;
}

- (void)setupSubviews {

}

@end
