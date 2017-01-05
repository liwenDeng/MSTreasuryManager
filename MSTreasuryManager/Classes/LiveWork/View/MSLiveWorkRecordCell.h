//
//  MSLiveWorkRecordCell.h
//  MSTreasuryManager
//
//  Created by apple on 17/1/5.
//  Copyright © 2017年 邓利文. All rights reserved.
//

#import "MSBaseTableViewCell.h"
#import "MSLiveWorkModel.h"

/**
 工作记录cell
 */
@interface MSLiveWorkRecordCell : MSBaseTableViewCell

@property (nonatomic, strong) MSLiveWorkModel *liveWorkModel;

@end
