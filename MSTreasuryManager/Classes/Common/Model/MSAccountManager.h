//
//  MSAccountManager.h
//  MSTreasuryManager
//
//  Created by 邓利文 on 2016/10/26.
//  Copyright © 2016年 邓利文. All rights reserved.
//

#import <Foundation/Foundation.h>

extern NSString * const kLoginMd5Key;

@interface MSAccountManager : NSObject

@property (nonatomic, copy, readonly) NSString * userName;
@property (nonatomic, copy, readonly) NSString * passWord;
@property (nonatomic, copy, readonly) NSString * token;
@property (nonatomic, assign, readonly) BOOL hasLogin;

+ (MSAccountManager *)sharedManager;

- (void)loginWithUserName:(NSString *)userName userId:(NSString *)userId password:(NSString *)password token:(NSString *)token;

- (void)logOut;

@end
