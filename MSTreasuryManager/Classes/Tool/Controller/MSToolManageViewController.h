//
//  MSToolManageViewController.h
//  MSTreasuryManager
//
//  Created by 邓利文 on 2016/10/14.
//  Copyright © 2016年 邓利文. All rights reserved.
//

#import "MSBaseViewController.h"

typedef enum : NSUInteger {
    MSToolCellIndexOfTypeFillIn = 0, //工器具信息填写
    MSToolCellIndexOfTypeStateQuery,
    MSToolCellIndexOfTypeBorrow,
    MSToolCellIndexOfTypeLoan,
    MSToolCellIndexOfTypeBorrowList, //借用记录列表
    MSToolCellIndexOfTypeLoanList    //归还记录列表
    
} MSToolCellIndexOfType;

/**
 工器具管理
 */
@interface MSToolManageViewController : MSBaseViewController

@end
