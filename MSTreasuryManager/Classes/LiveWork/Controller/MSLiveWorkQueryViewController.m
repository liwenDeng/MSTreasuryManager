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

static NSString * const kLiveWorkLeaderCell = @"LiveWorkLeaderCell";
static NSString * const kLiveWorkMeetingCell = @"LiveWorkMeetingCell";
static NSString * const kLiveWorkNoteCell = @"LiveWorkNoteCell";

@interface MSLiveWorkQueryViewController () <MSBaseDatePickerViewDelegate>

@property (nonatomic, strong) UITextField *dateTextField;
@property (nonatomic, strong) MSBaseDatePickerView *datePickerView;

@end

@implementation MSLiveWorkQueryViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.title = @"现场工作查询";
    [self setupSubViews];
}

- (void)setupSubViews {
    
    [self.tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:kLiveWorkLeaderCell];
    [self.tableView registerClass:[MSLiveWorkMeetingCell class] forCellReuseIdentifier:kLiveWorkMeetingCell];
    [self.tableView registerClass:[MSLiveWorkNoteCell class] forCellReuseIdentifier:kLiveWorkNoteCell];
    self.tableView.contentInset = UIEdgeInsetsMake(20, 0, 0, 0);
    
    MSMaterialFillInNomalSection *section1 = [[MSMaterialFillInNomalSection alloc]initWithTitle:@"工作日期" placeholder:@"选择日期" canTouch:YES];
    self.dateTextField = section1.textField;
    section1.titleLabel.font = [UIFont systemFontOfSize:18];
    [section1.actionBtn addTarget:self action:@selector(chooseDate) forControlEvents:(UIControlEventTouchUpInside)];
    
    section1.frame = CGRectMake(0, 20, kSCREEN_WIDTH, 64);
    self.tableView.tableHeaderView = section1;
}

#pragma mark - UITableViewDataSource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 3;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    switch (section) {
        case 0:
            return 3;
            break;
        case 1:
        case 2:
            return 1;
        default:
            return 0;
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    switch (indexPath.section) {
        case 0:
        {
            UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:kLiveWorkLeaderCell forIndexPath:indexPath];
            cell.textLabel.text = @"XXX";
            [cell setAccessoryType:(UITableViewCellAccessoryDisclosureIndicator)];
            return cell;
        }
            break;
        case 1:
        {
            MSLiveWorkMeetingCell *cell = [tableView dequeueReusableCellWithIdentifier:kLiveWorkMeetingCell forIndexPath:indexPath];
            cell.contentLabel.text = @"短裤在家爱看了没打开市场经理卡就卡了死";
            return cell;
            
        }
            break;
        case 2:
        {
            MSLiveWorkNoteCell *cell = [tableView dequeueReusableCellWithIdentifier:kLiveWorkNoteCell forIndexPath:indexPath];
            cell.contentLabel.text = @"短裤在家爱看了没打开市场经理卡就卡了死手机卡上的健康教案上看到就爱看了世界的警察在下降快拉我的卡萨春节阿萨德";
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
            return @"工作负责人";
        case 1:
            return @"参会人员";
        case 2:
            return @"注意事项";
        default:
            return @"";
    }
}

#pragma mark - UITableViewDelegate
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    [tableView deselectRowAtIndexPath:indexPath animated:NO];
    
    switch (indexPath.section) {
        case 0:
        {
            MSLiveWorkQueryDetailViewController *detailVC = [[MSLiveWorkQueryDetailViewController alloc]init];
            [self.navigationController pushViewController:detailVC animated:YES];
        }
            break;
        case 1:
        {
            MSLiveWorkEditViewController *editVC = [[MSLiveWorkEditViewController alloc]initWithEditType:(MSEditTypeNote)];
            [self.navigationController pushViewController:editVC animated:YES];
        }
            break;
        case 2:
        {
            MSLiveWorkEditViewController *editVC = [[MSLiveWorkEditViewController alloc]initWithEditType:(MSEditTypeNote)];
            [self.navigationController pushViewController:editVC animated:YES];
        }
        default:
            break;
    }
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    switch (indexPath.section) {
        case 0:
            return 44;
            break;
        case 1:
        {
            return [tableView fd_heightForCellWithIdentifier:kLiveWorkMeetingCell configuration:^(MSLiveWorkMeetingCell * cell) {
                cell.contentLabel.text = @"短裤在家爱看了没打开市场经理卡就卡了死";
            }];
        }
            break;
        case 2:
        {
            return [tableView fd_heightForCellWithIdentifier:kLiveWorkNoteCell configuration:^(MSLiveWorkNoteCell * cell) {
                cell.contentLabel.text = @"短裤在家爱看了没打开市场经理卡就卡了死手机卡上的健康教案上看到就爱看了世界的警察在下降快拉我的卡萨春节阿萨德";
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

#pragma mark - tap action
- (void)chooseDate {
    [self showDatePickerView];
}

#pragma mark - MSBaseDatePickerViewDelegate
- (void)datePickerView:(MSBaseDatePickerView *)datePicker submitWithDate:(NSDate *)date {
    NSLog(@"date:%@",date);
    [self hideDatePickerView];
}

- (void)datePickerView:(MSBaseDatePickerView *)datePicker cancleWithDate:(NSDate *)date {
    [self hideDatePickerView];
}

- (void)showDatePickerView {
    if (self.datePickerView.hidden) {
        self.datePickerView.hidden = NO;
        [UIView animateWithDuration:0.3 delay:0 options:(UIViewAnimationOptionCurveEaseOut) animations:^{
            [self.datePickerView mas_updateConstraints:^(MASConstraintMaker *make) {
                make.top.equalTo(self.mas_bottomLayoutGuideBottom).offset(-244);
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
            make.height.mas_equalTo(200);
        }];
        _datePickerView.delegate = self;
        _datePickerView.hidden = YES;
        [self.view layoutIfNeeded];
    }
    return _datePickerView;
}

@end
