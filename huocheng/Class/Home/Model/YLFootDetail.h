//
//  YLFootDetail.h
//  YOULI
//
//  Created by mac on 15/9/8.
//  Copyright (c) 2015年 FF. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface YLFootDetail : NSObject
/** 尾部店铺图片url */
@property (nonatomic, copy) NSString *shopUrl;
/** 尾部店铺name */
@property (nonatomic, copy) NSString *shopName;
/** 尾部店铺宝贝数量 */
@property (nonatomic, copy) NSString *goodCount;
/** 尾部店铺宝贝总销量 */
@property (nonatomic, copy) NSString *buyCount;

/** 尾部热销图片cell数组 */
@property (nonatomic, strong) NSArray *hotUrls;
@end
