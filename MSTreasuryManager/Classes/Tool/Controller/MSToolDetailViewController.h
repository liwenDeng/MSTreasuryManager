//
//  MSToolDetailViewController.h
//  MSTreasuryManager
//
//  Created by 邓利文 on 2016/10/20.
//  Copyright © 2016年 邓利文. All rights reserved.
//

#import "MSBaseViewController.h"


/**
 工器具状态

 - MSToolTypeIn:  在库
 - MSToolTypeOut: 借出
 */
typedef NS_ENUM(NSUInteger, MSToolType) {
    MSToolTypeIn = 0,
    MSToolTypeOut = 1,
};

/**
 在库、借出 两种状态
 */
@interface MSToolDetailViewController : MSBaseViewController

@property (nonatomic, assign) NSInteger logId;
- (instancetype)initWithType:(MSToolType)type;

@end
