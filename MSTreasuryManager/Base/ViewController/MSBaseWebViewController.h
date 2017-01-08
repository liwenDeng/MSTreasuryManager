//
//  MSBaseWebViewController.h
//  MSTreasuryManager
//
//  Created by apple on 17/1/8.
//  Copyright © 2017年 邓利文. All rights reserved.
//

#import "MSBaseViewController.h"

@interface MSBaseWebViewController : MSBaseViewController <UIWebViewDelegate>

@property (nonatomic, strong) UIWebView *webView;

@end
