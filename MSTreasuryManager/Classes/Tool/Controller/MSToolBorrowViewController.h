//
//  MSToolBorrowViewController.h
//  MSTreasuryManager
//
//  Created by 邓利文 on 2016/10/14.
//  Copyright © 2016年 邓利文. All rights reserved.
//

#import "MSBaseViewController.h"
#import "MSToolModel.h"

@interface MSToolBorrowViewController : MSBaseViewController

@property (nonatomic, assign) BOOL multiBorrow;

- (instancetype)initWithToolModel:(MSToolModel *)tool;

- (instancetype)initWithMultiSelect:(BOOL)multiSelect;

@end
