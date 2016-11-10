//
//  MSLiveWorkFillinTagsSection.h
//  MSTreasuryManager
//
//  Created by 邓利文 on 2016/10/22.
//  Copyright © 2016年 邓利文. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "YZTagList.h"

/**
 标签选取SectionView
 */
@interface MSLiveWorkFillinTagsSection : UIView

@property (nonatomic, strong) NSArray *users;
@property (nonatomic, strong) UIButton *addBtn;
@property (nonatomic, strong) YZTagList *tagList;

- (instancetype)initWithTitle:(NSString *)title placeholder:(NSString *)placeholder showDeleteBtn:(BOOL)show;
- (instancetype)initWithTitle:(NSString *)title placeholder:(NSString *)placeholder;

- (void)addUser:(NSString *)user;

- (void)addUsers:(NSArray *)users;

- (void)deleteAllUsers;

@end
