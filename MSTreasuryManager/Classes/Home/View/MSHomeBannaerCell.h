//
//  MSHomeBannaerCell.h
//  MSTreasuryManager
//
//  Created by apple on 17/1/6.
//  Copyright © 2017年 邓利文. All rights reserved.
//

#import "MSBaseTableViewCell.h"
#import "MSHomeBannerModel.h"

static CGFloat const kMSHomeBannerHeight = 140;
static CGFloat const kMSHomeControlHeight = 30;

@class MSHomeBannaerCell;

@protocol MSHomeBannaerCellDelegate <NSObject>

- (void)banner:(MSHomeBannaerCell*)banner clickedAtIndex:(NSInteger)index bannerModel:(MSHomeBannerModel *)bannerModel;

@end

@interface MSHomeBannaerCell : MSBaseTableViewCell

@property (nonatomic, weak) id<MSHomeBannaerCellDelegate> delegate;

- (void)fillWithBannerModels:(NSArray *)bannerModels;

@end
