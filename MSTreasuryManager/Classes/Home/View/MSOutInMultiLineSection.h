//
//  MSOutInMultiLineSection.h
//  MSTreasuryManager
//
//  Created by 邓利文 on 2016/10/14.
//  Copyright © 2016年 邓利文. All rights reserved.
//

#import <UIKit/UIKit.h>

/**
 出入库详情多行section
 */
@interface MSOutInMultiLineSection : UIView

@property (nonatomic, strong) UILabel *subLabel;

- (instancetype)initWithTitle:(NSString *)title;

@end
