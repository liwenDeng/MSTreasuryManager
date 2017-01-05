//
//  MSLiveWorkQueryViewController.m
//  MSTreasuryManager
//
//  Created by 邓利文 on 2016/10/24.
//  Copyright © 2016年 邓利文. All rights reserved.
//

#import "MSLiveWorkQueryViewController.h"
#import "MSBaseDatePickerView.h"
#import "MSMaterialFillInNomalSection.h"
#import <UITableView+FDTemplateLayoutCell.h>
#import "MSLiveWorkNoteCell.h"
#import "MSLiveWorkMeetingCell.h"
#import "MSLiveWorkQueryDetailViewController.h"
#import "MSLiveWorkEditViewController.h"
#import "MSNetworking+LiveWork.h"
#import "MSLiveWorkRecordCell.h"

static NSString * const kLiveWorkLeaderCell = @"LiveWorkLeaderCell";
static NSString * const kLiveWorkMeetingCell = @"LiveWorkMeetingCell";
static NSString * const kLiveWorkNoteCell = @"LiveWorkNoteCell";

@interface MSLiveWorkQueryViewController () <MSBaseDatePickerViewDelegate>

@property (nonatomic, strong) UITextField *dateTextField;
@property (nonatomic, strong) MSBaseDatePickerView *datePickerView;
@property (nonatomic, strong) NSArray *workList;
@property (nonatomic, strong) NSString *persons;
@property (nonatomic, strong) NSString *attention;

@end

@implementation MSLiveWorkQueryViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.title = @"现场工作查询";
    [self setupSubViews];
}

- (void)setupSubViews {
    
    [self.tableView registerClass:[MSLiveWorkMeetingCell class] forCellReuseIdentifier:kLiveWorkMeetingCell];
    [self.tableView registerClass:[MSLiveWorkNoteCell class] forCellReuseIdentifier:kLiveWorkNoteCell];
    [self.tableView registerClass:[MSLiveWorkRecordCell class] forCellReuseIdentifier:kLiveWorkLeaderCell];
    self.tableView.contentInset = UIEdgeInsetsMake(20, 0, 0, 0);
    [self.tableView setSeparatorStyle:(UITableViewCellSeparatorStyleNone)];
    
    MSMaterialFillInNomalSection *section1 = [[MSMaterialFillInNomalSection alloc]initWithTitle:@"工作日期" placeholder:@"选择日期" canTouch:YES];
    self.dateTextField = section1.textField;
    section1.titleLabel.font = [UIFont systemFontOfSize:18];
    [section1.actionBtn addTarget:self action:@selector(chooseDate) forControlEvents:(UIControlEventTouchUpInside)];
    
    section1.frame = CGRectMake(0, 20, kSCREEN_WIDTH, 64);
    self.tableView.tableHeaderView = section1;
    self.tableView.tableFooterView = [[UIView alloc] initWithFrame:CGRectZero];
}

#pragma mark - UITableViewDataSource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return self.workList.count ? 3 : 0;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    switch (section) {
        case 0:
        case 1:
            return 1;
        case 2:
            return self.workList.count ? : 0;
        default:
            return 0;
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    switch (indexPath.section) {
        case 0:
        {
            MSLiveWorkMeetingCell *cell = [tableView dequeueReusableCellWithIdentifier:kLiveWorkMeetingCell forIndexPath:indexPath];
            cell.contentLabel.text = self.persons ? : @"";
            [cell setAccessoryType:(UITableViewCellAccessoryDisclosureIndicator)];
            return cell;
        }
            break;
        case 1:
        {
            MSLiveWorkNoteCell *cell = [tableView dequeueReusableCellWithIdentifier:kLiveWorkNoteCell forIndexPath:indexPath];
            cell.contentLabel.text = self.attention ? : @"";
            [cell setAccessoryType:(UITableViewCellAccessoryDisclosureIndicator)];
            return cell;
        }
            break;
        case 2:
        {
            MSLiveWorkRecordCell *cell = [tableView dequeueReusableCellWithIdentifier:kLiveWorkLeaderCell];
            if (!cell) {
                cell = [[MSLiveWorkRecordCell alloc]initWithStyle:(UITableViewCellStyleValue1) reuseIdentifier:kLiveWorkLeaderCell];
            }
            MSLiveWorkModel *model = self.workList[indexPath.row];
            cell.liveWorkModel = model;
//            [cell setAccessoryType:(UITableViewCellAccessoryDisclosureIndicator)];
            return cell;
        }
            break;
        default:
            break;
    }
    return nil;
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section {
    switch (section) {
        case 0:
            return @"参会人员";
        case 1:
            return @"注意事项";
        case 2:
            return @"工作记录列表";
        default:
            return @"";
    }
}

#pragma mark - HTTP Request
- (void)loadLiveWorkList:(NSString *)workTime {
    [SVProgressHUD show];
    [MSNetworking getLiveWorkList:workTime success:^(NSDictionary *object) {
        
        NSString *attention = object[@"data"][@"attention"];
        self.attention = attention;
        
        NSString *personString = object[@"data"][@"persons"];
//        NSArray *persons = [MSLiveWorkModel personArrayFromPersonString:personString];
        self.persons = personString;
        
        self.workList = [MSLiveWorkModel mj_objectArrayWithKeyValuesArray:object[@"data"][@"list"]];
        [self.tableView reloadData];
        
        [SVProgressHUD showSuccessWithStatus:nil];
    } failure:^(NSError *error) {
        [SVProgressHUD showErrorWithStatus:@"查询失败"];
    }];
}

