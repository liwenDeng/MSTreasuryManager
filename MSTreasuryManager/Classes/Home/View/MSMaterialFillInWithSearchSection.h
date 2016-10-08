//
//  MSMaterialFillInWithSearchSection.h
//  MSTreasuryManager
//
//  Created by 邓利文 on 2016/10/8.
//  Copyright © 2016年 邓利文. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "YZInputView.h"

/**
 带搜索框的SectionView
 */
@interface MSMaterialFillInWithSearchSection : UIView

@property (nonatomic, strong) YZInputView *inputView;

- (instancetype)initWithTitle:(NSString *)title placeholder:(NSString *)placeholder;

@end
