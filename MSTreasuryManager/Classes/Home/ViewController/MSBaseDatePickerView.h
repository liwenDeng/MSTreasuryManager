//
//  MSBaseDatePickerView.h
//  MSTreasuryManager
//
//  Created by apple on 16/10/12.
//  Copyright © 2016年 邓利文. All rights reserved.
//

#import <UIKit/UIKit.h>

@class MSBaseDatePickerView;

@protocol MSBaseDatePickerViewDelegate <NSObject>

- (void)datePickerView:(MSBaseDatePickerView *)datePicker submitWithDate:(NSDate *)date;
- (void)datePickerView:(MSBaseDatePickerView *)datePicker cancleWithDate:(NSDate *)date;

@end

@interface MSBaseDatePickerView : UIView

@property (nonatomic, weak) id<MSBaseDatePickerViewDelegate> delegate;

@end
