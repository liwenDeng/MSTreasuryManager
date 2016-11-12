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
    MSSearchTypeHandlePerson,
    MSSearchTypeReviewPerson,
    MSSearchTypeChargePerson, //工作负责人
    MSSearchTypeMemberPerson, //班组成员
    MSSearchTypeMettingPerson,//参会人员
    MSSearchTypeToolName,
    MSSearchTypeToolInStore,
    MSSearchTypeToolOutStore,
    MSSearchTypeBorrowPerson,   //借用人
    MSSearchTypeLoanPerson      //归还人
} MSSearchType;

@class MSCommonSearchViewController;

@protocol MSCommonSearchViewControllerDelegate <NSObject>

@optional
- (void)searchViewController:(MSSearchType)searchType didSelectString:(NSString *)result;

- (void)searchViewController:(MSSearchType)searchType didSelectModel:(id)resultModel;

- (void)searchViewController:(MSSearchType)searchType didSelectDic:(NSDictionary *)resultDic;

- (void)searchViewController:(MSSearchType)searchType didSelectSet:(NSSet *)selectSet;

@end

@protocol MSCommonLoadMoreResultProtocol <NSObject>

@required
- (void)loadMoreResult;

@end

@interface MSCommonSearchViewController : MSBaseSearchTableViewController

@property (nonatomic, assign) MSSearchType searchType;
@property (nonatomic, strong) NSMutableArray *totalList;
@property (nonatomic, strong) NSMutableArray *searchList;
@property (nonatomic, weak) id<MSCommonSearchViewControllerDelegate> delegate;

@property (nonatomic, assign) NSInteger pageNo;

- (instancetype)initWithSearchType:(MSSearchType)type;

- (void)requestAllData;
- (void)requestSearchData;

@end
