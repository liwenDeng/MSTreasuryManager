//
//  MSMaterialFillInNomalSection.h
//  MSTreasuryManager
//
//  Created by 邓利文 on 2016/10/8.
//  Copyright © 2016年 邓利文. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MSMaterialFillInNomalSection : UIView

@property (nonatomic, strong) UITextField * textField;

- (instancetype)initWithTitle:(NSString *)title placeholder:(NSString *)placeholder;

@end
