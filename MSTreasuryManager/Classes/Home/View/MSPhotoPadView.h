//
//  MSPhotoPadView.h
//  MSTreasuryManager
//
//  Created by 邓利文 on 2016/10/10.
//  Copyright © 2016年 邓利文. All rights reserved.
//

#import <UIKit/UIKit.h>

#define kImageCellWidth ((kSCREEN_WIDTH - 40)/3)
#define kImageCellHeight ((kSCREEN_WIDTH - 40)/3)

@class MSPhotoPadView;

@protocol MSPhotoPadViewDelegate <NSObject>

- (void)photoPadView:(MSPhotoPadView *)photoPadView clickedAtIndex:(NSInteger )currentIndex inImages:(NSArray *)images;

@end

@interface MSPhotoPadView : UIView

@property (nonatomic, weak) id<MSPhotoPadViewDelegate>delegate;
@property (nonatomic, strong) NSMutableArray *imageArray;

- (void)addImage:(UIImage *)image;

- (UIView *)cellViewAtIndex:(NSInteger)index;

@end
