//
//  MSHomeViewController.h
//  MSTreasuryManager
//
//  Created by 邓利文 on 2016/10/3.
//  Copyright © 2016年 邓利文. All rights reserved.
//

#import "MSBaseViewController.h"

typedef enum : NSUInteger {
    MSCellIndexOfTypeMaterialFillIn = 0, //物资信息填写
    MSCellIndexOfTypeMaterialQuery,      //物资信息查询
    MSCellIndexOfTypeMaterialOut,        //物资出库
    MSCellIndexOfTypeMateriaIn,          //物资入库
    MSCellIndexOfTypeOutInfosQuery,      //出库记录查询
    MSCellIndexOfTypeInInfosQuery,       //入库记录查询
} MSCellIndexOfType;

@interface MSHomeViewController : MSBaseViewController

@end
