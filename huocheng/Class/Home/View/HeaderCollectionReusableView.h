//
//  HeaderCollectionReusableView.h
//  huocheng
//
//  Created by ios on 2018/9/3.
//  Copyright © 2018年 ios. All rights reserved.
//

#import <UIKit/UIKit.h>
@class HeaderCollectionReusableView;
/** 瀑布流前的head按钮 */
typedef enum {
    HeaderReusableViewTypePopular,
    HeaderReusableViewTypeHot,
    HeaderReusableViewTypeSelected
} HeaderCollectionReusableViewType;

@protocol HeaderCollectionReusableViewDelegate <NSObject>

- (void)headerCollectionReusableView:(HeaderCollectionReusableView *)reusableView buttonType:(HeaderCollectionReusableViewType)type;

@end
@interface HeaderCollectionReusableView : UICollectionReusableView
@property (nonatomic, weak) id<HeaderCollectionReusableViewDelegate> delegate;
@end
