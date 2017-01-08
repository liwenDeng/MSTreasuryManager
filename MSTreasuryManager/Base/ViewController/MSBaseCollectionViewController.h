//
//  MSBaseCollectionViewController.h
//  MSTreasuryManager
//
//  Created by apple on 17/1/8.
//  Copyright © 2017年 邓利文. All rights reserved.
//

#import "MSBaseViewController.h"
#import <MJRefresh.h>

@interface MSBaseCollectionViewController : MSBaseViewController  <UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout>

@property (nonatomic, strong) UICollectionView *collectionView;
@property (nonatomic, strong) UICollectionViewFlowLayout *flowLayout;

@end
