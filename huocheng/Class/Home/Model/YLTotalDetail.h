//
//  YLTotalDetail.h
//  YOULI
//
//  Created by mac on 15/9/8.
//  Copyright (c) 2015年 FF. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
@class YLHeadDetail, YLFootDetail;

@interface YLTotalDetail : NSObject
/** 头部数据模型 YLHeadDetail*/
@property (nonatomic, strong) YLHeadDetail *headDetail;

/** 尾部数据模型 YLFootDetail*/
@property (nonatomic, strong) YLFootDetail *footDetail;
@end
