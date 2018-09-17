//
//  YLGoodsCollectionCell.m
//  YOULI
//
//  Created by FF on 15/8/30.
//  Copyright (c) 2015年 FF. All rights reserved.
//

#import "YLGoodsCollectionCell.h"
#import "YLGoods.h"
#import "UIImageView+WebCache.h"
@interface YLGoodsCollectionCell ()

@property (weak, nonatomic) IBOutlet UIImageView *goodImg;
@property (weak, nonatomic) IBOutlet UILabel *title;
@property (weak, nonatomic) IBOutlet UILabel *price;
@property (weak, nonatomic) IBOutlet UILabel *likeCount;
@property (weak, nonatomic) IBOutlet UIImageView *imageTag;


@end

@implementation YLGoodsCollectionCell


- (void)setGood:(YLGoods *)good
{
    _good = good;
    [self.goodImg sd_setImageWithURL:[NSURL URLWithString:good.url] placeholderImage:[UIImage imageNamed:@"common_banner_default"]];
    [self.imageTag sd_setImageWithURL:[NSURL URLWithString:good.img_url] placeholderImage:[UIImage imageNamed:@"common_banner_default"]];
    
    self.title.text = good.title;
    self.price.text = good.price;
    self.likeCount.text = good.count_like;
}


@end
