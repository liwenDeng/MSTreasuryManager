//
//  MSCommonSearchViewController.h
//  MSTreasuryManager
//
//  Created by 邓利文 on 2016/10/17.
//  Copyright © 2016年 邓利文. All rights reserved.
//

#import "MSBaseSearchTableViewController.h"

typedef enum : NSUInteger {
    MSSearchTypeMaterialName = 0,
    MSSearchTypeMaterialParams,
    MSSearchTypeStorePlace,
    MSSearchTypePerson,
    MSSearchTypeToolName,
    
} MSSearchType;

@class MSCommonSearchViewController;

@protocol MSCommonSearchViewControllerDelegate <NSObject>

- (void)searchViewController:(MSCommonSearchViewController*)searchController didSelectString:(NSString *)result;

- (void)searchViewController:(MSCommonSearchViewController*)searchController didSelectModel:(NSDictionary *)resultDic;

@end

@interface MSCommonSearchViewController : MSBaseSearchTableViewController

@property (nonatomic, weak) id<MSCommonSearchViewControllerDelegate> delegate;
- (instancetype)initWithSearchType:(MSSearchType)type;


@end
