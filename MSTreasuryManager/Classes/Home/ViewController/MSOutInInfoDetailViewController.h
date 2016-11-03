//
//  MSOutInInfoDetailViewController.h
//  MSTreasuryManager
//
//  Created by 邓利文 on 2016/10/14.
//  Copyright © 2016年 邓利文. All rights reserved.
//

#import "MSBaseViewController.h"
#import "MSHomeViewController.h"

/**
 出入库详情
 */
@interface MSOutInInfoDetailViewController : MSBaseViewController

@property (nonatomic, assign) NSInteger materialId;
@property (nonatomic, copy) NSString *materialName;

- (instancetype)initWithType:(MSCellIndexOfType)type;

@end
