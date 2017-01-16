//
//  MSHomePersonCell.h
//  MSTreasuryManager
//
//  Created by apple on 17/1/6.
//  Copyright © 2017年 邓利文. All rights reserved.
//

#import "MSBaseCollectionViewCell.h"
#import "MSPersonModel.h"

#define kMSPersonCellWidth  (kSCREEN_WIDTH / 3.0)
#define kMSPersonCellHeight (kSCREEN_WIDTH / 3.0) + 15
//static CGFloat const kMSPersonCellHeight = 104;

@interface MSHomePersonCell : MSBaseCollectionViewCell

- (void)fillWithPerson:(MSPersonModel *)personModel;

@end
