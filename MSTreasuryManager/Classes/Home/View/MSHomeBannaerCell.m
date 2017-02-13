//
//  MSHomeBannaerCell.m
//  MSTreasuryManager
//
//  Created by apple on 17/1/6.
//  Copyright © 2017年 邓利文. All rights reserved.
//

#import "MSHomeBannaerCell.h"
#import "MSCircleView.h"

@interface MSHomeBannaerCell ()

@property (nonatomic, strong) MSCircleView *circleView;
@property (nonatomic, strong) UIPageControl *pageControl;

@end

@implementation MSHomeBannaerCell

- (void)setupSubviews {
    [super setupSubviews];
    
    _circleView = [MSCircleView circleViewWithFrame:CGRectMake(0, 0, kSCREEN_WIDTH, kMSHomeBannerHeight - 10) urlImageArray:nil];
    _circleView.backgroundColor = [UIColor whiteColor];
    _circleView.cellClass = [MSCircleBaseCell class];
    [self addSubview:_circleView];
    _circleView.autoScroll = YES;
    
    _pageControl = [[UIPageControl alloc]init];
    [self addSubview:_pageControl];
    _pageControl.numberOfPages = 0;
    [_pageControl sizeToFit];
    [_pageControl mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(self.mas_right).offset(-10);
        make.height.mas_equalTo(kMSHomeControlHeight);
        make.bottom.equalTo(self.circleView);
    }];
    
    _pageControl.pageIndicatorTintColor = [UIColor lightGrayColor];
    _pageControl.currentPageIndicatorTintColor = [UIColor orangeColor];
    _pageControl.backgroundColor = [UIColor clearColor];
    _pageControl.contentHorizontalAlignment = UIControlContentHorizontalAlignmentRight;
}

- (void)fillWithBannerModels:(NSArray *)bannerModels {
    NSMutableArray *urls = [NSMutableArray array];
    
    for ( MSHomeBannerModel * model in bannerModels) {
        [urls addObject:[NSString stringWithFormat:@"%@%@",KImageUrl,model.img]];
    }

    self.circleView.imageArray = urls;
    
    self.pageControl.numberOfPages = urls.count;
    __weak typeof (self)weakSelf = self;
    [self.circleView addPageScrollBlock:^(NSInteger index) {
        weakSelf.pageControl.currentPage = index;
    }];
    
    [self.circleView addTapBlock:^(NSInteger index) {
        if ([weakSelf.delegate respondsToSelector:@selector(banner:clickedAtIndex:bannerModel:)]) {
            MSHomeBannerModel *bannerModel = bannerModels[index];
            [weakSelf.delegate banner:weakSelf clickedAtIndex:index bannerModel:bannerModel];
        }
    }];
}

+ (CGFloat)cellHeight {
    return kMSHomeBannerHeight;
}

@end
