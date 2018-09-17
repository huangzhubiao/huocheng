//
//  YXWaterFlowLayout.h
//  huocheng
//
//  Created by ios on 2018/8/30.
//  Copyright © 2018年 ios. All rights reserved.
//

#import <UIKit/UIKit.h>
@class YXWaterFlowLayout;

/** 用代理模式从控制器那边获得cell的高度 */
@protocol YXWaterFlowLayout <NSObject>
/** 必须实现 */
- (CGFloat)waterFlowLayout:(YXWaterFlowLayout *)waterFlowLayout heightForWidth:(CGFloat)width AtIndexPath:(NSIndexPath *)indexpath;
@end

@interface YXWaterFlowLayout : UICollectionViewLayout

/** 四周间距 */
@property (nonatomic, assign) UIEdgeInsets sectionInset;
/** 水平cell间的间距 */
@property (nonatomic, assign) CGFloat marginX;

/** 竖直cell间的间距 */
@property (nonatomic, assign) CGFloat marginY;

/** 显示多少列 */
@property (nonatomic, assign) int colsCount;

@property (nonatomic, weak) id<YXWaterFlowLayout> delegate;

@end
