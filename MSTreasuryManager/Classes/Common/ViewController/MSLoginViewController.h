//
//  MSLoginViewController.h
//  MSTreasuryManager
//
//  Created by 邓利文 on 2016/10/25.
//  Copyright © 2016年 邓利文. All rights reserved.
//

#import "MSBaseViewController.h"
#import "MSAccountManager.h"

typedef void(^LoginSuccessCallback)(void);
typedef void(^LoginCancelCallback)(void);

@interface MSLoginViewController : MSBaseViewController

+ (void)loginSuccess:(LoginSuccessCallback)success failure:(LoginSuccessCallback)failure;

@end
