//
//  YLGoodsCollectionCell.h
//  YOULI
//
//  Created by FF on 15/8/30.
//  Copyright (c) 2015年 FF. All rights reserved.
//

#import <UIKit/UIKit.h>
@class YLGoods;

@interface YLGoodsCollectionCell : UICollectionViewCell
/** 单个瀑布流商品模型 */
@property (nonatomic, strong) YLGoods *good;
@end
