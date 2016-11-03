//
//  MSPhotoPadView.m
//  MSTreasuryManager
//
//  Created by 邓利文 on 2016/10/10.
//  Copyright © 2016年 邓利文. All rights reserved.
//

#import "MSPhotoPadView.h"

@class MSImageCell;
@protocol MSImageCellDelegate <NSObject>

- (void)imageCell:(MSImageCell*)cell deleteBtnClickedAtIndexPath:(NSIndexPath*)indexPath;

@end

static NSString * const kMSImageCellID = @"MSImageCell";

#pragma mark - MSImageCell
@interface MSImageCell : UICollectionViewCell

@property (nonatomic, weak) id<MSImageCellDelegate> delegate;
@property (nonatomic, strong)NSIndexPath *indexPath;
@property (nonatomic, strong)UIButton *deleteBtn;
@property (nonatomic, strong)UIImageView *imageView;

@end

@implementation MSImageCell

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        self.imageView = ({
            UIImageView *view = [[UIImageView alloc]init];
            [self.contentView addSubview:view];
            [view mas_makeConstraints:^(MASConstraintMaker *make) {
                make.edges.equalTo(self.contentView);
            }];
            
            view;
        });
        
        self.deleteBtn = ({
            UIButton *btn = [UIButton buttonWithType:(UIButtonTypeCustom)];
            [btn setBackgroundColor:kBackgroundColor];
            btn.alpha = 0.8;
            [btn setImage:[UIImage imageNamed:@"delete"] forState:(UIControlStateNormal)];
            [self.contentView addSubview:btn];
            [btn mas_makeConstraints:^(MASConstraintMaker *make) {
                make.top.right.equalTo(self.contentView);
                make.size.mas_equalTo(CGSizeMake(20, 20));
            }];
           
            [btn addTarget:self action:@selector(deleteBtnClicked:) forControlEvents:(UIControlEventTouchUpInside)];
            btn;
        });
    }
    return self;
}

- (void)deleteBtnClicked:(UIButton*)sender {
    if ([self.delegate respondsToSelector:@selector(imageCell:deleteBtnClickedAtIndexPath:)]) {
        [self.delegate imageCell:self deleteBtnClickedAtIndexPath:self.indexPath];
    }
}

- (void)fillWithImage:(UIImage *)image atIndexPath:(NSIndexPath*)indexPath {
    self.imageView.image = image;
    self.indexPath = indexPath;
}

- (void)fillWithImageUrl:(NSString *)imageUrl atIndexPath:(NSIndexPath*)indexPath{
    [self.imageView sd_setImageWithURL:[NSURL URLWithString:imageUrl]];
    self.deleteBtn.hidden = YES;
    self.indexPath = indexPath;
}

@end

@interface MSPhotoPadView () <UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout,MSImageCellDelegate>

@property (nonatomic, strong) UICollectionView *collectionView;

@property (nonatomic, assign) BOOL useWebImage;

@end

@implementation MSPhotoPadView

- (instancetype)init {
    if (self = [super init]) {
        [self setupSubviews];
    }
    return self;
}

- (void)setupSubviews {
    self.backgroundColor = [UIColor whiteColor];
    self.imageArray = [NSMutableArray array];
    self.urlArray = [NSMutableArray array];
    
    UICollectionViewFlowLayout *flowLayout = [[UICollectionViewFlowLayout alloc]init];
    flowLayout.minimumLineSpacing = 10.0f;
    flowLayout.minimumInteritemSpacing = 10.0f;
    flowLayout.sectionInset = UIEdgeInsetsMake(10, 10, 10, 10);
    flowLayout.itemSize = CGSizeMake(kImageCellWidth, kImageCellHeight);
    
    self.collectionView = [[UICollectionView alloc]initWithFrame:self.bounds collectionViewLayout:flowLayout];
    self.collectionView.scrollEnabled = NO;
    [self addSubview:self.collectionView];
    [self.collectionView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self);
    }];
    [self.collectionView registerClass:[MSImageCell class] forCellWithReuseIdentifier:kMSImageCellID];
    self.collectionView.backgroundColor = [UIColor clearColor];
    self.collectionView.delegate = self;
    self.collectionView.dataSource = self;
}

- (void)addImage:(UIImage *)image {
    self.useWebImage = NO;
    [self.imageArray addObject:image];
    NSIndexPath *path = [NSIndexPath indexPathForRow:(self.imageArray.count -1) inSection:0];
    [self.collectionView insertItemsAtIndexPaths:@[path]];
}

- (void)clearImages {
    [self.imageArray removeAllObjects];
    [self.urlArray removeAllObjects];
    [self.collectionView reloadData];
}

#pragma mark - UICollectionViewDataSource
- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    return 1;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return self.useWebImage ? self.urlArray.count : self.imageArray.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    MSImageCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:kMSImageCellID forIndexPath:indexPath];
    if (self.useWebImage) {
        NSString *imageUrl = self.urlArray[indexPath.row];
        [cell fillWithImageUrl:imageUrl atIndexPath:indexPath];
        
    }else {
        UIImage *image = self.imageArray[indexPath.row];
        [cell fillWithImage:image atIndexPath:indexPath];
    }
    cell.delegate = self;
    return cell;
}

#pragma mark - UICollectionViewDelegate
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    if ([self.delegate respondsToSelector:@selector(photoPadView:clickedAtIndex:inImages:)]) {
        [self.delegate photoPadView:self clickedAtIndex:indexPath.row inImages:self.imageArray];
    }
}

#pragma mark - MSImageCellDelegate
- (void)imageCell:(MSImageCell *)cell deleteBtnClickedAtIndexPath:(NSIndexPath *)indexPath {
    NSIndexPath *currentIndexPath = [self.collectionView indexPathForCell:cell];
    
    [self.imageArray removeObjectAtIndex:currentIndexPath.row];
    [self.collectionView deleteItemsAtIndexPaths:@[currentIndexPath]];
}

- (UIView *)cellViewAtIndex:(NSInteger)index {
    MSImageCell *cell = [self.collectionView cellForItemAtIndexPath:[NSIndexPath indexPathForRow:index inSection:0]];
    return cell;
}

@end


@implementation MSPhotoPadView (AddOnly)

- (void)addImageUrls:(NSArray *)imageUrls {
    self.useWebImage = YES;
    [self.urlArray removeAllObjects];
    [self.urlArray addObjectsFromArray:imageUrls];
    [self.collectionView reloadData];
}

@end
