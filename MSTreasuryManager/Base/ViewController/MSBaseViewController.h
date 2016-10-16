//
//  MSBaseViewController.h
//  MyTemplateProject
//
//  Created by dengliwen on 16/8/2.
//  Copyright © 2016年 dengliwen. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol MSHTTPRequestDelegate <NSObject>

@optional
- (void)refresh;
- (void)loadMore;

@end

@protocol MSLoadQRScannButtonProtocol <NSObject>

- (void)qrscannerBtnClick;

@end


@interface MSBaseViewController : UIViewController <MSHTTPRequestDelegate>

@end
