//
//  MSMaterialOutStoreViewController.h
//  MSTreasuryManager
//
//  Created by apple on 16/10/12.
//  Copyright © 2016年 邓利文. All rights reserved.
//

#import "MSBaseViewController.h"
#import "MSHomeViewController.h"
#import "MSMaterialOutInModel.h"

/**
 物资出库
 */
@interface MSMaterialOutStoreViewController : MSBaseViewController

- (instancetype)initWithType:(MSCellIndexOfType)type;

- (instancetype)initWithType:(MSCellIndexOfType)type outMaterialModel:(MSMaterialOutInModel *)outModel;

@end
