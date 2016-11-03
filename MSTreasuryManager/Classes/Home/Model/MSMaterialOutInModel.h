//
//  MSMaterialOutInModel.h
//  MSTreasuryManager
//
//  Created by 邓利文 on 2016/11/2.
//  Copyright © 2016年 邓利文. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface MSMaterialOutInModel : NSObject

@property (nonatomic, assign) NSInteger materialId;
@property (nonatomic, assign) NSInteger location; //1-二副库房，2-退库库房，3-系统库房
@property (nonatomic, assign) NSInteger count;
@property (nonatomic, assign) NSInteger cate;   //1-入 2-出

@property (nonatomic, copy) NSString *materialName;
@property (nonatomic, copy) NSString *operator;
@property (nonatomic, copy) NSString *auditor;
@property (nonatomic, copy) NSString *time;

+ (NSString *)storeNameWithLocationId:(NSInteger)location;

@end
