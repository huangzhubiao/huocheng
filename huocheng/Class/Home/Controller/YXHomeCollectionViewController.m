//
//  YXHomeCollectionViewController.m
//  huocheng
//
//  Created by ios on 2018/8/29.
//  Copyright © 2018年 ios. All rights reserved.
//
#define ChiledVcHeight 1175
#import "YXHomeCollectionViewController.h"
#import "YXWaterFlowLayout.h"
#import "YLGoods.h"
#import "UIView+Extension.h"
#import "MJExtension.h"
#import "HeaderCollectionReusableView.h"
#import "YLGoodsCollectionCell.h"

@interface YXHomeCollectionViewController ()<YXWaterFlowLayout,HeaderCollectionReusableViewDelegate>

/** 存放商品的数组模型 */
@property (nonatomic, strong) NSMutableArray *goods;

@end

@implementation YXHomeCollectionViewController

- (NSMutableArray *)goods
{
    NSArray *arr;
    if(!_goods)
    {
        _goods = [NSMutableArray array];
    }
    [_goods addObjectsFromArray:arr];
    return _goods;
}

static NSString * const goodID = @"good";
static NSString * const headerID = @"waterHeader";
static NSString * const reuseIdentifier = @"Cell";
- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    self.collectionView.backgroundColor = [UIColor whiteColor];
    [self.collectionView registerNib:[UINib nibWithNibName:@"YLGoodsCollectionCell" bundle:nil] forCellWithReuseIdentifier:goodID];
    
    // 为瀑布流添加header
    [self.collectionView registerClass:[HeaderCollectionReusableView class] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:headerID];
    // 添加主页子控制器
    UIViewController *childVc = [[UIViewController alloc] init];
    childVc.view.frame = CGRectMake(0, 0, ScreenW, ChiledVcHeight);
    childVc.view.backgroundColor = [UIColor orangeColor];
    [self.collectionView addSubview:childVc.view];
    [self addChildViewController:childVc];
    
    [self loadMoreData];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];

}
#pragma mark - 初始化布局
- (instancetype)init
{
    YXWaterFlowLayout *waterLayout = [[YXWaterFlowLayout alloc] init];
    waterLayout.delegate = self;
    return [super initWithCollectionViewLayout:waterLayout];
}

#pragma mark <UICollectionViewDataSource>

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return self.goods.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    YLGoodsCollectionCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:goodID forIndexPath:indexPath];
    
    cell.good = self.goods[indexPath.item];
    return cell;
}
// 添加头部headerview
- (UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath
{
    UICollectionReusableView *reuseview = nil;
    if(kind == UICollectionElementKindSectionHeader)
    {
        HeaderCollectionReusableView *headview = [collectionView dequeueReusableSupplementaryViewOfKind:kind withReuseIdentifier:headerID forIndexPath:indexPath];
        headview.width = self.collectionView.width;
        headview.height = 35;
        headview.delegate = self;
        return headview;
    }
    return reuseview;
}
#pragma mark <UICollectionViewDelegate>


#pragma mark --YXWaterFlowLayout
- (CGFloat)waterFlowLayout:(YXWaterFlowLayout *)waterFlowLayout heightForWidth:(CGFloat)width AtIndexPath:(NSIndexPath *)indexpath
{
    YLGoods *good = self.goods[indexpath.item];
    return good.h/good.w * width;
}

// 刷新更多数据
- (void)loadMoreData
{
//    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.3 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
//        [self.goods addObjectsFromArray:[YLGoods objectArrayWithFilename:@"主页瀑布流1.plist"]];
//        [self.collectionView reloadData];
////        [self.collectionView footerEndRefreshing];
//    });
////    [self.collectionView reloadData];
    
    [self.goods addObjectsFromArray:[YLGoods objectArrayWithFilename:@"主页瀑布流1.plist"]];
    [self.collectionView reloadData];
    
}

#pragma mark - HeaderCollectionReusableViewDelegate 代理方法
- (void)headerCollectionReusableView:(HeaderCollectionReusableView *)reusableView buttonType:(HeaderCollectionReusableViewType)type
{
    [self.goods removeAllObjects];
    NSString *filename;
    switch (type) {
        case HeaderReusableViewTypePopular:
            filename = @"主页瀑布流1.plist";
            break;
        case HeaderReusableViewTypeHot:
            filename = @"主页瀑布流2.plist";
            break;
        case HeaderReusableViewTypeSelected:
            filename = @"主页瀑布流1.plist";
            break;
        default:
            break;
    }
    CGPoint point = self.collectionView.contentOffset;
    
    point.y = 1129;
    self.collectionView.contentOffset = point;
    
    
    NSArray *arr = [YLGoods objectArrayWithFilename:filename];
    
    [self.goods addObjectsFromArray:arr];
    
    [self.collectionView reloadData];
}
@end
