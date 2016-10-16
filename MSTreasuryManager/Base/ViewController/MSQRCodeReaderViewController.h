//
//  MSQRCodeReaderViewController.h
//  MSTreasuryManager
//
//  Created by apple on 16/10/15.
//  Copyright © 2016年 邓利文. All rights reserved.
//

#import "QRCodeReaderViewController.h"

@class MSQRCodeReaderViewController;
@protocol MSQRCodeReaderViewControllerDelegate <NSObject>

/**
 从相册读取的二维码
 */
- (void)codereader:(MSQRCodeReaderViewController*)reader photoScanResult:(NSString *)string;

@end

@interface MSQRCodeReaderViewController : QRCodeReaderViewController

@property (nonatomic, weak) id<MSQRCodeReaderViewControllerDelegate> photoReaderDelegate;

@end
