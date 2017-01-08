//
//  MSHomeClassBannerCell.m
//  MSTreasuryManager
//
//  Created by apple on 17/1/6.
//  Copyright © 2017年 邓利文. All rights reserved.
//

#import "MSHomeClassBannerCell.h"
#import "MSCircleView.h"

#pragma mark - MSClassBannerCell
@interface MSClassBannerCell : MSCircleBaseCell

@property (nonatomic, strong) UILabel *titleLabel;

@end

@implementation MSClassBannerCell

- (void)setupSubviews {
    UIView *bgView = [[UIView alloc]init];
    [self.contentView addSubview:bgView];
    [bgView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.left.bottom.equalTo(self);
        make.height.mas_equalTo(kMSClassControlHeight);
    }];
    
    bgView.backgroundColor = [UIColor blackColor];
    bgView.alpha = 0.7;
    
    self.titleLabel = [[UILabel alloc]init];
    [self.contentView addSubview:self.titleLabel];
    [self.titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(10);
        make.right.equalTo(self.contentView.mas_right).offset(-10);
        make.height.mas_equalTo(kMSClassControlHeight);
        make.bottom.equalTo(self.contentView);
    }];
    self.titleLabel.font = [UIFont boldSystemFontOfSize:13];
    self.titleLabel.backgroundColor = [UIColor clearColor];
    self.titleLabel.textColor = [UIColor whiteColor];
    
    [self.imaView setContentMode:(UIViewContentModeScaleAspectFill)];
}

@end

@interface MSHomeClassBannerCell ()

@property (nonatomic, strong) MSCircleView *circleView;
@property (nonatomic, strong) UIPageControl *pageControl;

@end

@implementation MSHomeClassBannerCell

- (void)setupSubviews {
    [super setupSubviews];
    
    _circleView = [MSCircleView circleViewWithFrame:CGRectMake(0, 0, kSCREEN_WIDTH, kMSClassBannerHeight) urlImageArray:nil];
    _circleView.backgroundColor = [UIColor whiteColor];
    _circleView.cellClass = [MSClassBannerCell class];
    [self addSubview:_circleView];
    _circleView.autoScroll = YES;
    
    _pageControl = [[UIPageControl alloc]init];
    [self addSubview:_pageControl];
    _pageControl.numberOfPages = 0;
    [_pageControl sizeToFit];
    [_pageControl mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(self.mas_right).offset(-10);
        make.height.mas_equalTo(kMSClassControlHeight);
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
    
    for ( MSClassModel * model in bannerModels) {
        [urls addObject:@"http://139.196.112.30:8080/web/img/user-default.jpg"];
    }
    
    self.circleView.imageArray = urls;
    
    self.pageControl.numberOfPages = urls.count;
    __weak typeof (self)weakSelf = self;
    [self.circleView addPageScrollBlock:^(NSInteger index) {
        weakSelf.pageControl.currentPage = index;
    }];
    
    [self.circleView configCustomCell:^(MSCircleBaseCell *customCell, NSInteger index) {
        MSClassBannerCell *cell = (MSClassBannerCell *)customCell;
//        MSClassModel *bannerModel = baseBanners[index];
//        cell.titleLabel.text = bannerModel.title;
        cell.titleLabel.text = @"测试";
    }];
    
    [self.circleView addTapBlock:^(NSInteger index) {
        if ([weakSelf.delegate respondsToSelector:@selector(classBanner:clickedAtIndex:classBannerModel:)]) {
//            MSClassModel *bannerModel = baseBanners[index];
            [weakSelf.delegate classBanner:weakSelf clickedAtIndex:index classBannerModel:nil];
        }
    }];
}

+ (CGFloat)cellHeight {
    return kMSClassBannerHeight;
}

@end
