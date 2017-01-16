//
//  MSHomeBannaerCell.m
//  MSTreasuryManager
//
//  Created by apple on 17/1/6.
//  Copyright © 2017年 邓利文. All rights reserved.
//

#import "MSHomeBannaerCell.h"
#import "MSCircleView.h"

#pragma mark - MSBannerCell

@interface MSBannerCell : MSCircleBaseCell

@property (nonatomic, strong) UILabel *titleLabel;

@end

@implementation MSBannerCell

- (void)setupSubviews {
    UIView *bgView = [[UIView alloc]init];
    [self.contentView addSubview:bgView];
    [bgView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.left.bottom.equalTo(self);
        make.height.mas_equalTo(kMSHomeControlHeight);
    }];
    
    bgView.backgroundColor = [UIColor blackColor];
    bgView.alpha = 0.7;
    
//    self.titleLabel = [[UILabel alloc]init];
//    [self.contentView addSubview:self.titleLabel];
//    [self.titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.left.mas_equalTo(10);
//        make.right.equalTo(self.contentView.mas_right).offset(-10);
//        make.height.mas_equalTo(kMSHomeControlHeight);
//        make.bottom.equalTo(self.contentView);
//    }];
//    self.titleLabel.font = [UIFont boldSystemFontOfSize:13];
//    self.titleLabel.backgroundColor = [UIColor clearColor];
//    self.titleLabel.textColor = [UIColor whiteColor];
    
    [self.imaView setContentMode:(UIViewContentModeScaleAspectFill)];
}

@end

@interface MSHomeBannaerCell ()

@property (nonatomic, strong) MSCircleView *circleView;
@property (nonatomic, strong) UIPageControl *pageControl;

@end

@implementation MSHomeBannaerCell

- (void)setupSubviews {
    [super setupSubviews];
    
    _circleView = [MSCircleView circleViewWithFrame:CGRectMake(0, 0, kSCREEN_WIDTH, kMSHomeBannerHeight) urlImageArray:nil];
    _circleView.backgroundColor = [UIColor whiteColor];
    _circleView.cellClass = [MSBannerCell class];
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
    NSMutableArray *baseBanners = [NSMutableArray array];
    
    for ( MSHomeBannerModel * model in bannerModels) {
        [urls addObject:@"http://139.196.112.30:8080/web/img/user-default.jpg"];
    }

    self.circleView.imageArray = urls;
    
    self.pageControl.numberOfPages = urls.count;
    __weak typeof (self)weakSelf = self;
    [self.circleView addPageScrollBlock:^(NSInteger index) {
        weakSelf.pageControl.currentPage = index;
    }];
    
//    [self.circleView configCustomCell:^(MSCircleBaseCell *customCell, NSInteger index) {
//        MSBannerCell *cell = (MSBannerCell *)customCell;
////        MSBaseBannerModel *bannerModel = baseBanners[index];
////        cell.titleLabel.text = bannerModel.title;
//    }];
    
    [self.circleView addTapBlock:^(NSInteger index) {
        if ([weakSelf.delegate respondsToSelector:@selector(banner:clickedAtIndex:bannerModel:)]) {
//            MSHomeBannerModel *bannerModel = baseBanners[index];
//            [weakSelf.delegate banner:weakSelf clickedAtIndex:index bannerModel:bannerModel];
        }
    }];
}

+ (CGFloat)cellHeight {
    return kMSHomeBannerHeight;
}

@end
