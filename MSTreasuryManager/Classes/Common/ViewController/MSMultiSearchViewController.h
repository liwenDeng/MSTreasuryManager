//
//  MSMultiSearchViewController.h
//  MSTreasuryManager
//
//  Created by 邓利文 on 2016/11/5.
//  Copyright © 2016年 邓利文. All rights reserved.
//

#import "MSBaseTableViewController.h"
#import "MSCommonSearchViewController.h"

@interface MSMultiSearchViewController : MSBaseTableViewController

@property (nonatomic, assign) MSSearchType searchType;
@property (nonatomic, weak) id<MSCommonSearchViewControllerDelegate> delegate;

- (instancetype)initWithSearchType:(MSSearchType)type;

@end
