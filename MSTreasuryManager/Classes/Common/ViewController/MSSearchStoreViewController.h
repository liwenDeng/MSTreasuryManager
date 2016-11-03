//
//  MSSearchStoreViewController.h
//  MSTreasuryManager
//
//  Created by 邓利文 on 2016/11/2.
//  Copyright © 2016年 邓利文. All rights reserved.
//

#import "MSCommonSearchViewController.h"

static NSString *const kPlaceNameKey = @"plcaeName";
static NSString *const kPlaceIdKey = @"plcaeId";

/**
 仓库选择
 */
@interface MSSearchStoreViewController : MSBaseTableViewController

@property (nonatomic, assign) id<MSCommonSearchViewControllerDelegate> delegate;

@end
