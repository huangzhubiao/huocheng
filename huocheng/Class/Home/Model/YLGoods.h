//
//  YLGoods.h
//  YOULI
//
//  Created by FF on 15/8/30.
//  Copyright (c) 2015年 FF. All rights reserved.
//

#import <Foundation/Foundation.h>
@class YLTotalDetail;
#import "YLTotalDetail.h"
@interface YLGoods : NSObject

/** 单个瀑布流商品的Width */
@property (nonatomic, assign) CGFloat w;
/** 单个瀑布流商品的Height */
@property (nonatomic, assign) CGFloat h;
/** 单个瀑布流商品的图片url */
@property (nonatomic, copy) NSString *img_url;
/** 单个瀑布流商品的左上角小图标url */
@property (nonatomic, copy) NSString *url;

/** 单个瀑布流商品的标签 */
@property (nonatomic, copy) NSString *title;

/** 单个瀑布流商品的价格 */
@property (nonatomic, copy) NSString *price;
/** 单个瀑布流商品的喜欢人数 */
@property (nonatomic, copy) NSString *count_like;

/** 详情页的所有数据 总模型 */
@property (nonatomic, strong) YLTotalDetail *totalDetail;
/** 商品ID */
@property (nonatomic, copy) NSString *good_id;

@end
