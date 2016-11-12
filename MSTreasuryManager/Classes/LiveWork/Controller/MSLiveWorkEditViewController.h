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

@class MSLiveWorkEditViewController;

@protocol MSLiveWorkEditViewControllerDelegate <NSObject>

- (void)editViewController:(MSLiveWorkEditViewController *)vc editType:(MSEditType)editType resultString:(NSString *)resultString;

@end

@interface MSLiveWorkEditViewController : MSBaseViewController

@property (nonatomic, assign) MSEditType editType;
@property (nonatomic, assign) NSInteger workId;
@property (nonatomic, weak) id<MSLiveWorkEditViewControllerDelegate> delegate;

- (instancetype)initWithEditType:(MSEditType)type;

@end
