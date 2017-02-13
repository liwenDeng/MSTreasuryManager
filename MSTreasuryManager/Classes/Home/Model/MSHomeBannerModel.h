//
//  MSHomeBannerModel.h
//  MSTreasuryManager
//
//  Created by apple on 17/1/6.
//  Copyright © 2017年 邓利文. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface MSHomeBannerModel : NSObject

@property (nonatomic, assign) NSInteger bannerId;
@property (nonatomic, copy)   NSString *img;    //banner图片地址
@property (nonatomic, copy)   NSString *url;
@property (nonatomic, assign) NSInteger cate;   //banner类型

@end
