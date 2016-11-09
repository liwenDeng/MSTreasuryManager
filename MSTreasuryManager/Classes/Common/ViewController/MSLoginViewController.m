//
//  MSLoginViewController.m
//  MSTreasuryManager
//
//  Created by 邓利文 on 2016/10/25.
//  Copyright © 2016年 邓利文. All rights reserved.
//

#import "MSLoginViewController.h"
#import "MSLoginView.h"
#import "AppDelegate.h"
#import "MSBaseNavigationController.h"
#import "NSString+Code.h"
#import "MSAccountManager.h"

@interface MSLoginViewController () <MSLoginViewDelegate>

@property (nonatomic, strong) MSLoginView *loginView;

@property (nonatomic, copy) LoginSuccessCallback successCallback;
@property (nonatomic, copy) LoginCancelCallback cancelCallback;

@end

@implementation MSLoginViewController

- (void)dealloc {
    NSLog(@"login dealloc");
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    _loginView = ({
        MSLoginView *view = [[MSLoginView alloc]init];
        [self.view addSubview:view];
        
        [view mas_makeConstraints:^(MASConstraintMaker *make) {
            make.edges.equalTo(self.view);
        }];
        
        view;
    });
    
    _loginView.delegate = self;

    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(dismissKeyboardAction)];
//    tap.cancelsTouchesInView = NO;//防止tap影响subView响应事件
    [self.view addGestureRecognizer:tap];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [self.navigationController setNavigationBarHidden:YES animated:animated];
}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    [self.navigationController setNavigationBarHidden:NO animated:animated];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - MSLoginViewDelegate
- (void)loginView:(MSLoginView *)loginView cancleButtonClicked:(UIButton *)sender {
    
    MSWeakSelf(self, weakSelf);
    
    void(^completionBlock)(void) = ^ {
        if (weakSelf.cancelCallback) {
            weakSelf.cancelCallback();
        }
    };
    
    if (self.navigationController.presentingViewController) {
        [self.navigationController.presentingViewController dismissViewControllerAnimated:YES completion:completionBlock];
    }else {
        [self.navigationController dismissViewControllerAnimated:YES completion:completionBlock];
    }
}

- (void)loginView:(MSLoginView *)loginView loginButtonClicked:(UIButton *)sender userName:(NSString *)userName password:(NSString *)password{
    MSWeakSelf(self, weakSelf);
    
    [SVProgressHUD show];
     NSString *secPass = [[NSString stringWithFormat:@"%@abcd1234",password] ms_md5];
    [MSNetworking loginUserName:userName password:secPass success:^(NSDictionary *object) {
        [SVProgressHUD showSuccessWithStatus:@""];
        
        [[MSAccountManager sharedManager]loginWithUserName:nil userId:nil password:nil token:nil];
        
        void(^completionBlock)(void) = ^ {
            if (weakSelf.successCallback) {
                weakSelf.successCallback();
            }
        };
        
        if (self.navigationController.presentingViewController) {
            [self.navigationController.presentingViewController dismissViewControllerAnimated:YES completion:completionBlock];
        }else {
            [self.navigationController dismissViewControllerAnimated:YES completion:completionBlock];
        }
        
    } failure:^(NSError *error) {
        [SVProgressHUD showErrorWithStatus:@"登录失败"];
        void(^completionBlock)(void) = ^ {
            if (weakSelf.cancelCallback) {
                weakSelf.cancelCallback();
            }
        };
        
        if (self.navigationController.presentingViewController) {
            [self.navigationController.presentingViewController dismissViewControllerAnimated:YES completion:completionBlock];
        }else {
            [self.navigationController dismissViewControllerAnimated:YES completion:completionBlock];
        }
    }];
    

}

- (void)dismissKeyboardAction {
    [self.view endEditing:YES];
}

#pragma mark - Public
+ (void)loginSuccess:(LoginSuccessCallback)success failure:(LoginSuccessCallback)failure {
    AppDelegate *appDelegate = (AppDelegate *)[UIApplication sharedApplication].delegate;
    
    UIViewController *windowRoot = appDelegate.window.rootViewController;
    if ([windowRoot.presentedViewController isKindOfClass:[MSLoginViewController class]]) {
        return;
    }
    
    if ([windowRoot isMemberOfClass:[UITabBarController class]]) {
        UINavigationController *navController = ((UITabBarController *)windowRoot).selectedViewController;
        if ([navController isKindOfClass:[UINavigationController class]])
        {
            if ([navController.visibleViewController isKindOfClass:[MSLoginViewController class]])
            {
                return;
            }
        }
    }
    
    if ([windowRoot isKindOfClass:[UINavigationController class]])
    {
        if ([((UINavigationController *)windowRoot).visibleViewController isKindOfClass:[MSLoginViewController class]])
        {
            return;
        }
    }
    
    MSLoginViewController *login = [[MSLoginViewController alloc]init];
    login.successCallback = success;
    login.cancelCallback = failure;
    
    MSBaseNavigationController *loginNavi = [[MSBaseNavigationController alloc]initWithRootViewController:login];
    if (windowRoot.presentedViewController)
    {
        [windowRoot.presentedViewController presentViewController:loginNavi animated:YES completion:nil];
    }
    else
    {
        [windowRoot presentViewController:loginNavi animated:YES completion:nil];
    }
}

@end
