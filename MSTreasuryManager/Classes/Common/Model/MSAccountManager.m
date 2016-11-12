//
//  MSAccountManager.m
//  MSTreasuryManager
//
//  Created by 邓利文 on 2016/10/26.
//  Copyright © 2016年 邓利文. All rights reserved.
//

#import "MSAccountManager.h"
#import "ZCApiRunner.h"

static MSAccountManager *account = nil;

NSString * const kLoginMd5Key = @"abcd1234";

static NSString * const kUserNameKey = @"MSUserName";
static NSString * const kPasswordKey = @"MSPassword";
static NSString * const kTokenKey    = @"MSToken";
static NSString * const kUserId      = @"MSUerId";

static NSString * const kHttpTokenKey = @"";

@interface MSAccountManager ()

@property (nonatomic, copy) NSString * userName;
@property (nonatomic, copy) NSString * passWord;
@property (nonatomic, copy) NSString * token;
@property (nonatomic, copy) NSString * userId;

@property (nonatomic, assign) BOOL hasLogin;

@end

@implementation MSAccountManager

+ (MSAccountManager *)sharedManager {
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        account = [[MSAccountManager alloc]init];
    });
    return account;
}

- (instancetype)init {
    if (self = [super init]) {
        [self loadAccountFromDB];
    }
    return self;
}

- (void)loadAccountFromDB {
    NSUserDefaults *userSets = [NSUserDefaults standardUserDefaults];
    NSString *userName = [userSets objectForKey:kUserNameKey];
    NSString *password = [userSets objectForKey:kPasswordKey];
    NSString *token = [userSets objectForKey:kTokenKey];
    
    _userName = userName;
    _passWord = password;
    _token = token;
    if (token) {
        self.hasLogin = YES;
    }
    //设置全局请求头
    [[ZCApiRunner sharedInstance] addValue:token forHeaderKey:@"token"];
}

- (void)loginWithUserName:(NSString *)userName userId:(NSString *)userId password:(NSString *)password token:(NSString *)token {
    
    [self saveUserName:userName userId:userId password:password token:token];
    self.hasLogin = token.length > 0;
    //设置全局请求头
    [[ZCApiRunner sharedInstance] addValue:token forHeaderKey:@"token"];
}

- (void)logOut {
    
    [self deleteAccountInfo];
    //设置全局请求头
    [[ZCApiRunner sharedInstance] removeHeaderKey:@"token"];
}

#pragma mark - Save
- (void)saveUserName:(NSString *)userName userId:(NSString *)userId password:(NSString *)password token:(NSString *)token {
    
    NSUserDefaults *userSets = [NSUserDefaults standardUserDefaults];
    [userSets setObject:userId forKey:kUserId];
    [userSets setObject:userName forKey:kUserNameKey];
    [userSets setObject:token forKey:kTokenKey];
    [userSets setObject:password forKey:kPasswordKey];
    
    [userSets synchronize];
    _userName = userName;
    _passWord = password;
    _userId = userId;
    _token = token;
}

#pragma mark - Delete
- (void)deleteAccountInfo {
    NSUserDefaults *userSets = [NSUserDefaults standardUserDefaults];
    [userSets removeObjectForKey:kTokenKey];
    [userSets removeObjectForKey:kUserNameKey];
    [userSets removeObjectForKey:kPasswordKey];
    [userSets removeObjectForKey:kUserId];
    
    [userSets synchronize];
    _token = nil;
    _userName = nil;
    _userId = nil;
    _passWord = nil;
    _hasLogin = NO;
}

- (void)deleteToken {
    NSUserDefaults *userSets = [NSUserDefaults standardUserDefaults];
    [userSets removeObjectForKey:kTokenKey];
    [userSets synchronize];
    _token = nil;
    _hasLogin = NO;
}

- (void)deleteUserName {
    NSUserDefaults *userSets = [NSUserDefaults standardUserDefaults];
    [userSets removeObjectForKey:kUserNameKey];
    [userSets synchronize];
    _userName = nil;
}

- (void)deletePassword {
    NSUserDefaults *userSets = [NSUserDefaults standardUserDefaults];
    [userSets removeObjectForKey:kPasswordKey];
    [userSets synchronize];
    _passWord = nil;
}

@end