#pragma mark - UITableViewDelegate
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    [tableView deselectRowAtIndexPath:indexPath animated:NO];
    
    switch (indexPath.section) {
        case 0:
        {
            MSLiveWorkEditViewController *editVC = [[MSLiveWorkEditViewController alloc]initWithEditType:(MSEditTypePersons)];
            MSLiveWorkModel *model = [self editWorkModel];
            if (model) {
                editVC.workId = model.workId;
                [self.navigationController pushViewController:editVC animated:YES];
            }
        }
            break;
        case 1:
        {
            MSLiveWorkEditViewController *editVC = [[MSLiveWorkEditViewController alloc]initWithEditType:(MSEditTypeAttention)];
            MSLiveWorkModel *model = [self editWorkModel];
            model.attention = self.attention;
            if (model) {
                editVC.workId = model.workId;
                [self.navigationController pushViewController:editVC animated:YES];
            }
        }
            break;
        case 2:
        {
            MSLiveWorkModel *model = self.workList[indexPath.row];
            MSLiveWorkQueryDetailViewController *detailVC = [[MSLiveWorkQueryDetailViewController alloc]initWithLiveWorkId:model.workId];
            [self.navigationController pushViewController:detailVC animated:YES];
        }
        default:
            break;
    }
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    switch (indexPath.section) {
        case 0:
            return [tableView fd_heightForCellWithIdentifier:kLiveWorkMeetingCell configuration:^(MSLiveWorkMeetingCell * cell) {
                cell.contentLabel.text = self.persons ? : @"";
            }];
            break;
        case 1:
        {
            return [tableView fd_heightForCellWithIdentifier:kLiveWorkNoteCell configuration:^(MSLiveWorkNoteCell * cell) {
                cell.contentLabel.text = self.attention ? : @"";
            }];
        }
            break;
        case 2:
        {
            MSLiveWorkModel *model = self.workList[indexPath.row];
            return [tableView fd_heightForCellWithIdentifier:kLiveWorkLeaderCell configuration:^(MSLiveWorkRecordCell * cell) {
                cell.liveWorkModel = model;
            }];
        }
            break;
        default:
            return 0;
            break;
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return 44;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    return CGFLOAT_MIN;
}

#pragma mark - tap action
- (void)chooseDate {
    [self showDatePickerView];
}

#pragma mark - MSBaseDatePickerViewDelegate
- (void)datePickerView:(MSBaseDatePickerView *)datePicker submitWithDate:(NSDate *)date {
    NSLog(@"date:%@",date);
    self.dateTextField.text = [date ms_dateString];
    [self hideDatePickerView];
    [self loadLiveWorkList:[date ms_dateString]];
}

- (void)datePickerView:(MSBaseDatePickerView *)datePicker cancleWithDate:(NSDate *)date {
    [self hideDatePickerView];
}

- (void)showDatePickerView {
    [self.view endEditing:YES];
    if (self.datePickerView.hidden) {
        self.datePickerView.hidden = NO;
        [UIView animateWithDuration:0.3 delay:0 options:(UIViewAnimationOptionCurveEaseOut) animations:^{
            [self.datePickerView mas_updateConstraints:^(MASConstraintMaker *make) {
                make.top.equalTo(self.mas_bottomLayoutGuideBottom).offset(-264);
            }];
            [self.view layoutIfNeeded];
        } completion:^(BOOL finished) {
            
        }];
    }
}

- (void)hideDatePickerView {
    if (!self.datePickerView.hidden) {
        [UIView animateWithDuration:0.3 delay:0 options:(UIViewAnimationOptionCurveEaseIn) animations:^{
            [self.datePickerView mas_updateConstraints:^(MASConstraintMaker *make) {
                make.top.equalTo(self.mas_bottomLayoutGuideBottom).offset(0);
            }];
            [self.view layoutIfNeeded];
        } completion:^(BOOL finished) {
            self.datePickerView.hidden = YES;
        }];
    }
}

#pragma mark - LazyLoad
- (MSBaseDatePickerView *)datePickerView {
    if (!_datePickerView) {
        _datePickerView = [[MSBaseDatePickerView alloc]init];
        [self.view addSubview:_datePickerView];
        
        [_datePickerView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(0);
            make.top.equalTo(self.mas_bottomLayoutGuideBottom);
            make.width.mas_equalTo(kSCREEN_WIDTH);
            make.height.mas_equalTo(240);
        }];
        _datePickerView.delegate = self;
        _datePickerView.hidden = YES;
        [self.view layoutIfNeeded];
    }
    return _datePickerView;
}

#pragma mark - Util
- (MSLiveWorkModel *)editWorkModel {
    for (MSLiveWorkModel *model in self.workList) {
        if (model.sort == 1) {
            return model;
        }
    }
    return nil;
}

@end
