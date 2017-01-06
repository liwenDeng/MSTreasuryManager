//
//  MSHomeClassBannerCell.h
//  MSTreasuryManager
//
//  Created by apple on 17/1/6.
//  Copyright © 2017年 邓利文. All rights reserved.
//

#import "MSBaseTableViewCell.h"
#import "MSClassModel.h"

static CGFloat const kMSClassBannerHeight = 140;
static CGFloat const kMSClassControlHeight = 30;

@class MSHomeClassBannerCell;

@protocol MSHomeClassBannerCellDelegate <NSObject>

- (void)classBanner:(MSHomeClassBannerCell*)banner clickedAtIndex:(NSInteger)index classBannerModel:(MSClassModel *)classBannerModel;

@end

@interface MSHomeClassBannerCell : MSBaseTableViewCell

@property (nonatomic, weak) id<MSHomeClassBannerCellDelegate> delegate;

- (void)fillWithBannerModels:(NSArray *)bannerModels;

@end
