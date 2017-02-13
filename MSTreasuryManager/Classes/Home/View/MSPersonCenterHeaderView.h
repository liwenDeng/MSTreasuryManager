//
//  MSPersonCenterHeaderView.h
//  MSTreasuryManager
//
//  Created by apple on 17/1/14.
//  Copyright © 2017年 邓利文. All rights reserved.
//

#import "MSBaseView.h"
#import "MSPersonModel.h"

static CGFloat const kHeaderViewHeight = 200;

@interface MSPersonCenterHeaderView : MSBaseView

@property (nonatomic, strong) MSPersonModel *personModel;

- (void)fillWithPerson:(MSPersonModel *)person;

@end
