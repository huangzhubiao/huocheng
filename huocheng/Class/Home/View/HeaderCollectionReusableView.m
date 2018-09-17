//
//  HeaderCollectionReusableView.m
//  huocheng
//
//  Created by ios on 2018/9/3.
//  Copyright © 2018年 ios. All rights reserved.
//

#import "HeaderCollectionReusableView.h"
#import "UIView+Extension.h"
@interface HeaderCollectionReusableView ()
/** 当前按钮 */
@property (nonatomic, weak) UIButton *currentBtn;
@end

@implementation HeaderCollectionReusableView
- (instancetype)initWithFrame:(CGRect)frame
{
    if(self = [super initWithFrame:frame])
    {
        self.backgroundColor = YLColor(240, 240, 240);
        self.alpha = 0.5;
        // 添加3个按钮
        [self setupBtnWithTitle:@"本季流行" norTileColor:YLColor(142, 142, 142) selColor:YLColor(212, 119, 150) Type:HeaderReusableViewTypePopular];
        [self setupBtnWithTitle:@"人气热销" norTileColor:YLColor(142, 142, 142) selColor:YLColor(212, 119, 150) Type:HeaderReusableViewTypeHot];
        [self setupBtnWithTitle:@"为你精选" norTileColor:YLColor(142, 142, 142) selColor:YLColor(212, 119, 150) Type:HeaderReusableViewTypeSelected];
        
//        [YLNotification addObserver:self selector:@selector(switchNightModel:) name:@"日夜间模式" object:nil];
    }
    return self;
}
- (void)setupBtnWithTitle:(NSString *)title norTileColor:(UIColor *)norColor selColor:(UIColor *)selColor Type:(HeaderCollectionReusableViewType)type
{
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    btn.tag  = type;
    [btn setTitle:title forState:0];
    [btn setTitleColor:norColor forState:0];
    [btn setTitleColor:selColor forState:UIControlStateSelected];
//    btn.titleLabel.font = [UIFont fontWithName:@"FZLanTingHei-EL-GBK" size:14];
    
    btn.backgroundColor = [UIColor whiteColor];
    [self addSubview:btn];
    
    [btn addTarget:self action:@selector(clickheaderButton:) forControlEvents:UIControlEventTouchUpInside];
    
    if(type == HeaderReusableViewTypePopular)
        [self clickheaderButton:btn];
}
- (void)layoutSubviews
{
    [super layoutSubviews];
    for(int i=0;i<self.subviews.count;i++)
    {
        UIButton *btn = self.subviews[i];
        btn.width = self.width/3 - 0.5;
        btn.height = self.height;
        btn.x = i*self.width/3;
        btn.y = 0;
    }
}

- (void)clickheaderButton:(UIButton *)btn
{
    self.currentBtn.selected = NO;
    btn.selected = YES;
    self.currentBtn = btn;
    
    if([self.delegate respondsToSelector:@selector(headerCollectionReusableView:buttonType:)])
    {
        [self.delegate headerCollectionReusableView:self buttonType:(HeaderCollectionReusableViewType)btn.tag];
    }
    
}
@end
