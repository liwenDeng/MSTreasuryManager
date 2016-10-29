//
//  MSLoginView.h
//  MSTreasuryManager
//
//  Created by 邓利文 on 2016/10/25.
//  Copyright © 2016年 邓利文. All rights reserved.
//

#import "MSBaseView.h"

@class MSLoginView;

@protocol MSLoginViewDelegate <NSObject>

- (void)loginView:(MSLoginView *)loginView loginButtonClicked:(UIButton *)sender;

- (void)loginView:(MSLoginView *)loginView cancleButtonClicked:(UIButton *)sender;

- (void)loginView:(MSLoginView *)loginView loginSuccessed:(BOOL)successed;

@end


@interface MSLoginView : MSBaseView

@property (nonatomic, weak) id<MSLoginViewDelegate> delegate;

- (void)hideCancleButton;

@end
