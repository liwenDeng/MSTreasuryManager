//
//  MSCommonSearchViewController.h
//  MSTreasuryManager
//
//  Created by 邓利文 on 2016/10/17.
//  Copyright © 2016年 邓利文. All rights reserved.
//

#import "MSBaseSearchTableViewController.h"

static NSString *const kSearchCell = @"SearchCell";
static NSString *const kResultCell = @"ResultCell";

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

@property (nonatomic, strong) NSArray *totalList;
@property (nonatomic, strong) NSMutableArray *searchList;
@property (nonatomic, weak) id<MSCommonSearchViewControllerDelegate> delegate;

- (instancetype)initWithSearchType:(MSSearchType)type;

- (void)requestAllData;
- (void)requestSearchData;

@end
