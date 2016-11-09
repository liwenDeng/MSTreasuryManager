//
//  MSLiveWorkEditViewController.h
//  MSTreasuryManager
//
//  Created by 邓利文 on 2016/10/24.
//  Copyright © 2016年 邓利文. All rights reserved.
//

#import "MSBaseViewController.h"
#import "MSLiveWorkModel.h"

typedef enum : NSUInteger {
    MSEditTypeAttention = 0,
    MSEditTypePersons,
} MSEditType;

@interface MSLiveWorkEditViewController : MSBaseViewController

@property (nonatomic, assign) MSEditType editType;
@property (nonatomic, strong) MSLiveWorkModel *editModel;

- (instancetype)initWithEditType:(MSEditType)type;

@end
