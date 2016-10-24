//
//  MSLiveWorkEditViewController.h
//  MSTreasuryManager
//
//  Created by 邓利文 on 2016/10/24.
//  Copyright © 2016年 邓利文. All rights reserved.
//

#import "MSBaseViewController.h"

typedef enum : NSUInteger {
    MSEditTypeContent = 0,
    MSEditTypeNote,
} MSEditType;

@interface MSLiveWorkEditViewController : MSBaseViewController

@property (nonatomic, assign) MSEditType editType;

- (instancetype)initWithEditType:(MSEditType)type;

@end
