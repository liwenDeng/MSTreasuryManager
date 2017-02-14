//
//  MSClassHeaderView.h
//  MSTreasuryManager
//
//  Created by 邓利文 on 2017/2/14.
//  Copyright © 2017年 邓利文. All rights reserved.
//

#import "MSBaseView.h"
#import "MSClassModel.h"

static CGFloat const kHeaderViewHeight = 200;

@interface MSClassHeaderView : MSBaseView

- (void)fillWithClassModel:(MSClassModel *)classModel;

@end
