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

 - MSToolTypeOut: 借出
 - MSToolTypeIn:  在库
 */
typedef NS_ENUM(NSUInteger, MSToolType) {
    MSToolTypeOut,
    MSToolTypeIn,
};

/**
 在库、借出 两种状态
 */
@interface MSToolDetailViewController : MSBaseViewController

- (instancetype)initWithType:(MSToolType)type;

@end
